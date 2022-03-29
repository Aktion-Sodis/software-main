import 'package:flutter/material.dart';

class KeyboardDismisser extends StatelessWidget {
  final Widget child;

  const KeyboardDismisser({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: child,
    );
  }

  static void dismiss(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    currentFocus.focusedChild?.unfocus();
  }
}
