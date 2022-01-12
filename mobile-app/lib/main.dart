import 'package:flutter/material.dart';
import 'package:mobile_app/services/amplify.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  ///Theme data returned after initalization
  ThemeData? themeData;

  //async initStateMethod handling the futures
  initStateAsync() async {
    await AmplifyIntegration.initialize();

    ///todo: dummy data, replace with db-version
    setState(() {
      themeData = ThemeData();
    });
  }

  @override
  void initState() {
    super.initState();
    initStateAsync();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: themeData ?? ThemeData.light(),
        home: themeData != null
            ? Scaffold(body: Center(child: Image.asset("assets/test/logo.png")))
            : const Scaffold());
  }
}
