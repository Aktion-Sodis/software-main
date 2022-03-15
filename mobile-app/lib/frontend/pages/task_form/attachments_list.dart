import 'package:flutter/material.dart';
import 'package:mobile_app/frontend/dependentsizes.dart';
import 'package:mobile_app/frontend/theme.dart';

class AttachmentsList extends StatelessWidget {
  const AttachmentsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: EdgeInsets.only(bottom: defaultPadding(context)),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.symmetric(
              horizontal: BorderSide(
                  width: 1, color: ThemeColors.mobster.withOpacity(0.2)))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                EdgeInsets.only(left: 1.5 * defaultPadding(context), top: 10),
            child: const Text(
              "Attachments",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(
                  left: defaultPadding(context), top: 5, bottom: 10),
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                    padding: EdgeInsets.only(
                      right: defaultPadding(context) / 2,
                    ),
                    child: const SizedBox.shrink()),
                const SizedBox(
                  height: double.infinity,
                  width: 1000,
                ) // TODO: implement attachments
              ],
            ),
          )
        ],
      ),
    );
  }
}
