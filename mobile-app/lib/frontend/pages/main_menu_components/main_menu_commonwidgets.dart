import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile_app/backend/callableModels/CallableModels.dart';
import 'package:mobile_app/backend/callableModels/Survey.dart';
import 'package:mobile_app/frontend/common_widgets.dart';
import 'package:mobile_app/frontend/dependentsizes.dart';

class CustomPicButton extends StatefulWidget {
  VoidCallback? onPressed;
  String filePath;
  File? file;
  Size size;
  bool pressable;
  EdgeInsets? padding;
  IconData? defaultIconData;

  CustomPicButton(
      {this.onPressed,
      required this.filePath,
      this.file,
      required this.size,
      required this.pressable,
      this.padding,
      this.defaultIconData});

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
        height: widget.pressable ? 5 : 0,
        onPressed: widget.onPressed,
        padding: widget.padding,
        child: Container(
          width: widget.size.width,
          height: widget.size.height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Colors.white,
              border: Border.all(color: Colors.black45, width: 1)),
          child: (!loading && imageFile != null)
              ? Image.file(imageFile!,
                  width: min(widget.size.width, widget.size.height) * .6,
                  height: min(widget.size.width, widget.size.height) * .6,
                  fit: BoxFit.contain)
              : Icon(widget.defaultIconData ?? MdiIcons.toolbox,
                  color: Colors.black87,
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
        padding: EdgeInsets.all(defaultPadding(context) / 4),
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
    if (separator) Container(color: Colors.grey, height: 1)
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
        padding: EdgeInsets.all(defaultPadding(context) / 4),
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
    if (separator) Container(color: Colors.grey, height: 1)
  ]);
}

Widget taskRow(BuildContext context, Task task,
    {VoidCallback? onCheckChanged,
    bool checkChangePossible = false,
    bool separator = false}) {
  return Column(children: [
    Container(
        padding: EdgeInsets.all(defaultPadding(context) / 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: Row(
              children: [
                Expanded(
                    child: Text(task.title,
                        style: Theme.of(context).textTheme.bodyText1)),
                if (checkChangePossible)
                  Checkbox(
                      value: task.finishedDate != null,
                      onChanged: (b) => onCheckChanged!())
              ],
            ))
          ],
        )),
    if (separator) Container(color: Colors.grey, height: 1)
  ]);
}
