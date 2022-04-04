import 'package:flutter/material.dart';
import 'package:mobile_app/frontend/dependentsizes.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                width: width(context) * .6,
                child: Image.asset("assets/test/logo.png"))));
  }
}
