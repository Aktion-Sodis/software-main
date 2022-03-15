import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {
  SmallButton(
      {required this.iconData,
      required this.text,
      required this.color,
      this.textColor = Colors.white,
      required this.onPressed,
      this.isOutlined = false,
      this.selected = false,
      Key? key})
      : super(key: key);

  final IconData iconData;
  final String text;
  final Color color;
  final Color textColor;
  final Function() onPressed;
  final bool isOutlined;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: selected ? 1.0 : 0.4,
      child: ElevatedButton(
          onPressed: selected ? null : onPressed,
          style: ButtonStyle(
              padding: MaterialStateProperty.all(const EdgeInsets.only(
                  left: 15, right: 20, top: 10, bottom: 10)),
              backgroundColor:
                  MaterialStateProperty.all(isOutlined ? Colors.white : color),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                      side: isOutlined
                          ? BorderSide(color: color, width: 3)
                          : BorderSide.none,
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
          )),
    );
  }
}
