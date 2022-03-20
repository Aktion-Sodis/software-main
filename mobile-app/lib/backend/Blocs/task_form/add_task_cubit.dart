import 'package:mobile_app/backend/Blocs/task_form/task_form_cubit.dart';
import 'package:mobile_app/backend/callableModels/localModels/attachment.dart';
import 'package:mobile_app/backend/callableModels/Entity.dart';

class AddTaskCubit extends TaskFormCubit {
  @override
  void submit(String text, List<Attachment> attachments, List<Entity> entities,
      DateTime? deadline) {
    // TODO: implement submit
  }
}
