import 'package:flutter/material.dart';
import 'package:mobile_app/frontend/theme.dart';

class SmallButton extends StatelessWidget {
  SmallButton(
      {required this.iconData,
      required this.text,
      required this.onPressed,
      this.selected = false,
      Key? key})
      : super(key: key);

  final IconData iconData;
  final String text;
  final Function() onPressed;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    Color textColor = selected ? Colors.white : ThemeColors.black;
    Color backgroundColor = selected ? ThemeColors.red : Colors.white;

    return ElevatedButton(
        onPressed: selected ? null : onPressed,
        style: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.only(
                left: 15, right: 20, top: 10, bottom: 10)),
            backgroundColor: MaterialStateProperty.all(backgroundColor),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    //side: BorderSide(color: ThemeColors.black),
                    borderRadius: BorderRadius.circular(30)))),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Icon(iconData, color: textColor),
            const SizedBox(
              width: 5,
            ),
            Text(
              text,
              style: TextStyle(fontSize: 14, color: textColor),
            ),
          ],
        ));
  }
}
