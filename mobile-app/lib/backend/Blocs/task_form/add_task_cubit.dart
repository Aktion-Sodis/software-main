import 'package:flutter/material.dart';
import 'package:mobile_app/backend/Blocs/task_form/task_form_cubit.dart';
import 'package:mobile_app/backend/callableModels/Task.dart';
import 'package:mobile_app/backend/callableModels/localModels/attachment.dart';
import 'package:mobile_app/backend/callableModels/Entity.dart';

void createTask(BuildContext context) =>
    openTaskForm<AddTaskCubit>(context, "Create task");

class AddTaskCubit extends TaskFormCubit {
  @override
  Future<Task?> saveTask(String text, List<Attachment> attachments,
      List<Entity> entities, DateTime? deadline) {
    return Future.value(null);
  }
}
