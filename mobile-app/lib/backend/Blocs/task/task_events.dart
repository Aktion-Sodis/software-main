import 'package:mobile_app/backend/callableModels/CallableModels.dart';

abstract class TaskEvent {}

class CreateTask {
  final Task task;
  CreateTask(this.task);
}

class UpdateTask {
  final Task task;
  UpdateTask(this.task);
}
