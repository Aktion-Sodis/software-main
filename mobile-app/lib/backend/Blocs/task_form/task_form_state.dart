part of 'task_form_cubit.dart';

@immutable
abstract class TaskFormState {
  late final List<Attachment> attachments;
  final DateTime? deadline;
  late final List<Entity> entities;

  TaskFormState(
      {List<Attachment>? attachments, this.deadline, List<Entity>? entities}) {
    this.attachments = attachments ?? [];
    this.entities = entities ?? [];
  }
}

class TaskFormFillingOut extends TaskFormState {
  TaskFormFillingOut(
      {List<Attachment>? attachments,
      DateTime? deadline,
      List<Entity>? entities})
      : super(attachments: attachments, deadline: deadline, entities: entities);
}

class TaskFormSuccessfullSubmitted extends TaskFormState {}
