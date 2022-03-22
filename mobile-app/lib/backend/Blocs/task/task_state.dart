import 'package:mobile_app/backend/callableModels/Task.dart';

abstract class TaskState {}

class LoadingTaskState extends TaskState {}

class LoadedTaskState extends TaskState {
  final List<Task> allTasks;
  LoadedTaskState(this.allTasks);
  LoadedTaskState copyWith(List<Task> allTasks) {
    return LoadedTaskState(allTasks);
  }

  List<Task> tasksByEntity(String entityID) =>
      List.from(allTasks.where((obj) => obj.entity?.id == entityID));

  List<Task> firstThreeUndoneTasks({String? entityID}) {
    List<Task> toSort = entityID != null ? tasksByEntity(entityID) : allTasks;
    toSort.sort((a, b) {
      Duration timeDifference = (a.dueDate ??
              DateTime.now().add(Duration(days: 100)))
          .difference((b.dueDate ?? DateTime.now().add(Duration(days: 100))));
      //negativ, wenn b nach a
      return timeDifference.inHours;
    });
    if (toSort.length < 4) {
      return toSort;
    } else {
      return toSort.sublist(0, 3);
    }
  }
}
