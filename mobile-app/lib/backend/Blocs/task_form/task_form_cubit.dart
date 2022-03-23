import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/backend/Blocs/task_form/add_task_cubit.dart';
import 'package:mobile_app/backend/callableModels/CallableModels.dart';
import 'package:mobile_app/backend/callableModels/localModels/attachment.dart';
import 'package:mobile_app/backend/callableModels/localModels/image_attachment.dart';
import 'package:mobile_app/services/photo_capturing.dart';
import 'package:mobile_app/services/storage.dart';
import 'package:path_provider/path_provider.dart';

part 'task_form_state.dart';

abstract class TaskFormCubit extends Cubit<TaskFormState> {
  TaskFormCubit() : super(TaskFormFillingOut());

  static TaskFormCubit initialize<T extends TaskFormCubit>() {
    switch (T) {
      default:
        return AddTaskCubit();
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

  void addEntity(Entity entity) {
    // TODO: implement addEntity
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

  void submit(String text, List<Attachment> attachments, List<Entity> entities,
      DateTime? deadline);
}
