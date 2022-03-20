import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mobile_app/backend/callableModels/CallableModels.dart';
import 'package:mobile_app/backend/callableModels/localModels/attachment.dart';

part 'task_form_state.dart';

abstract class TaskFormCubit extends Cubit<TaskFormState> {
  TaskFormCubit() : super(TaskFormFillingOut());

  void takePhoto() {
    // TODO: implement takePhoto
  }

  @override
  void addEntity(Entity entity) {
    // TODO: implement addEntity
  }

  @override
  void openCalendarToSetDeadline() {
    // TODO: implement openCalendarToSetDeadline
  }

  @override
  void recordAudio() {
    // TODO: implement recordAudio
  }

  @override
  void setDeadline(DateTime dateTime) {
    // TODO: implement setDeadline
  }

  void submit(String text, List<Attachment> attachments, List<Entity> entities,
      DateTime? deadline);
}
