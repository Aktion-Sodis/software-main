import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mobile_app/backend/callableModels/CallableModels.dart';
import 'package:mobile_app/backend/callableModels/localModels/attachment.dart';

part 'task_form_state.dart';

abstract class TaskFormCubit extends Cubit<TaskFormState> {
  TaskFormCubit() : super(TaskFormFillingOut());

  void recordAudio();

  void takePhoto();

  void setDeadline(DateTime dateTime);

  void openCalendarToSetDeadline();

  void addEntity(Entity entity);

  void submit(String text, List<Attachment> attachments, List<Entity> entities,
      DateTime deadline);
}
