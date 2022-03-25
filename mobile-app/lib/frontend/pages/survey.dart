import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile_app/backend/Blocs/in_app/in_app_bloc.dart';
import 'package:mobile_app/backend/Blocs/in_app/in_app_events.dart';
import 'package:mobile_app/backend/Blocs/in_app/in_app_state.dart';
import 'package:mobile_app/backend/Blocs/user/user_bloc.dart';
import 'package:mobile_app/backend/callableModels/CallableModels.dart';
import 'package:mobile_app/frontend/buttons.dart';
import 'package:mobile_app/frontend/common_widgets.dart';
import 'package:mobile_app/frontend/components/imageWidget.dart';
import 'package:mobile_app/frontend/dependentsizes.dart';
import 'package:mobile_app/frontend/strings.dart';
import 'package:mobile_app/services/photo_capturing.dart';
import '../../backend/callableModels/ExecutedSurvey.dart';
import '../../backend/callableModels/Survey.dart';

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
  late final Image surveyImage;

  Map<Question, QuestionAnswer> answers = {};
  late List<Question> questions;

  @override
  void initState() {
    surveyImage = Image.asset('assets/test/demo_pic.jpg');
    questions = widget.survey.questions
        .where((element) => !element.isFollowUpQuestion)
        .toList();
    _inSurveyPageController.addListener(() {
      setState(() {});
    });
    _pageController.addListener(() {
      setState(() {});
    });
    super.initState();
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
                image: surveyImage,
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
                      answers: answers.values.toList(),
                      survey: widget.survey);
                  _pageController.nextPage(
                      duration: _pageSlideDuration, curve: _pageSlideCurve);
                }),
            successFullyEndedSurvey(
                context: context, onProceed: _leaveSurveyRegular),
          ],
        )));
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
              style: Theme.of(context).textTheme.bodyText1,
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
              style: Theme.of(context).textTheme.bodyText1,
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
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
        ),
        SizedBox(
          height: defaultPadding(context),
        ),
        Expanded(
          child: ListView(
            children: [
              SizedBox(
                height: defaultPadding(context),
              ),
              ...List.generate(
                  survey.questions.length,
                  (index) => questionSummary(
                      question: survey.questions[index],
                      questionAnswer: answers[survey.questions[index]],
                      context: context,
                      onEdit: onEditGenerator != null
                          ? onEditGenerator(survey.questions[index])
                          : null))
            ],
          ),
        ),
        if(!(onProceed==null&&onDismiss==null)) Padding(
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
        if(!(onProceed==null&&onDismiss==null)) SizedBox(
          height: defaultPadding(context),
        ),
      ],
    );
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

  static Widget questionSummary(
      {Function? onEdit,
      required Question question,
      QuestionAnswer? questionAnswer,
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
          answerWidget = Text(questionAnswer.questionOptions!.first.text);
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
          answerWidget = Text(answers);
          break;
        case QuestionType.PICTURE:
          answerWidget = imageForQuestion(question: question);
          break;
        case QuestionType.TEXT:
          answerWidget = Text(questionAnswer.text!);
          break;
        default:
          answerWidget = Container();
          break;
      }
    } else {
      answerWidget = Container();
    }

    return Row(
      children: [
        Expanded(
            child: Padding(
          padding: EdgeInsets.only(bottom: defaultPadding(context)) * 2,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  question.text,
                  style: Theme.of(context).textTheme.bodyText1,
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
              child: getEditQuestionWidget(context: context, onEdit: onEdit))
      ],
    );
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

  void _proceedToNextPage(Question currentQuestion) {
    if (questions.indexOf(currentQuestion) == questions.length - 1) {
      _pageController.nextPage(
          duration: _pageSlideDuration, curve: _pageSlideCurve);
    } else {
      _inSurveyPageController.nextPage(
          duration: _pageSlideDuration, curve: _pageSlideCurve);
    }
  }

  void _goToInSurveyPage(Question targetQuestion) async {
    if (!questions.contains(targetQuestion)) {
      throw 'Question does not exist';
    }
    await _pageController.animateToPage(1,
        duration: _pageSlideDuration, curve: _pageSlideCurve);
    _inSurveyPageController.jumpToPage(questions.indexOf(targetQuestion));
  }

  void _dismissSurvey() async{
    bool confirmation = await showDialog(context: context, builder: (context) => AlertDialog(
      title: Text(abortSurvey, style: Theme.of(context).textTheme.bodyText1),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              abortSurveyText
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
                    child: Text(confirmAbort, style: Theme.of(context).textTheme.bodyText1,),
                  ),
                  onPressed: (){
                  Navigator.of(context).pop(true);
              }),
              MaterialButton(

                  child: Padding(
                    padding: EdgeInsets.all(defaultPadding(context)),
                    child: Text(doNotAbort, style: Theme.of(context).textTheme.bodyText1,),
                  ),
                  onPressed: (){
                    Navigator.of(context).pop(false);
                  }),
            ],
          ),
        ],
      )
    ));
    if(confirmation){
      BlocProvider.of<InAppBloc>(context).add(MainViewEvent());
    }
  }
  void _leaveSurveyRegular() {
    BlocProvider.of<InAppBloc>(context).add(MainViewEvent());
  }

  List<Widget> convertSurveyQuestionsToWidgetList(
      {required BuildContext context}) {
    return questions.map((e) {
      switch (e.type) {
        case QuestionType.SINGLECHOICE:
          return scQuestionWidget(context: context, question: e);
        case QuestionType.MULTIPLECHOICE:
          return mcQuestionWidget(context: context, question: e);
        case QuestionType.PICTURE:
          return takePhotoQuestionWidget(context: context, question: e);
        case QuestionType.AUDIO:
          return takeAudioQuestionWidget(context: context, question: e);
        case QuestionType.TEXT:
          return textQuestionWidget(context: context, question: e);
        default:

          //TODO: Container löschen
          return Container();
          throw UnimplementedError();
      }
    }).toList();
  }

  Widget scQuestionWidget(
      {required BuildContext context, required Question question}) {
    return ListView(
      shrinkWrap: true,
      children: [
        imageForQuestion(question: question),
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
                        Text(question.questionOptions![index].text),
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
    );
  }

  Widget mcQuestionWidget(
      {required BuildContext context, required Question question}) {
    return ListView(
      shrinkWrap: true,
      children: [
        imageForQuestion(question: question),
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
                        Text(question.questionOptions![index].text),
                      ],
                    ),
                  ),
                )),
      ],
    );
  }

  Widget textQuestionWidget(
      {required BuildContext context, required Question question}) {
    return ListView(
      shrinkWrap: true,
      children: [
        imageForQuestion(question: question),
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
    );
  }

  Widget takePhotoQuestionWidget(
      {required BuildContext context, required Question question}) {
    return ListView(
      shrinkWrap: true,
      children: [
        imageForQuestion(question: question),
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
        getTakePhotoWidget(
            question: question, callback: () {}, context: context),
      ],
    );
  }

  Widget takeAudioQuestionWidget(
      {required BuildContext context, required Question question}) {
    return ListView(
      shrinkWrap: true,
      children: [
        imageForQuestion(question: question),
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
        getTakeAudioWidget(
            question: question, callback: () {}, context: context),
      ],
    );
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
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Text(resolveQuestionTypeDescriptionFromQuestion(
                    question: question)),
              ],
            ),
          ),
          getReadOutWidget(question: question),
        ],
      ),
    );
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
            style: Theme.of(context).textTheme.bodyText1,
          ),
          IconButton(
            icon: const Icon(MdiIcons.checkboxMarkedOutline),
            onPressed: () {
              addTask();
            },
          ),
        ],
      ),
    );
  }

  static Widget surveyTitleWidget(
      {required BuildContext context,
      required String surveyTitle,
      required String entityName,
      Image? image,
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
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    entityName,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ],
          ),
        ),
        if (image != null)
          SizedBox(
            height: defaultPadding(context),
          ),
        if (image != null) image,
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
      required List<QuestionAnswer> answers,
      required BuildContext context}) async {
    //todo: add location
    var surveyState = context.read<InAppBloc>().state as SurveyInAppState;
    var userState = context.read<UserBloc>().state;
    ExecutedSurvey executedSurvey = ExecutedSurvey(
        appliedIntervention: surveyState.appliedIntervention,
        survey: survey,
        whoExecutedIt: userState.user!,
        date: DateTime.now(),
        answers: answers);
    context.read<InAppBloc>().add(FinishAndSaveExecutedSurvey(
        executedSurvey, surveyState.appliedIntervention));
  }

  static Widget getEditQuestionWidget(
      {required BuildContext context, required onEdit}) {
    //TODO: use correct widget

    return MaterialButton(
      onPressed: () {
        onEdit();
      },
      padding: EdgeInsets.zero,
      child: const Icon(
        MdiIcons.accountEdit,
        size: 40,
      ),
    );
  }

  static Widget getReadOutWidget({required Question question}) {
    //TODO: add correct Widget From Bene, connect read out functionality

    return Container(
      child: const Icon(MdiIcons.speaker),
    );
  }

  static Widget getTakePhotoWidget(
      {required Question question,
      required VoidCallback callback,
      required BuildContext context}) {
    //TODO: connect with Bene

    return MaterialButton(
      onPressed: () {
        CameraFunctionality.takePicture(context: context);
      },
      child: Container(
        child: const Icon(
          MdiIcons.cameraRetake,
          size: 40,
        ),
      ),
    );
  }

  static Widget getTakeAudioWidget(
      {required Question question,
      required VoidCallback callback,
      required BuildContext context}) {
    //TODO: connect with Bene

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

  static Widget imageForQuestion({required Question question}) {
    //TODO: resolve Image from question

    return Image.asset('assets/test/demo_pic.jpg');
  }

  Future<bool?> addTask() async {
    //TODO: connect addTask

    return false;
  }
}

class AnimatedProgressBar extends StatefulWidget {
  final double progress;
  const AnimatedProgressBar(this.progress, {Key? key}) : super(key: key);

  @override
  State<AnimatedProgressBar> createState() => _AnimatedProgressBarState();
}

class _AnimatedProgressBarState extends State<AnimatedProgressBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

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

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
}

typedef QuestionEditor = Function Function(Question question);
