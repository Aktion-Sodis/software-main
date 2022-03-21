import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile_app/backend/callableModels/CallableModels.dart';
import 'package:mobile_app/frontend/common_widgets.dart';
import 'package:mobile_app/frontend/dependentsizes.dart';
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

  @override
  void initState() {
    surveyImage = Image.asset('assets/test/demo_pic.jpg');
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
        AnimatedProgressBar(0.5),
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
            onGoBack: () {},
            onDismiss: () {},
            onProceed: () {}),
        SizedBox(
          height: defaultPadding(context),
        ),
      ],
    );
  }

  List<Widget> convertSurveyQuestionsToWidgetList(
      {required BuildContext context}) {
    return widget.survey.questions.map((e) {
      switch (e.type) {
        case QuestionType.SINGLECHOICE:
          return scQuestionWidget(context: context);
        default:
          //TODO: Container löschen
          return Container();
          throw UnimplementedError();
      }
    }).toList();
  }

  Widget scQuestionWidget({required BuildContext context}) {
    return ListView(
      shrinkWrap: true,
      children: [
        addTask(context: context, surveyTitle: widget.survey.name, addTask: (){})
      ],
    );
  }

  static Widget addTask({required BuildContext context, required String surveyTitle, required Function addTask}){
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
            onPressed: (){
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

  static Widget progressBar(double progress, {required BuildContext context}) {
    return AnimatedProgressBar(progress);
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
