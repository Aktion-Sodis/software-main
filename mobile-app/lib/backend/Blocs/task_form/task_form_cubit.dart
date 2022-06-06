import 'dart:io';
import 'dart:math';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/backend/Blocs/organization_view/organization_view_bloc.dart';
import 'package:mobile_app/backend/Blocs/organization_view/organization_view_state.dart';
import 'package:mobile_app/backend/Blocs/task/task_bloc.dart';
import 'package:mobile_app/backend/Blocs/task/task_events.dart';
import 'package:mobile_app/backend/Blocs/user/user_bloc.dart';
import 'package:mobile_app/backend/callableModels/CallableModels.dart';
import 'package:mobile_app/backend/callableModels/localModels/attachment.dart';
import 'package:mobile_app/backend/callableModels/localModels/image_attachment.dart';
import 'package:mobile_app/backend/repositories/EntityRepository.dart';
import 'package:mobile_app/backend/repositories/TaskRepository.dart';
import 'package:mobile_app/backend/storage/image_synch.dart';
import 'package:mobile_app/backend/storage/storage_repository.dart';
import 'package:mobile_app/frontend/pages/task_form/task_form.dart';
import 'package:mobile_app/services/photo_capturing.dart';
import 'package:mobile_app/services/storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mobile_app/frontend/strings.dart' as strings;

part 'task_form_state.dart';

void openTaskForm<T extends TaskFormCubit>(
    {required BuildContext context,
    Task? task,
    Entity? entity,
    AppliedIntervention? appliedIntervention,
    ExecutedSurvey? executedSurvey,
    required TaskBloc taskBloc,
    required OrganizationViewBloc organizationViewBloc,
    required UserBloc userBloc,
    List<Attachment>? attachment}) {
  showDialog(
      barrierColor: Theme.of(context).colorScheme.background,
      context: context,
      builder: (context) => TaskForm<T>(
          title: strings.main_menu_tasks,
          entity: entity,
          task: task,
          appliedIntervention: appliedIntervention,
          executedSurvey: executedSurvey,
          taskBloc: taskBloc,
          organizationViewBloc: organizationViewBloc,
          userBloc: userBloc,
          attachments: attachment));
}

class TaskFormCubit extends Cubit<TaskFormState> {
  TaskFormCubit(
      {Task? task,
      Entity? entity,
      AppliedIntervention? appliedIntervention,
      ExecutedSurvey? executedSurvey,
      required TaskBloc taskBloc,
      required OrganizationViewBloc organizationViewBloc,
      required UserBloc userBloc,
      List<Attachment>? attachments})
      : super(TaskFormFillingOut(
            task: task,
            entity: entity,
            appliedIntervention: appliedIntervention,
            executedSurvey: executedSurvey,
            taskBloc: taskBloc,
            organizationViewBloc: organizationViewBloc,
            userBloc: userBloc,
            attachments: attachments ?? [],
            deadline: task?.dueDate));

  Future<List<Entity>> searchForEntities(String? query) async {
    // TODO: makt it possible to search among all entities
    return EntityRepository.getEntities(searchByName: query, page: 0);
  }

  static TaskFormCubit initialize<T extends TaskFormCubit>(
      {Task? task,
      Entity? entity,
      AppliedIntervention? appliedIntervention,
      ExecutedSurvey? executedSurvey,
      required TaskBloc taskBloc,
      required OrganizationViewBloc organizationViewBloc,
      required UserBloc userBloc,
      List<Attachment>? attachments}) {
    switch (T) {
      default:
        if (task != null) {
          entity = task.entity;
          appliedIntervention = task.appliedIntervention;
          executedSurvey = task.executedSurvey;
        }

        return TaskFormCubit(
            task: task,
            entity: entity,
            appliedIntervention: appliedIntervention,
            executedSurvey: executedSurvey,
            taskBloc: taskBloc,
            organizationViewBloc: organizationViewBloc,
            userBloc: userBloc,
            attachments: attachments);
    }
  }

  Future<void> takePhoto(BuildContext context) async {
    XFile? photo = await CameraFunctionality.takePicture(context: context);

    if (photo != null) {
      // Find free filepath in the temporary folder
      Directory tempDir = await getTemporaryDirectory();
      String filepath = tempDir.path +
          "/photo_" +
          DateTime.now().microsecondsSinceEpoch.toString() +
          ".aac";
      String freeFilepath = await getFreeFilepath(filepath);

      await photo.saveTo(freeFilepath);
      Uri fileURI = Uri(path: freeFilepath);

      Attachment attachment = ImageAttachment(fileURI.toString());
      addAttachment(attachment);
    }
  }

  void updateEntity(Entity entity) {
    if (state is TaskFormFillingOut) {
      emit((state as TaskFormFillingOut).copyWith(entity: entity));
    }
  }

  void clearEntity() {
    if (state is TaskFormFillingOut) {
      emit((state as TaskFormFillingOut).copyWith(entity: null));
    }
  }

  void openCalendarToSetDeadline(BuildContext context) {
    // TODO: auto setting correct locale
    LocaleType locale = LocaleType.en;

    DatePicker.showDatePicker(context, showTitleActions: true,
        onChanged: (date) {
      setDeadline(date);
    }, onConfirm: (date) {
      setDeadline(date);
    }, currentTime: DateTime.now(), minTime: DateTime.now(), locale: locale);
  }

  void addAttachment(Attachment attachment) {
    if (state is TaskFormFillingOut) {
      List<Attachment> newAttachments = state.attachments.toList()
        ..add(attachment);
      emit((state as TaskFormFillingOut).copyWith(attachments: newAttachments));
    }
  }

  void removeAttachment(Attachment attachment) {
    if (state is TaskFormFillingOut) {
      List<Attachment> newAttachments = state.attachments.toList()
        ..remove(attachment);
      emit((state as TaskFormFillingOut).copyWith(attachments: newAttachments));
    }
  }

  void setDeadline(DateTime dateTime) {
    if (state is TaskFormFillingOut) {
      emit((state as TaskFormFillingOut).copyWith(deadline: dateTime));
    }
  }

  Future<void> submit(
      {required List<Attachment> attachments,
      Task? task,
      String? text,
      String? description,
      Entity? entity,
      DateTime? deadline,
      AppliedIntervention? appliedIntervention,
      ExecutedSurvey? executedSurvey,
      required TaskBloc taskBloc,
      required OrganizationViewBloc organizationViewBloc,
      required UserBloc userBloc}) async {
    emit(TaskFormSavingInProgress(
        attachments: attachments,
        entity: entity,
        deadline: deadline,
        appliedIntervention: appliedIntervention,
        executedSurvey: executedSurvey,
        taskBloc: taskBloc,
        organizationViewBloc: organizationViewBloc,
        userBloc: userBloc));

    try {
      Task? result = await saveTask(
          text: text!,
          task: task,
          attachments: attachments,
          entity: entity,
          description: description,
          deadline: deadline,
          appliedIntervention: appliedIntervention,
          executedSurvey: executedSurvey,
          taskBloc: taskBloc,
          userBloc: userBloc,
          organizationViewBloc: organizationViewBloc);
      emit(TaskFormSuccessfullSubmitted(
          task: result,
          attachments: attachments,
          userBloc: userBloc,
          taskBloc: taskBloc,
          organizationViewBloc: organizationViewBloc,
          appliedIntervention: appliedIntervention,
          executedSurvey: executedSurvey,
          deadline: deadline,
          entity: entity));
    } catch (e) {
      // TODO: show error messages
      emit(TaskFormFillingOut(
        attachments: attachments,
        entity: entity,
        task: task,
        appliedIntervention: appliedIntervention,
        executedSurvey: executedSurvey,
        taskBloc: taskBloc,
        organizationViewBloc: organizationViewBloc,
        userBloc: userBloc,
        deadline: deadline,
      ));
    }
  }

  Future<Task?> saveTask(
      {required List<Attachment> attachments,
      Task? task,
      required String text,
      Entity? entity,
      DateTime? deadline,
      AppliedIntervention? appliedIntervention,
      ExecutedSurvey? executedSurvey,
      String? description,
      required TaskBloc taskBloc,
      required OrganizationViewBloc organizationViewBloc,
      required UserBloc userBloc}) async {
    List<int> audioList = [];
    List<int> picList = [];
    for (var element in attachments) {
      if (element is ImageAttachment) {
        int toSetInt;
        if (picList.isEmpty) {
          toSetInt = 0;
        } else {
          toSetInt = picList.reduce(max) + 1;
        }
        picList.add(toSetInt);
        element.number = toSetInt;
      } else {
        int toSetInt;
        if (audioList.isEmpty) {
          toSetInt = 0;
        } else {
          toSetInt = audioList.reduce(max) + 1;
        }
        audioList.add(toSetInt);
        element.number = toSetInt;
      }
    }
    Task toSave;
    if (task == null) {
      toSave = Task(
          id: UUID.getUUID(),
          title: text,
          dueDate: deadline,
          text: description,
          appliedIntervention: appliedIntervention,
          executedSurvey: executedSurvey,
          entity: entity,
          user: userBloc.state.user!,
          audioList: audioList,
          picList: picList);
    } else {
      toSave = task;
      toSave.title = text;
      toSave.dueDate = deadline;
      toSave.appliedIntervention = appliedIntervention;
      toSave.executedSurvey = executedSurvey;
      toSave.entity = entity;
      toSave.user = userBloc.state.user!;
      toSave.audioList = audioList;
      toSave.picList = picList;
      toSave.text = description;
    }
    if (task != null) {
      taskBloc.add(UpdateTask(toSave));
    } else {
      taskBloc.add(CreateTask(toSave));
    }
    for (Attachment attachment in attachments) {
      if (attachment is ImageAttachment) {
        SyncedFile syncedFile =
            TaskRepository.getTaskPic(toSave, attachment.number!);
        syncedFile.updateAsBytes(attachment.toFile());
      } else {
        SyncedFile syncedFile =
            TaskRepository.getTaskAudio(toSave, attachment.number!);
        syncedFile.updateAsAudio(attachment.toFile());
      }
    }

    return toSave;
  }
}
