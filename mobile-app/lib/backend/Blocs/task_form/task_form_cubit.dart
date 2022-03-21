import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mobile_app/backend/Blocs/task_form/add_task_cubit.dart';
import 'package:mobile_app/backend/callableModels/CallableModels.dart';
import 'package:mobile_app/backend/callableModels/localModels/attachment.dart';
import 'package:mobile_app/backend/callableModels/localModels/audio_attachment.dart';

part 'task_form_state.dart';

abstract class TaskFormCubit extends Cubit<TaskFormState> {
  TaskFormCubit() : super(TaskFormFillingOut());

  static TaskFormCubit initialize<T extends TaskFormCubit>() {
    switch (T) {
      default:
        return AddTaskCubit();
    }
  }

  void takePhoto() {
    // TODO: implement takePhoto
  }

  void addEntity(Entity entity) {
    // TODO: implement addEntity
  }

  void openCalendarToSetDeadline() {
    // TODO: implement openCalendarToSetDeadline
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
    // TODO: implement setDeadline
  }

  void submit(String text, List<Attachment> attachments, List<Entity> entities,
      DateTime? deadline);
}
