import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile_app/backend/Blocs/in_app/in_app_bloc.dart';
import 'package:mobile_app/backend/Blocs/in_app/in_app_events.dart';
import 'package:mobile_app/backend/Blocs/task/task_bloc.dart';
import 'package:mobile_app/backend/Blocs/task/task_state.dart';
import 'package:mobile_app/backend/callableModels/Task.dart';
import 'package:mobile_app/frontend/components/buttons.dart';
import 'package:mobile_app/frontend/dependentsizes.dart';
import 'package:mobile_app/frontend/pages/main_menu.dart';
import 'package:mobile_app/frontend/pages/main_menu_components/main_menu_commonwidgets.dart';
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
              CustomIconButton(() {
                context.read<InAppBloc>().add(GoToUserPageEvent());
              }, MdiIcons.human, Size(width(context) * .1, width(context) * .1),
                  true)
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
                          BlocBuilder<TaskBloc, TaskState>(
                            builder: (context, state) {
                              if (state is LoadedTaskState) {
                                if (state.allTasks.isNotEmpty) {
                                  List<Task> toDisplay =
                                      state.firstThreeUndoneTasks();
                                  return RawMaterialButton(
                                      onPressed: () {
                                        widget.onNavigationCall(2);
                                      },
                                      child: IgnorePointer(
                                          child: Container(
                                        padding: EdgeInsets.all(
                                            defaultPadding(context)),
                                        width: width(context) * .8,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.black45,
                                                width: 1)),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: List.generate(
                                              toDisplay.length,
                                              (index) => taskRow(
                                                  context, toDisplay[index],
                                                  checkChangePossible: false,
                                                  separator: index !=
                                                      (toDisplay.length - 1))),
                                        ),
                                      )));
                                } else {
                                  return CustomIconButton(() {
                                    widget.onNavigationCall(2);
                                  },
                                      FontAwesomeIcons.tasks,
                                      Size(width(context) * .8,
                                          width(context) * .4),
                                      true,
                                      padding: EdgeInsets.zero);
                                }
                              } else {
                                return CustomIconButton(() {
                                  widget.onNavigationCall(2);
                                },
                                    FontAwesomeIcons.tasks,
                                    Size(width(context) * .8,
                                        width(context) * .4),
                                    true,
                                    padding: EdgeInsets.zero);
                              }
                            },
                          ),
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
