import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_app/frontend/components/audio/buttons.dart';
import 'package:mobile_app/frontend/dependentsizes.dart';
import 'package:mobile_app/frontend/pages/main_menu.dart';
import 'package:mobile_app/frontend/strings.dart' as strings;

import 'main_menu_app_bar.dart';

class MainMenuHome extends StatefulWidget {
  ValueChanged<int> onNavigationCall;

  MainMenuHome(this.onNavigationCall);

  @override
  State<StatefulWidget> createState() {
    return MainMenuHomeState();
  }
}

class MainMenuHomeState extends State<MainMenuHome> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      MainMenuAppBar(context, () {}, strings.main_menu_home,
          showBackButton: false),
      Expanded(
          child: Container(
              margin: EdgeInsets.all(width(context) * .1),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomIconButton(() {
                      widget.onNavigationCall(2);
                    }, FontAwesomeIcons.tasks,
                        Size(width(context) * .8, width(context) * .4), true,
                        padding: EdgeInsets.zero),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomIconButton(() {
                          widget.onNavigationCall(1);
                        },
                            FontAwesomeIcons.folder,
                            Size(width(context) * .35, width(context) * .35),
                            true,
                            padding: EdgeInsets.zero),
                        CustomIconButton(() {
                          widget.onNavigationCall(3);
                        },
                            FontAwesomeIcons.handSparkles,
                            Size(width(context) * .35, width(context) * .35),
                            true,
                            padding: EdgeInsets.zero),
                      ],
                    )
                  ])))
    ]);
  }
}
