import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile_app/frontend/theme.dart';

class TaskAttachmentBox extends StatelessWidget {
  const TaskAttachmentBox({
    Key? key,
    this.removeAttachment,
    required this.child,
  }) : super(key: key);

  final Function()? removeAttachment;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 1,
        child: Stack(children: [
          Container(
              margin: const EdgeInsets.all(5),
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [defaultShadow],
                color: Colors.white,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: child,
              )),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [defaultShadow],
              ),
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                child: InkWell(
                  onTap: removeAttachment,
                  borderRadius: BorderRadius.circular(15),
                  child: const Icon(
                    MdiIcons.delete,
                    size: 20,
                  ),
                ),
              ),
            ),
          )
        ]));
  }
}
