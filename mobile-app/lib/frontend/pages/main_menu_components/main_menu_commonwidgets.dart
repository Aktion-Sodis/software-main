import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile_app/backend/Blocs/organization_view/organization_view_bloc.dart';
import 'package:mobile_app/backend/callableModels/CallableModels.dart';
import 'package:mobile_app/backend/callableModels/Survey.dart';
import 'package:mobile_app/backend/repositories/InterventionRepository.dart';
import 'package:mobile_app/frontend/buttons.dart';
import 'package:mobile_app/frontend/common_widgets.dart';
import 'package:mobile_app/frontend/dependentsizes.dart';
import 'package:mobile_app/frontend/strings.dart' as strings;

class CustomPicButton extends StatefulWidget {
  VoidCallback? onPressed;
  String filePath;
  File? file;
  Size size;
  bool pressable;
  EdgeInsets? padding;
  IconData? defaultIconData;
  bool selected;

  CustomPicButton(
      {this.onPressed,
      required this.filePath,
      this.file,
      required this.size,
      required this.pressable,
      this.padding,
      this.defaultIconData,
      this.selected = false});

  @override
  State<StatefulWidget> createState() {
    return CustomPicButtonState();
  }
}

class CustomPicButtonState extends State<CustomPicButton> {
  bool loading = true;
  File? imageFile;

  Future<File?> fileFromPath(String path) async {
    //todo: implement
    return null;
  }

  @override
  void initState() {
    if (widget.file != null) {
      imageFile = widget.file;
      loading = false;
    }
    super.initState();
    if (widget.file == null) {
      fileFromPath(widget.filePath).then((value) {
        setState(() {
          imageFile = value;
          loading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        minWidth: widget.size.width,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        height: widget.pressable ? 5 : 0,
        onPressed: widget.onPressed,
        padding: widget.padding,
        child: Container(
          width: widget.size.width,
          height: widget.size.height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: widget.selected
                  ? Theme.of(context).colorScheme.secondary
                  : Colors.white,
              border: Border.all(color: Colors.black45, width: 1)),
          child: (!loading && imageFile != null)
              ? Image.file(imageFile!,
                  width: min(widget.size.width, widget.size.height) * .6,
                  height: min(widget.size.width, widget.size.height) * .6,
                  fit: BoxFit.contain,
                  color: widget.selected
                      ? Theme.of(context).colorScheme.onSecondary
                      : Colors.black87)
              : Icon(widget.defaultIconData ?? MdiIcons.toolbox,
                  color: widget.selected
                      ? Theme.of(context).colorScheme.onSecondary
                      : Colors.black87,
                  size: min(widget.size.width, widget.size.height) * .6),
        ));
  }
}

Widget surveyRow(BuildContext context, Survey survey, String filePath,
    {VoidCallback? onPressed,
    File? image,
    bool pressable = false,
    bool separator = false}) {
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Container(
        padding: EdgeInsets.symmetric(
            horizontal: defaultPadding(context) / 2,
            vertical: defaultPadding(context) / (pressable ? 1 : 2)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomPicButton(
                filePath: filePath,
                file: image,
                onPressed: () {},
                size: Size(width(context) * .1, width(context) * .1),
                pressable: false),
            SizedBox(width: defaultPadding(context)),
            Expanded(
                child: Row(
              children: [
                Expanded(
                    child: Text(survey.name,
                        style: Theme.of(context).textTheme.bodyText1)),
                if (pressable)
                  CommonWidgets.defaultIconButton(
                      onPressed: onPressed,
                      context: context,
                      iconData: MdiIcons.arrowRight,
                      buttonSizes: ButtonSizes.small,
                      fillColor: Theme.of(context).colorScheme.secondary)
              ],
            ))
          ],
        )),
    if (separator)
      Container(
          margin: EdgeInsets.symmetric(horizontal: defaultPadding(context)),
          color: Colors.grey,
          height: 1)
  ]);
}

Widget interventionRow(
    BuildContext context, Intervention intervention, String filePath,
    {VoidCallback? onPressed,
    File? image,
    bool pressable = false,
    bool separator = false}) {
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Container(
        padding: EdgeInsets.symmetric(
            horizontal: defaultPadding(context) / 2,
            vertical: defaultPadding(context) / (pressable ? 1 : 2)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomPicButton(
                filePath: filePath,
                file: image,
                onPressed: () {},
                size: Size(width(context) * .1, width(context) * .1),
                pressable: false),
            SizedBox(width: defaultPadding(context)),
            Expanded(
                child: Row(
              children: [
                Expanded(
                    child: Text(intervention.name,
                        style: Theme.of(context).textTheme.bodyText1)),
                if (pressable)
                  CommonWidgets.defaultIconButton(
                      onPressed: onPressed,
                      context: context,
                      iconData: MdiIcons.arrowRight,
                      buttonSizes: ButtonSizes.small,
                      fillColor: Theme.of(context).colorScheme.secondary)
              ],
            ))
          ],
        )),
    if (separator)
      Container(
          margin: EdgeInsets.symmetric(horizontal: defaultPadding(context)),
          color: Colors.grey,
          height: 1)
  ]);
}

Widget taskRow(BuildContext context, Task task,
    {ValueChanged<Task>? onCheckChanged,
    bool checkChangePossible = false,
    bool separator = false,
    ValueChanged<Task>? onPressed,
    bool showDate = false}) {
  return Column(children: [
    RawMaterialButton(
        onPressed: () {
          if (onPressed != null) {
            onPressed(task);
          }
        },
        child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: defaultPadding(context) / 2,
                vertical:
                    defaultPadding(context) / (checkChangePossible ? 1 : 2)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Row(
                  children: [
                    Expanded(
                        child: Column(children: [
                      Container(
                          child: Text(task.title,
                              style: Theme.of(context).textTheme.bodyText1)),
                      if (showDate && task.dueDate != null)
                        Container(
                            margin:
                                EdgeInsets.only(top: defaultPadding(context)),
                            child: Text(strings.remaining +
                                ": " +
                                task.dueDate!
                                    .difference(DateTime.now())
                                    .inDays
                                    .toString() +
                                (task.dueDate!
                                            .difference(DateTime.now())
                                            .inDays >
                                        1
                                    ? strings.days
                                    : strings.day)))
                    ])),
                    if (checkChangePossible)
                      Checkbox(
                          value: task.finishedDate != null,
                          onChanged: (b) => onCheckChanged!(task))
                  ],
                ))
              ],
            ))),
    if (separator)
      Container(
          margin: EdgeInsets.symmetric(horizontal: defaultPadding(context)),
          color: Colors.grey,
          height: 1)
  ]);
}

class InterventionFilterWidget extends StatefulWidget {
  ValueChanged<List<Intervention>>? onSelectionChanged;
  bool selectable;
  List<Intervention> allInterventions;

  InterventionFilterWidget(
      {required this.allInterventions,
      this.selectable = false,
      this.onSelectionChanged});

  @override
  State<StatefulWidget> createState() {
    return InterventionFilterWidgetState();
  }
}

class InterventionFilterWidgetState extends State<InterventionFilterWidget> {
  late List<Intervention> allInterventions;
  late List<Intervention> selectedInterventions;

  void selectionChange(int index) {
    if (selectedInterventions
        .any((element) => element.id == allInterventions[index].id)) {
      setState(() {
        selectedInterventions
            .removeWhere((element) => element.id == allInterventions[index].id);
      });
      widget.onSelectionChanged!(selectedInterventions);
    } else {
      setState(() {
        selectedInterventions.add(allInterventions[index]);
      });
      widget.onSelectionChanged!(selectedInterventions);
    }
  }

  Widget mapWidget(int index) {
    String filePath =
        InterventionRepository.getInterventionIconPath(allInterventions[index]);

    return CustomPicButton(
        onPressed: () {
          if (widget.selectable) {
            selectionChange(index);
          }
        },
        filePath: filePath,
        size: widget.selectable
            ? Size(width(context) * .15, width(context) * .15)
            : Size(width(context) * .1, width(context) * .1),
        pressable: widget.selectable,
        padding: EdgeInsets.zero,
        selected: selectedInterventions
            .any((obj) => allInterventions[index].id == obj.id));
  }

  List<Widget> getWrapChildren() =>
      List.generate(allInterventions.length, (index) => mapWidget(index));

  @override
  void initState() {
    allInterventions = widget.allInterventions;
    selectedInterventions = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.center,
            children: getWrapChildren(),
            spacing: defaultPadding(context)));
  }
}
