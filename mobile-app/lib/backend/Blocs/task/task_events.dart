import 'package:mobile_app/backend/callableModels/CallableModels.dart';

abstract class TaskEvent {}

class CreateTask extends TaskEvent {
  final Task task;

  CreateTask(this.task);
}

class UpdateTask extends TaskEvent {
  final Task task;

  UpdateTask(this.task);
}
