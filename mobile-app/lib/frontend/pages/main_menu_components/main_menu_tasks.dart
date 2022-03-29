import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile_app/backend/Blocs/task/task_bloc.dart';
import 'package:mobile_app/backend/Blocs/task/task_events.dart';
import 'package:mobile_app/backend/Blocs/task/task_state.dart';
import 'package:mobile_app/backend/Blocs/task_form/task_form_cubit.dart';
import 'package:mobile_app/backend/Blocs/user/user_bloc.dart';
import 'package:mobile_app/backend/callableModels/CallableModels.dart';
import 'package:mobile_app/backend/callableModels/Entity.dart';
import 'package:mobile_app/frontend/common_widgets.dart';
import 'package:mobile_app/frontend/components/loadingsign.dart';
import 'package:mobile_app/frontend/dependentsizes.dart';
import 'package:mobile_app/frontend/pages/main_menu_components/main_menu_app_bar.dart';
import 'package:mobile_app/frontend/pages/main_menu_components/main_menu_commonwidgets.dart';
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

  void pressed(Task task, BuildContext blocContext) async {}

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
              return Container(
                  padding: EdgeInsets.all(defaultPadding(context)),
                  margin: EdgeInsets.all(defaultPadding(context)),
                  color: Colors.red,
                  child: Text("Today", style: TextStyle(color: Colors.white)));
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
              return Container(
                  padding: EdgeInsets.all(defaultPadding(context)),
                  margin: EdgeInsets.all(defaultPadding(context)),
                  color: Colors.yellow,
                  child: Text("Tomorrow",
                      style: TextStyle(color: Colors.black87)));
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
              return Container(
                  padding: EdgeInsets.all(defaultPadding(context)),
                  margin: EdgeInsets.all(defaultPadding(context)),
                  color: Colors.grey,
                  child: Text(strings.tasks_more_behind,
                      style: TextStyle(color: Colors.black87)));
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
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  todayWidget(context),
                  tomorrowWidget(context),
                  restWidget(context)
                ],
              )),
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

Future<Task> addTask(BuildContext buildContext,
    {Entity? entity,
    AppliedIntervention? appliedIntervention,
    ExecutedSurvey? executedSurvey}) async {
  //todo: connect with arthur
  openTaskForm(buildContext, strings.main_menu_tasks);
  Task toCreate = Task(
      title: "Test Title",
      user: buildContext.read<UserBloc>().state.user!,
      id: UUID.getUUID(),
      entity: entity,
      dueDate: DateTime.now(),
      audioList: [],
      picList: [0]);
  buildContext.read<TaskBloc>().add(CreateTask(toCreate));
  return toCreate;
}

Future<Task> updateTask(BuildContext buildContext, Task task) async {
  //todo: connect with arthur
  buildContext.read<TaskBloc>().add(UpdateTask(task));
  return task;
}
