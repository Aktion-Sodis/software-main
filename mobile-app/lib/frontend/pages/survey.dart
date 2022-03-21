import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile_app/backend/callableModels/CallableModels.dart';
import 'package:mobile_app/frontend/common_widgets.dart';
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
    questions = widget.survey.questions.where((element) => !element.isFollowUpQuestion).toList();
    _inSurveyPageController.addListener(() {setState(() {

    });});
    _pageController.addListener(() {setState(() {

    });});
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
                goBack: () {},
                proceed: () {
                  _pageController.nextPage(
                      duration: _pageSlideDuration, curve: _pageSlideCurve);
                }),
            inSurveyWidget(),
          ],
        )));
  }

  Widget inSurveyWidget() {
    return Column(
      children: [
        SizedBox(
          height: defaultPadding(context),
        ),
        AnimatedProgressBar(_inSurveyPageController.hasClients?_inSurveyPageController.page!=null?((_inSurveyPageController.page!.round()+1)/questions.length):0:0),
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
            onDismiss: () {},
            onProceed: () {
              if (_inSurveyPageController.page?.round() != null) {
                Question currentQuestion = questions[_inSurveyPageController.page!.round()];
                if (currentQuestion.type == QuestionType.MULTIPLECHOICE) {
                  answers[currentQuestion] ??= QuestionAnswer(
                      questionID: widget.survey.id!,
                      date: DateTime.now(),
                      type: currentQuestion.type);
                }
                if (answers[currentQuestion] != null) {

                  //check for followUpQuestions
                  if(currentQuestion.type == QuestionType.SINGLECHOICE){
                    String? followUpID = answers[currentQuestion]!.questionOptions!.first.followUpQuestionID;
                    if(followUpID != null){
                      List<Question> followUpQuestions = widget.survey.questions.where((element) => element.id == followUpID).toList();
                      if(followUpQuestions.isNotEmpty){
                        setState(() {
                          questions.insert(questions.indexOf(currentQuestion)+1, followUpQuestions.first);
                        });
                      }
                    }
                    questions.removeWhere((element) {
                      bool result =  element.isFollowUpQuestion && element.id != followUpID;
                      if(result){
                        answers.remove(element);
                      }
                      return result;
                    });
                  }
                  _inSurveyPageController.nextPage(
                      duration: _pageSlideDuration, curve: _pageSlideCurve);
                }

                if (currentQuestion.type == QuestionType.AUDIO || currentQuestion.type == QuestionType.PICTURE){
                  //TODO: connect answers properly
                  _inSurveyPageController.nextPage(
                      duration: _pageSlideDuration, curve: _pageSlideCurve);
                }
              }
            }),
        SizedBox(
          height: defaultPadding(context),
        ),
      ],
    );
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
                    padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding(context)),
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
                      if(answers[question]!=null){
                        if(!answers[question]!.questionOptions!.contains(question.questionOptions![index])){
                          answers[question]!.questionOptions!.add(question.questionOptions![index]);
                        }else{
                          answers[question]!.questionOptions!.remove(question.questionOptions![index]);
                        }
                      }else{
                        answers[question] = QuestionAnswer(questionID: question.id!, date: DateTime.now(), type: question.type)..questionOptions = [question.questionOptions![index]];
                      }
                    });
                  },
              padding: EdgeInsets.zero,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultPadding(context)),
                child: Row(
                  children: [
                    Icon(
                        (){
                          if(answers[question]!=null){
                            if(answers[question]!.questionOptions!.contains(question.questionOptions![index])){
                              return MdiIcons.checkboxMarked;
                            }
                          }
                          return MdiIcons.checkboxBlankOutline;
                        }.call()
                    ),
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
            onChanged: (String result){
              answers[question] = QuestionAnswer(questionID: question.id!, date: DateTime.now(), type: QuestionType.TEXT)..text=result;
            },
          ),
        ),
      ],
    );
  }

  Widget takePhotoQuestionWidget({required BuildContext context, required Question question}){
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
          height: defaultPadding(context) *2,
        ),
        getTakePhotoWidget(question: question, callback: (){}, context: context),
      ],
    );
  }

  Widget takeAudioQuestionWidget({required BuildContext context, required Question question}){
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
          height: defaultPadding(context) *2,
        ),
        getTakeAudioWidget(question: question, callback: (){}, context: context),
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

  static Widget getReadOutWidget({required Question question}) {
    //TODO: add correct Widget From Bene, connect read out functionality

    return Container(
      child: const Icon(MdiIcons.speaker),
    );
  }

  static Widget getTakePhotoWidget({required Question question, required VoidCallback callback, required BuildContext context}){
    //TODO: connect with Bene

    return MaterialButton(
      onPressed: (){
        CameraFunctionality.takePicture(context: context);
      },
      child: Container(
        child: const Icon(MdiIcons.cameraRetake, size: 40,),
      ),
    );
  }

  static Widget getTakeAudioWidget({required Question question, required VoidCallback callback, required BuildContext context}){
    //TODO: connect with Bene

    return MaterialButton(
      onPressed: (){

      },
      child: Container(
        child: const Icon(MdiIcons.microphone, size: 40,),
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
