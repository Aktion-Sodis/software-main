import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile_app/frontend/components/buttons.dart';
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
      Container(
        width: width(context),
        height: appBarHeight(context),
        child: Column(children: [
          Expanded(
              child: Row(
            children: [
              //todo: add back button
              Container(
                  margin: EdgeInsets.only(left: width(context) * .1),
                  child: Image.asset("assets/test/logo.png",
                      height: width(context) * .1)),
              Expanded(child: Container()),
              /*Expanded(
                child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: defaultPadding(context)),
                    alignment: Alignment.centerLeft,
                    child: Text(strings.main_menu_home,
                        style: Theme.of(context).textTheme.headline2))),*/
              CustomIconButton(() {}, MdiIcons.human,
                  Size(width(context) * .1, width(context) * .1), true)
            ],
          )),
          Container(width: width(context), height: 1, color: Colors.grey)
        ]),
      ),
      Expanded(
          child: Container(
              margin: EdgeInsets.all(width(context) * .1),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomIconButton(() {
                            widget.onNavigationCall(2);
                          },
                              FontAwesomeIcons.tasks,
                              Size(width(context) * .8, width(context) * .4),
                              true,
                              padding: EdgeInsets.zero),
                          Container(
                              margin:
                                  EdgeInsets.only(top: defaultPadding(context)),
                              child: Text(strings.main_menu_tasks,
                                  style: Theme.of(context).textTheme.subtitle1))
                        ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomIconButton(() {
                                widget.onNavigationCall(1);
                              },
                                  FontAwesomeIcons.folder,
                                  Size(width(context) * .35,
                                      width(context) * .35),
                                  true,
                                  padding: EdgeInsets.zero),
                              Container(
                                  margin: EdgeInsets.only(
                                      top: defaultPadding(context)),
                                  child: Text(strings.main_menu_organization,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1))
                            ]),
                        Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomIconButton(() {
                                widget.onNavigationCall(3);
                              },
                                  FontAwesomeIcons.handSparkles,
                                  Size(width(context) * .35,
                                      width(context) * .35),
                                  true,
                                  padding: EdgeInsets.zero),
                              Container(
                                  margin: EdgeInsets.only(
                                      top: defaultPadding(context)),
                                  child: Text(strings.main_menu_wiki,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1))
                            ]),
                      ],
                    )
                  ])))
    ]);
  }
}
