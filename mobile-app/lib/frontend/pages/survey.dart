import 'dart:io';

import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile_app/backend/Blocs/in_app/in_app_bloc.dart';
import 'package:mobile_app/backend/Blocs/in_app/in_app_events.dart';
import 'package:mobile_app/backend/Blocs/in_app/in_app_state.dart';
import 'package:mobile_app/backend/Blocs/organization_view/organization_view_bloc.dart';
import 'package:mobile_app/backend/Blocs/task/task_bloc.dart';
import 'package:mobile_app/backend/Blocs/task_form/task_form_cubit.dart';
import 'package:mobile_app/backend/Blocs/user/user_bloc.dart';
import 'package:mobile_app/backend/callableModels/CallableModels.dart';
import 'package:mobile_app/backend/repositories/AppliedInterventionRepository.dart';
import 'package:mobile_app/backend/repositories/EntityRepository.dart';
import 'package:mobile_app/backend/repositories/ExecutedSurveyRepository.dart';
import 'package:mobile_app/backend/repositories/SurveyRepository.dart';
import 'package:mobile_app/backend/storage/image_synch.dart';
import 'package:mobile_app/frontend/buttons.dart';
import 'package:mobile_app/frontend/common_widgets.dart';
import 'package:mobile_app/frontend/components/audio/player_widget.dart';
import 'package:mobile_app/frontend/components/audio/recorder_widget.dart';
import 'package:mobile_app/frontend/components/imageWidget.dart';
import 'package:mobile_app/frontend/dependentsizes.dart';
import 'package:mobile_app/frontend/strings.dart';
import 'package:mobile_app/services/photo_capturing.dart';

import '../../backend/callableModels/ExecutedSurvey.dart';
import '../../backend/callableModels/Survey.dart';

typedef QuestionEditor = Function Function(Question question);

class AnimatedProgressBar extends StatefulWidget {
  final double progress;
  const AnimatedProgressBar(this.progress, {Key? key}) : super(key: key);

  @override
  State<AnimatedProgressBar> createState() => _AnimatedProgressBarState();
}

class AudioPlayerWidgetFromSyncFile extends StatefulWidget {
  final SyncedFile? syncedFile;
  const AudioPlayerWidgetFromSyncFile({Key? key, this.syncedFile})
      : super(key: key);

  @override
  State<AudioPlayerWidgetFromSyncFile> createState() =>
      _AudioPlayerWidgetFromSyncFileState();
}

class SurveyWidget extends StatefulWidget {
  final Survey survey;
  const SurveyWidget({Key? key, required this.survey}) : super(key: key);

  @override
  State<SurveyWidget> createState() => SurveyWidgetState();
}

class SurveyWidgetState extends State<SurveyWidget> {
  static const Key progressBarKey = Key('SurveyProgressBar');
  static const Key inSurveyPageViewKey = Key('InSurveyPageView');
  static const Duration _pageSlideDuration = Duration(milliseconds: 300);
  static const Curve _pageSlideCurve = Curves.easeInOut;

  final PageController _pageController = PageController();
  final PageController _inSurveyPageController = PageController();
  late SyncedFile syncedSurveyImageFile;

  Map<Question, QuestionAnswer> answers = {};
  late List<Question> questions;
  late final String preliminaryExecutedSurveyId;

  void addTask() async {
    return openTaskForm(
      entity: (context.read<InAppBloc>().state as SurveyInAppState).entity,
      context: context,
      taskBloc: context.read<TaskBloc>(),
      organizationViewBloc: context.read<OrganizationViewBloc>(),
      userBloc: context.read<UserBloc>(),
      appliedIntervention: (context.read<InAppBloc>().state as SurveyInAppState)
          .appliedIntervention,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Theme.of(context).canvasColor,
        child: SafeArea(
            child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: [
            surveyTitleWidget(
                context: context,
                surveyTitle: widget.survey.name,
                entityName: widget.survey.intervention?.name ?? '',
                imageFile: syncedSurveyImageFile,
                goBack: _leaveSurveyRegular,
                proceed: () {
                  _pageController.nextPage(
                      duration: _pageSlideDuration, curve: _pageSlideCurve);
                }),
            inSurveyWidget(),
            _summaryWidget(),
            endSurveyWidget(
                context: context,
                survey: widget.survey,
                answers: answers,
                onGoBack: () {
                  _pageController.previousPage(
                      duration: _pageSlideDuration, curve: _pageSlideCurve);
                },
                onProceed: () async {
                  await saveSurvey(
                      context: context,
                      answers: answers,
                      preliminaryId: preliminaryExecutedSurveyId,
                      survey: widget.survey);
                  _pageController.nextPage(
                      duration: _pageSlideDuration, curve: _pageSlideCurve);
                }),
            successFullyEndedSurvey(
                context: context, onProceed: _leaveSurveyRegular),
          ],
        )));
  }

  List<Widget> convertSurveyQuestionsToWidgetList(
      {required BuildContext context}) {
    return questions.map((e) {
      switch (e.type) {
        case QuestionType.SINGLECHOICE:
          return scQuestionWidget(
              context: context, question: e, survey: widget.survey);
        case QuestionType.MULTIPLECHOICE:
          return mcQuestionWidget(
              context: context, question: e, survey: widget.survey);
        case QuestionType.PICTURE:
          return takePhotoQuestionWidget(
              context: context, question: e, survey: widget.survey);
        case QuestionType.AUDIO:
          return takeAudioQuestionWidget(
              context: context, question: e, survey: widget.survey);
        case QuestionType.TEXT:
          return textQuestionWidget(
              context: context, question: e, survey: widget.survey);
        default:
          throw UnimplementedError();
      }
    }).toList();
  }

  @override
  void initState() {
    preliminaryExecutedSurveyId = UUID.getUUID();
    questions = widget.survey.questions
        .where((element) => !element.isFollowUpQuestion)
        .toList();
    _inSurveyPageController.addListener(() {
      setState(() {});
    });
    _pageController.addListener(() {
      setState(() {});
    });
    syncedSurveyImageFile = SurveyRepository.getSurveyPic(widget.survey);
    picAndAudioAnswerFiles = {};
    widget.survey.questions.forEach((element) {
      if (element.type == QuestionType.PICTURE) {
        picAndAudioAnswerFiles[element.id!] =
            ExecutedSurveyRepository.getQuestionAnswerPic(
                (context.read<InAppBloc>().state as SurveyInAppState)
                    .appliedIntervention,
                preliminaryExecutedSurveyId,
                element);
      } else if (element.type == QuestionType.AUDIO) {
        picAndAudioAnswerFiles[element.id!] =
            ExecutedSurveyRepository.getQuestionAnswerAudio(
                (context.read<InAppBloc>().state as SurveyInAppState)
                    .appliedIntervention,
                preliminaryExecutedSurveyId,
                element);
      }
    });
    super.initState();
  }

  Widget inSurveyWidget() {
    return Column(
      children: [
        SizedBox(
          height: defaultPadding(context),
        ),
        AnimatedProgressBar(
          _inSurveyPageController.hasClients
              ? _inSurveyPageController.page != null
                  ? ((_inSurveyPageController.page!.round() + 1) /
                      questions.length)
                  : 0
              : 0,
          key: progressBarKey,
        ),
        SizedBox(
          height: defaultPadding(context),
        ),
        addTaskWidget(
            context: context,
            surveyTitle: widget.survey.name,
            addTask: addTask),
        SizedBox(
          height: defaultPadding(context),
        ),
        CommonWidgets.separator(context: context),
        SizedBox(
          height: defaultPadding(context),
        ),
        Expanded(
          child: PageView(
              key: inSurveyPageViewKey,
              physics: const NeverScrollableScrollPhysics(),
              controller: _inSurveyPageController,
              children: convertSurveyQuestionsToWidgetList(context: context)),
        ),
        SizedBox(
          height: defaultPadding(context),
        ),
        bottomRowWidget(
            context: context,
            onGoBack: () {
              if (_inSurveyPageController.page?.round() != null) {
                int page = _inSurveyPageController.page!.round();
                if (page > 0) {
                  _inSurveyPageController.previousPage(
                      duration: _pageSlideDuration, curve: _pageSlideCurve);
                } else {
                  _pageController.previousPage(
                      duration: _pageSlideDuration, curve: _pageSlideCurve);
                }
              }
            },
            onDismiss: _dismissSurvey,
            onProceed: () {
              if (_inSurveyPageController.page?.round() != null) {
                Question currentQuestion =
                    questions[_inSurveyPageController.page!.round()];
                if (currentQuestion.type == QuestionType.MULTIPLECHOICE) {
                  answers[currentQuestion] ??= QuestionAnswer(
                      questionID: widget.survey.id!,
                      date: DateTime.now(),
                      type: currentQuestion.type);
                }
                if (answers[currentQuestion] != null) {
                  //check for followUpQuestions
                  if (currentQuestion.type == QuestionType.SINGLECHOICE) {
                    String? followUpID = answers[currentQuestion]!
                        .questionOptions!
                        .first
                        .followUpQuestionID;
                    if (followUpID != null) {
                      List<Question> followUpQuestions = widget.survey.questions
                          .where((element) => element.id == followUpID)
                          .toList();
                      if (followUpQuestions.isNotEmpty) {
                        if (!questions.contains(followUpQuestions.first)) {
                          setState(() {
                            questions.insert(
                                questions.indexOf(currentQuestion) + 1,
                                followUpQuestions.first);
                          });
                        }
                      }
                    }
                    questions.removeWhere((element) {
                      bool result = element.isFollowUpQuestion &&
                          element.id != followUpID;
                      if (result) {
                        answers.remove(element);
                      }
                      return result;
                    });
                  }
                  _proceedToNextPage(currentQuestion);
                }

                if (currentQuestion.type == QuestionType.AUDIO ||
                    currentQuestion.type == QuestionType.PICTURE) {
                  //TODO: connect answers properly
                  _proceedToNextPage(currentQuestion);
                }
              }
            }),
        SizedBox(
          height: defaultPadding(context),
        ),
      ],
    );
  }

  late Map<String, SyncedFile> picAndAudioAnswerFiles;

  Widget mcQuestionWidget(
      {required BuildContext context,
      required Question question,
      required Survey survey}) {
    return Scrollbar(
        child: ListView(
      shrinkWrap: true,
      children: [
        imageForQuestion(
            syncedFile: SurveyRepository.getQuestionPic(survey, question)),
        SizedBox(
          height: defaultPadding(context),
        ),
        questionTitleWidget(question: question, context: context),
        SizedBox(
          height: defaultPadding(context),
        ),
        ...List.generate(
            question.questionOptions!.length,
            (index) => MaterialButton(
                  onPressed: () {
                    setState(() {
                      if (answers[question] != null) {
                        if (!answers[question]!
                            .questionOptions!
                            .contains(question.questionOptions![index])) {
                          answers[question]!
                              .questionOptions!
                              .add(question.questionOptions![index]);
                        } else {
                          answers[question]!
                              .questionOptions!
                              .remove(question.questionOptions![index]);
                        }
                      } else {
                        answers[question] = QuestionAnswer(
                            questionID: question.id!,
                            date: DateTime.now(),
                            type: question.type)
                          ..questionOptions = [
                            question.questionOptions![index]
                          ];
                      }
                    });
                  },
                  padding: EdgeInsets.zero,
                  child: Padding(
                    padding: EdgeInsets.all(defaultPadding(context)),
                    child: Row(
                      children: [
                        Icon(() {
                          if (answers[question] != null) {
                            if (answers[question]!
                                .questionOptions!
                                .contains(question.questionOptions![index])) {
                              return MdiIcons.checkboxMarked;
                            }
                          }
                          return MdiIcons.checkboxBlankOutline;
                        }.call()),
                        SizedBox(
                          width: defaultPadding(context),
                        ),
                        Flexible(
                            child: Text(question.questionOptions![index].text,
                                style: Theme.of(context).textTheme.bodyText1)),
                      ],
                    ),
                  ),
                )),
      ],
    ));
  }

  Widget scQuestionWidget(
      {required BuildContext context,
      required Question question,
      required Survey survey}) {
    return Scrollbar(
        child: ListView(
      shrinkWrap: true,
      children: [
        imageForQuestion(
            syncedFile: SurveyRepository.getQuestionPic(survey, question)),
        SizedBox(
          height: defaultPadding(context),
        ),
        questionTitleWidget(question: question, context: context),
        SizedBox(
          height: defaultPadding(context),
        ),
        ...List.generate(
            question.questionOptions!.length,
            (index) => MaterialButton(
                  padding: EdgeInsets.zero,
                  child: Padding(
                    padding: EdgeInsets.all(defaultPadding(context)),
                    child: Row(
                      children: [
                        Radio<QuestionOption>(
                          value: question.questionOptions![index],
                          groupValue: answers[question]?.questionOptions!.first,
                          onChanged: (a) {
                            setState(() {
                              if (answers[question] == null) {
                                answers[question] = QuestionAnswer(
                                    questionID: question.id!,
                                    date: DateTime.now(),
                                    type: question.type)
                                  ..questionOptions = [
                                    question.questionOptions![index]
                                  ];
                              } else {
                                answers[question]!.questionOptions = [
                                  question.questionOptions![index]
                                ];
                              }
                            });
                          },
                        ),
                        SizedBox(
                          width: defaultPadding(context),
                        ),
                        Flexible(
                            child: Text(
                          question.questionOptions![index].text,
                          style: Theme.of(context).textTheme.bodyText1,
                        )),
                      ],
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      if (answers[question] == null) {
                        answers[question] = QuestionAnswer(
                            questionID: question.id!,
                            date: DateTime.now(),
                            type: question.type)
                          ..questionOptions = [
                            question.questionOptions![index]
                          ];
                      } else {
                        answers[question]!.questionOptions = [
                          question.questionOptions![index]
                        ];
                      }
                    });
                  },
                ))
      ],
    ));
  }

  Widget takeAudioQuestionWidget(
      {required BuildContext context,
      required Question question,
      required Survey survey}) {
    return Scrollbar(
        child: ListView(
      shrinkWrap: true,
      children: [
        imageForQuestion(
            syncedFile: SurveyRepository.getQuestionPic(survey, question)),
        SizedBox(
          height: defaultPadding(context),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding(context)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(question.text),
              ),
              getReadOutWidget(question: question),
            ],
          ),
        ),
        SizedBox(
          height: defaultPadding(context) * 2,
        ),
        AudioPlayerWidgetFromSyncFile(
          key: picAndAudioAnswerFiles[question.id!]!.key,
          syncedFile: picAndAudioAnswerFiles[question.id!],
        ),
        SizedBox(
          height: defaultPadding(context),
        ),
        getTakeAudioWidget(
          syncedFile: picAndAudioAnswerFiles[question.id!]!,
          callback: (sF) async {
            setState(() {
              picAndAudioAnswerFiles[question.id!] = sF;
            });
            if (answers[question] == null) {
              answers[question] = QuestionAnswer(
                  questionID: question.id!,
                  date: DateTime.now(),
                  type: question.type);
            }
          },
          context: context,
        )
      ],
    ));
  }

  Widget takePhotoQuestionWidget(
      {required BuildContext context,
      required Question question,
      required Survey survey}) {
    return Scrollbar(
        child: ListView(
      shrinkWrap: true,
      children: [
        imageForQuestion(
            syncedFile: SurveyRepository.getQuestionPic(survey, question)),
        SizedBox(
          height: defaultPadding(context),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding(context)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(question.text,
                    style: Theme.of(context).textTheme.bodyText1),
              ),
              getReadOutWidget(question: question),
            ],
          ),
        ),
        SizedBox(
          height: defaultPadding(context) * 2,
        ),
        ImageFromSyncedFile(
            key: picAndAudioAnswerFiles[question.id]!.key,
            syncedFile: picAndAudioAnswerFiles[question.id]!),
        SizedBox(
          height: defaultPadding(context),
        ),
        getTakePhotoWidget(
          syncedFile: picAndAudioAnswerFiles[question.id!]!,
          callback: (sF) async {
            setState(() {
              picAndAudioAnswerFiles[question.id!] = sF;
            });
            if (answers[question] == null) {
              answers[question] = QuestionAnswer(
                  questionID: question.id!,
                  date: DateTime.now(),
                  type: question.type);
            }
          },
          context: context,
        ),
      ],
    ));
  }

  Widget textQuestionWidget(
      {required BuildContext context,
      required Question question,
      required Survey survey}) {
    return Scrollbar(
        child: ListView(
      shrinkWrap: true,
      children: [
        imageForQuestion(
            syncedFile: SurveyRepository.getQuestionPic(survey, question)),
        SizedBox(
          height: defaultPadding(context),
        ),
        questionTitleWidget(question: question, context: context),
        SizedBox(
          height: defaultPadding(context),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding(context)),
          child: TextField(
            maxLines: 5,
            onChanged: (String result) {
              answers[question] = QuestionAnswer(
                  questionID: question.id!,
                  date: DateTime.now(),
                  type: QuestionType.TEXT)
                ..text = result;
            },
          ),
        ),
      ],
    ));
  }

  void _dismissSurvey() async {
    bool confirmation = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title:
                Text(abortSurvey, style: Theme.of(context).textTheme.headline2),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    abortSurveyText,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                SizedBox(
                  height: defaultPadding(context),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                        child: Padding(
                          padding: EdgeInsets.all(defaultPadding(context)),
                          child: Text(
                            confirmAbort,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        }),
                    MaterialButton(
                        child: Padding(
                          padding: EdgeInsets.all(defaultPadding(context)),
                          child: Text(
                            doNotAbort,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        }),
                  ],
                ),
              ],
            )));
    if (confirmation) {
      BlocProvider.of<InAppBloc>(context).add(MainViewEvent());
    }
  }

  void _leaveSurveyRegular() {
    BlocProvider.of<InAppBloc>(context).add(MainViewEvent());
  }

  void _goToInSurveyPage(Question targetQuestion) async {
    if (!questions.contains(targetQuestion)) {
      throw 'Question does not exist';
    }
    await _pageController.animateToPage(1,
        duration: _pageSlideDuration, curve: _pageSlideCurve);
    _inSurveyPageController.jumpToPage(questions.indexOf(targetQuestion));
  }

  void _proceedToNextPage(Question currentQuestion) {
    if (questions.indexOf(currentQuestion) == questions.length - 1) {
      _pageController.nextPage(
          duration: _pageSlideDuration, curve: _pageSlideCurve);
    } else {
      _inSurveyPageController.nextPage(
          duration: _pageSlideDuration, curve: _pageSlideCurve);
    }
  }

  Widget _summaryWidget() {
    return summaryWidget(
        context: context,
        progress: _inSurveyPageController.hasClients
            ? _inSurveyPageController.page != null
                ? ((_inSurveyPageController.page!.round() + 1) /
                    questions.length)
                : 0
            : 0,
        survey: widget.survey,
        executedSurveyId: preliminaryExecutedSurveyId,
        picAndAudioAnswerFiles: picAndAudioAnswerFiles,
        appliedIntervention:
            (context.read<InAppBloc>().state as SurveyInAppState)
                .appliedIntervention,
        answers: answers,
        onEditGenerator: (Question question) {
          return () {
            _goToInSurveyPage(question);
          };
        },
        onDismiss: _dismissSurvey,
        onProceed: () {
          _pageController.nextPage(
              duration: _pageSlideDuration, curve: _pageSlideCurve);
        });
  }

  static Widget addTaskWidget(
      {required BuildContext context,
      required String surveyTitle,
      required Function addTask}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding(context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            surveyTitle,
            style: Theme.of(context).textTheme.headline2,
          ),
          MaterialButton(
              onPressed: () {
                addTask();
              },
              padding: EdgeInsets.zero,
              child: Container(
                height: 50,
                width: 50,
                child: Stack(
                  fit: StackFit.passthrough,
                  children: [
                    const Align(
                      alignment: Alignment.bottomLeft,
                      child: Icon(
                        MdiIcons.checkboxMarkedOutline,
                        size: 45,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          MdiIcons.plus,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  static Widget bottomRowWidget(
      {required BuildContext context,
      required Function onGoBack,
      required Function onDismiss,
      required Function onProceed}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding(context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonWidgets.defaultBackwardButton(
              context: context, goBack: onGoBack),
          CommonWidgets.defaultDismissButton(
              context: context, dismiss: onDismiss),
          CommonWidgets.defaultForwardButton(
              context: context, proceed: onProceed),
        ],
      ),
    );
  }

  static Widget endSurveyWidget(
      {required BuildContext context,
      required Survey survey,
      required Map<Question, QuestionAnswer> answers,
      required Function onGoBack,
      required Function onProceed}) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.all(defaultPadding(context)),
            child: Text(
              endSurvey,
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(defaultPadding(context)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonWidgets.defaultBackwardButton(
                  context: context, goBack: onGoBack),
              CommonWidgets.defaultForwardButton(
                  context: context, proceed: onProceed),
            ],
          ),
        ),
      ],
    ));
  }

  static Widget getEditQuestionWidget(
      {required BuildContext context, required onEdit}) {
    return CustomIconButton(() {
      onEdit();
    }, MdiIcons.pencil, const Size(50, 50), true);
  }

  static Widget getReadOutWidget({required Question question}) {
    return Container();
  }

  static Widget getTakeAudioWidget(
      {required SyncedFile syncedFile,
      required ValueChanged<SyncedFile> callback,
      required BuildContext context}) {
    return RecorderWidget(
        restingViewBuilder: (a) => Container(
              child: Icon(
                MdiIcons.record,
              ),
            ),
        recordingViewBuilder: (a) => Container(
              child: Icon(MdiIcons.pause),
            ),
        onAudioRecorded: (path) async {
          await syncedFile.updateAsAudio(File(path));
          callback(syncedFile);
        },
        loadingViewBuilder: () => Container());
    return MaterialButton(
      onPressed: () {},
      child: Container(
        child: const Icon(
          MdiIcons.microphone,
          size: 40,
        ),
      ),
    );
  }

  static Widget getTakePhotoWidget(
      {required SyncedFile syncedFile,
      required ValueChanged<SyncedFile> callback,
      required BuildContext context}) {
    //return CustomIconButton(onPressed, iconData, size, true)
    return CustomIconButton(() async {
      XFile? r = await CameraFunctionality.takePicture(context: context);
      if (r != null) {
        await syncedFile.updateAsPic(r);
        callback.call(syncedFile);
      }
    }, MdiIcons.camera, const Size(50, 50), true);
  }

  static ImageFromSyncedFile imageForQuestion(
      {required SyncedFile syncedFile}) {
    return ImageFromSyncedFile(syncedFile: syncedFile, key: ValueKey(0));
  }

  static Widget questionSummary(
      {Function? onEdit,
      required Question question,
      SyncedFile? syncedFile,
      QuestionAnswer? questionAnswer,
      required AppliedIntervention appliedIntervention,
      required String executedSurveyId,
      required BuildContext context}) {
    if (question.isFollowUpQuestion) {
      if (questionAnswer == null) {
        return Container();
      }
    }

    Widget answerWidget;

    if (questionAnswer != null) {
      switch (question.type) {
        case QuestionType.SINGLECHOICE:
          answerWidget = Text(questionAnswer.questionOptions!.first.text,
              style: Theme.of(context).textTheme.bodyText1);
          break;
        case QuestionType.MULTIPLECHOICE:
          String answers = '';
          for (QuestionOption questionOption
              in questionAnswer.questionOptions!) {
            answers += '${questionOption.text}, ';
          }
          if (answers.length > 2) {
            answers = answers.substring(0, answers.length - 2);
          }
          answerWidget =
              Text(answers, style: Theme.of(context).textTheme.bodyText1);
          break;
        case QuestionType.PICTURE:
          answerWidget = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: defaultPadding(context),
              ),
              Text(yourShot, style: Theme.of(context).textTheme.bodyText1),
              SizedBox(
                height: defaultPadding(context),
              ),
              ImageFromSyncedFile(syncedFile: syncedFile, key: syncedFile?.key),
            ],
          );
          break;
        case QuestionType.TEXT:
          answerWidget = Text(questionAnswer.text ?? '',
              style: Theme.of(context).textTheme.bodyText1);
          break;
        case QuestionType.AUDIO:
          answerWidget = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: defaultPadding(context),
              ),
              Text(yourShot, style: Theme.of(context).textTheme.bodyText1),
              SizedBox(
                height: defaultPadding(context),
              ),
              AudioPlayerWidgetFromSyncFile(
                  key: syncedFile?.key, syncedFile: syncedFile)
            ],
          );
          break;
        default:
          answerWidget = Container();
          break;
      }
    } else {
      answerWidget = Container();
    }

    if (questionAnswer != null) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Padding(
                padding: EdgeInsets.only(bottom: defaultPadding(context)) * 1,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: defaultPadding(context)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        question.text,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      if (questionAnswer != null &&
                          ((questionAnswer.type ==
                                      QuestionType.MULTIPLECHOICE &&
                                  questionAnswer.questionOptions!.isNotEmpty) ||
                              questionAnswer.type ==
                                  QuestionType.SINGLECHOICE ||
                              questionAnswer.type == QuestionType.TEXT))
                        SizedBox(
                          height: defaultPadding(context),
                        ),
                      answerWidget,
                    ],
                  ),
                ),
              )),
              if (onEdit != null)
                Padding(
                    padding: EdgeInsets.fromLTRB(
                      defaultPadding(context) * 2,
                      defaultPadding(context),
                      0,
                      defaultPadding(context),
                    ),
                    child:
                        getEditQuestionWidget(context: context, onEdit: onEdit))
            ],
          ),
          CommonWidgets.separator(context: context),
          SizedBox(
            height: defaultPadding(context),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  static Widget questionTitleWidget(
      {required Question question, required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding(context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  question.text,
                  style: Theme.of(context).textTheme.headline2,
                ),
                SizedBox(
                  height: defaultPadding(context),
                ),
                Text(
                  resolveQuestionTypeDescriptionFromQuestion(
                      question: question),
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
          getReadOutWidget(question: question),
        ],
      ),
    );
  }

  static String resolveQuestionTypeDescriptionFromQuestion(
      {required Question question}) {
    switch (question.type) {
      case QuestionType.SINGLECHOICE:
        return singleChoiceTypeDescription;
      case QuestionType.MULTIPLECHOICE:
        return multipleChoiceTypeDescription;
      case QuestionType.TEXT:
        return textFieldTypeDescription;
      default:
        return '';
    }
  }

  static Future<void> saveSurvey(
      {required Survey survey,
      required Map<Question, QuestionAnswer> answers,
      required BuildContext context,
      String? preliminaryId}) async {
    List<QuestionAnswer> surveyAnswersAsList = [];
    for (Question question in survey.questions) {
      if (answers.keys.any((element) => element.id == question.id)) {
        surveyAnswersAsList.add(QuestionAnswer(
            questionID: question.id!,
            date: DateTime.now(),
            type: question.type));
      }
    }
    /*List.generate(
        survey.questions.length,
        (index) => QuestionAnswer(
            questionID: survey.questions[index].id!,
            date: DateTime.now(),
            type: survey.questions[index].type));*/
    for (MapEntry<Question, QuestionAnswer> pair in answers.entries) {
      int toReplace = surveyAnswersAsList
          .indexWhere((element) => element.questionID == pair.key.id);
      if (toReplace < 0) {
        throw 'Answer for question that is not in survey ${survey.name} was given and assigned to this survey';
      }
      surveyAnswersAsList[toReplace] = pair.value;
    }
    //todo: add location
    var surveyState = context.read<InAppBloc>().state as SurveyInAppState;
    var userState = context.read<UserBloc>().state;
    ExecutedSurvey executedSurvey = ExecutedSurvey(
        id: preliminaryId,
        appliedIntervention: surveyState.appliedIntervention,
        survey: survey,
        whoExecutedIt: userState.user!,
        date: DateTime.now(),
        answers: surveyAnswersAsList);
    context.read<InAppBloc>().add(FinishAndSaveExecutedSurvey(
        executedSurvey,
        surveyState.appliedIntervention,
        (context.read<InAppBloc>().state as SurveyInAppState).entity,
        context.read<OrganizationViewBloc>()));
  }

  static Widget successFullyEndedSurvey(
      {required BuildContext context, required Function onProceed}) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.all(defaultPadding(context)),
            child: Text(
              savedSurvey,
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(defaultPadding(context)),
          child: Align(
            alignment: Alignment.centerRight,
            child: CommonWidgets.defaultForwardButton(
                context: context, proceed: onProceed),
          ),
        ),
      ],
    ));
  }

  static Widget summaryWidget(
      {required BuildContext context,
      double? progress,
      required Survey survey,
      required Map<Question, QuestionAnswer> answers,
      required Map<String, SyncedFile> picAndAudioAnswerFiles,
      required AppliedIntervention appliedIntervention,
      required String executedSurveyId,
      QuestionEditor? onEditGenerator,
      onDismiss,
      onProceed}) {
    return Column(
      children: [
        SizedBox(
          height: defaultPadding(context),
        ),
        if (progress != null)
          AnimatedProgressBar(
            progress,
            key: progressBarKey,
          ),
        SizedBox(
          height: defaultPadding(context),
        ),
        Flexible(
          flex: 0,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: defaultPadding(context)),
              child: Text(
                '${survey.name} $summary',
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
          ),
        ),
        SizedBox(
          height: defaultPadding(context),
        ),
        CommonWidgets.separator(context: context),
        Expanded(
          child: Scrollbar(
              child: ListView(
            children: [
              SizedBox(
                height: defaultPadding(context),
              ),
              ...List.generate(
                  survey.questions.length,
                  (index) => questionSummary(
                      appliedIntervention: appliedIntervention,
                      executedSurveyId: executedSurveyId,
                      question: survey.questions[index],
                      questionAnswer: answers[survey.questions[index]],
                      syncedFile:
                          picAndAudioAnswerFiles[survey.questions[index].id],
                      context: context,
                      onEdit: onEditGenerator != null
                          ? onEditGenerator(survey.questions[index])
                          : null))
            ],
          )),
        ),
        if (!(onProceed == null && onDismiss == null))
          Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding(context)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonWidgets.defaultDismissButton(
                    context: context, dismiss: onDismiss),
                CommonWidgets.defaultForwardButton(
                    context: context, proceed: onProceed),
              ],
            ),
          ),
        if (!(onProceed == null && onDismiss == null))
          SizedBox(
            height: defaultPadding(context),
          ),
      ],
    );
  }

  static Widget surveyTitleWidget(
      {required BuildContext context,
      required String surveyTitle,
      required String entityName,
      required SyncedFile imageFile,
      required Function proceed,
      required Function goBack}) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(defaultPadding(context)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CommonWidgets.defaultBackwardButton(
                  context: context, goBack: goBack),
              SizedBox(
                width: defaultPadding(context),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    surveyTitle,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Text(
                    entityName,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ],
              ),
            ],
          ),
        ),
        CommonWidgets.separator(context: context),
        SizedBox(
          height: defaultPadding(context),
        ),
        ImageFromSyncedFile(
          syncedFile: imageFile,
        ),
        SizedBox(
          height: defaultPadding(context) * 2,
        ),
        Expanded(child: Container()),
        Padding(
          padding: EdgeInsets.all(defaultPadding(context)),
          child: CommonWidgets.defaultForwardButton(
              context: context,
              buttonSizes: ButtonSizes.large,
              proceed: proceed),
        ),
      ],
    );
  }
}

class _AnimatedProgressBarState extends State<AnimatedProgressBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 20,
        margin: EdgeInsets.symmetric(horizontal: defaultPadding(context)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.green, width: 1),
        ),
        alignment: Alignment.centerLeft,
        child: FractionallySizedBox(
          widthFactor: _animationController.value,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ));
  }

  @override
  void didUpdateWidget(covariant AnimatedProgressBar oldWidget) {
    if (widget.progress != oldWidget.progress) {
      _animationController.value = oldWidget.progress;
      _animationController.animateTo(widget.progress);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        value: widget.progress)
      ..addListener(() {
        setState(() {});
      });

    super.initState();
  }
}

class _AudioPlayerWidgetFromSyncFileState
    extends State<AudioPlayerWidgetFromSyncFile> {
  @override
  Widget build(BuildContext context) {
    return audioFile == null
        ? Container()
        : PlayerWidget(
            audioURL: audioFile!.path,
            restingViewBuilder: (a) => const Icon(MdiIcons.play),
            loadingViewBuilder: () => Container(),
            playingViewBuilder: (a) => const Icon(MdiIcons.pause));
  }

  bool loading = true;
  File? audioFile;

  @override
  void initState() {
    print("reinitializing image widget");
    widget.syncedFile?.file().then((value) async {
      audioFile = value;
      if (mounted) {
        setState(() {
          audioFile = audioFile;
          loading = false;
        });
      } else {
        audioFile = audioFile;
        loading = false;
      }
    });
  }
}
