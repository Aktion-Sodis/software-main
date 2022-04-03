import 'package:flutter/material.dart';
import 'package:mobile_app/frontend/theme.dart';

class ShadowBox extends StatelessWidget {
  const ShadowBox({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [defaultShadow],
          borderRadius: BorderRadius.circular(15),
          color: Colors.white),
      child: child,
    );
  }
}
