import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile_app/backend/Blocs/organization_view/organization_view_bloc.dart';
import 'package:mobile_app/backend/Blocs/task/task_bloc.dart';
import 'package:mobile_app/backend/Blocs/task/task_events.dart';
import 'package:mobile_app/backend/Blocs/task/task_state.dart';
import 'package:mobile_app/backend/Blocs/task_form/task_form_cubit.dart';
import 'package:mobile_app/backend/Blocs/user/user_bloc.dart';
import 'package:mobile_app/backend/callableModels/CallableModels.dart';
import 'package:mobile_app/backend/callableModels/Entity.dart';
import 'package:mobile_app/backend/callableModels/localModels/attachment.dart';
import 'package:mobile_app/backend/callableModels/localModels/audio_attachment.dart';
import 'package:mobile_app/backend/callableModels/localModels/image_attachment.dart';
import 'package:mobile_app/backend/repositories/TaskRepository.dart';
import 'package:mobile_app/frontend/common_widgets.dart';
import 'package:mobile_app/frontend/components/loadingsign.dart';
import 'package:mobile_app/frontend/dependentsizes.dart';
import 'package:mobile_app/frontend/pages/main_menu_components/main_menu_app_bar.dart';
import 'package:mobile_app/frontend/pages/main_menu_components/main_menu_commonwidgets.dart';
import 'package:mobile_app/frontend/pages/task_form/small_button.dart';
import 'package:provider/src/provider.dart';
import 'package:mobile_app/frontend/strings.dart' as strings;

class MainMenuTasks extends StatelessWidget {
  const MainMenuTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MainMenuAppBar(context, () {}, strings.main_menu_tasks),
        Expanded(child: TaskWidget(key: ValueKey("main_tasks")))
      ],
    );
  }
}

class TaskWidget extends StatelessWidget {
  Entity? entity;

  TaskWidget({Key? key, this.entity}) : super(key: key);

  void checkChange(Task task, BuildContext context) async {
    if (task.finishedDate == null) {
      task.finishedDate = DateTime.now();
      context.read<TaskBloc>().add(UpdateTask(task));
    } else {
      task.finishedDate = null;
      context.read<TaskBloc>().add(UpdateTask(task));
    }
  }

  void pressed(Task task, BuildContext blocContext) async {
    updateTask(blocContext, task);
  }

  Widget todayWidget(BuildContext context) {
    //todo: change widget according to arthur
    List<Task> todayTasks = (context.watch<TaskBloc>().state as LoadedTaskState)
        .tasksDueToday(entity: entity);

    if (todayTasks.isNotEmpty) {
      return Container(
        margin: EdgeInsets.only(
            left: defaultPadding(context),
            right: defaultPadding(context),
            top: defaultPadding(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(todayTasks.length + 1, (index) {
            if (index == 0) {
              return SmallButton(
                onPressed: () {},
                iconData: MdiIcons.skipNextOutline,
                text: strings.task_today,
                selected: true,
              );
            }
            return taskRow(context, todayTasks[index - 1],
                checkChangePossible: true, onCheckChanged: (task) {
              checkChange(task, context);
            }, onPressed: (task) {
              pressed(task, context);
            }, separator: (index - 1) != todayTasks.length - 1);
          }),
        ),
      );
    }
    return Container();
  }

  Widget tomorrowWidget(BuildContext context) {
    //todo: change widget according to arthur
    List<Task> todayTasks = (context.watch<TaskBloc>().state as LoadedTaskState)
        .tasksDueTomorrow(entity: entity);
    if (todayTasks.isNotEmpty) {
      return Container(
        margin: EdgeInsets.only(
            left: defaultPadding(context),
            right: defaultPadding(context),
            top: defaultPadding(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(todayTasks.length + 1, (index) {
            if (index == 0) {
              return SmallButton(
                onPressed: () {},
                iconData: MdiIcons.skipNextOutline,
                text: strings.task_tomorrow,
                selected: false,
              );
            }
            return taskRow(context, todayTasks[index - 1],
                checkChangePossible: true, onCheckChanged: (task) {
              checkChange(task, context);
            }, onPressed: (task) {
              pressed(task, context);
            }, separator: (index - 1) != todayTasks.length - 1);
          }),
        ),
      );
    }
    return Container();
  }

  Widget restWidget(BuildContext context) {
    //todo: change widget according to arthur
    List<Task> todayTasks = (context.watch<TaskBloc>().state as LoadedTaskState)
        .otherTasks(entity: entity);

    if (todayTasks.isNotEmpty) {
      return Container(
        margin: EdgeInsets.only(
            left: defaultPadding(context),
            right: defaultPadding(context),
            top: defaultPadding(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(todayTasks.length + 1, (index) {
            if (index == 0) {
              return SmallButton(
                onPressed: () {},
                iconData: MdiIcons.skipForwardOutline,
                text: strings.task_later_in_future,
                selected: false,
              );
            }
            return taskRow(context, todayTasks[index - 1],
                checkChangePossible: true, onCheckChanged: (task) {
              checkChange(task, context);
            }, onPressed: (task) {
              pressed(task, context);
            }, separator: (index - 1) != todayTasks.length - 1);
          }),
        ),
      );
    }
    return Container();
  }

  void addPressed(BuildContext context) async {
    addTask(context, entity: entity);
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
      if (state is LoadedTaskState) {
        return Container(
            child: Column(
          children: [
            Expanded(
              child: Scrollbar(
                  child: SingleChildScrollView(
                      child: Column(
                children: [
                  todayWidget(context),
                  tomorrowWidget(context),
                  restWidget(context)
                ],
              ))),
            ),
            Container(
                margin: EdgeInsets.all(defaultPadding(context)),
                child: CommonWidgets.defaultIconButton(
                    context: context,
                    iconData: MdiIcons.plus,
                    buttonSizes: ButtonSizes.large,
                    fillColor: Theme.of(context).colorScheme.secondary,
                    onPressed: () => addPressed(context)))
          ],
        ));
      } else {
        return Container(child: Center(child: loadingSign(context)));
      }
    });
  }
}

Future addTask(
  BuildContext buildContext, {
  Entity? entity,
  AppliedIntervention? appliedIntervention,
  ExecutedSurvey? executedSurvey,
}) async {
  //todo: connect with arthur
  openTaskForm(
      context: buildContext,
      entity: entity,
      appliedIntervention: appliedIntervention,
      executedSurvey: executedSurvey,
      taskBloc: buildContext.read<TaskBloc>(),
      userBloc: buildContext.read<UserBloc>(),
      organizationViewBloc: buildContext.read<OrganizationViewBloc>());
}

Future updateTask(BuildContext buildContext, Task task) async {
  List<Attachment> toPass = [];
  if (task.picList.isNotEmpty) {
    for (int picID in task.picList) {
      File file = await TaskRepository.getTaskPic(task, picID).getCachePath();
      toPass.add(ImageAttachment(file.uri.toString()));
    }
  }

  if (task.audioList.isNotEmpty) {
    for (int audioID in task.audioList) {
      File file =
          await TaskRepository.getTaskAudio(task, audioID).getCachePath();
      toPass.add(AudioAttachment(file.uri.toString()));
    }
  }

  openTaskForm(
      context: buildContext,
      task: task,
      taskBloc: buildContext.read<TaskBloc>(),
      userBloc: buildContext.read<UserBloc>(),
      organizationViewBloc: buildContext.read<OrganizationViewBloc>(),
      attachment: toPass);
}
