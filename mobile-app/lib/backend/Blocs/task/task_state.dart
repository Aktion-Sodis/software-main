import 'package:mobile_app/backend/callableModels/Entity.dart';
import 'package:mobile_app/backend/callableModels/Task.dart';

abstract class TaskState {}

class LoadingTaskState extends TaskState {}

class LoadedTaskState extends TaskState {
  late List<Task> _allTasks;
  List<Task> get allTasks {
    return _allTasks;
  }

  set allTasks(List<Task> toSet) {
    _allTasks = toSet;
  }

  LoadedTaskState({required List<Task> allTasks}) {
    this.allTasks = allTasks;
  }
  LoadedTaskState copyWith({List<Task>? allTasks}) {
    return LoadedTaskState(allTasks: allTasks ?? this.allTasks);
  }

  List<Task> tasksByEntity(String entityID) =>
      List.from(allTasks.where((obj) => obj.entity?.id == entityID));

  List<Task> firstThreeUndoneTasks({String? entityID}) {
    List<Task> toSort =
        entityID != null ? tasksByEntity(entityID) : List.from(allTasks);
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

  List<Task> tasksDueToday({Entity? entity}) {
    List<Task> toSort =
        entity != null ? tasksByEntity(entity.id!) : List.from(allTasks);
    toSort.removeWhere(
        (element) => !sameDayOrBefore(DateTime.now(), element.dueDate!));
    toSort.sort((a, b) => compareTasks(a, b));
    return toSort;
  }

  List<Task> tasksDueTomorrow({Entity? entity}) {
    List<Task> toSort =
        entity != null ? tasksByEntity(entity.id!) : List.from(allTasks);
    toSort.removeWhere((element) =>
        !sameDay(DateTime.now().add(Duration(days: 1)), element.dueDate!));
    toSort.sort((a, b) => compareTasks(a, b));
    return toSort;
  }

  List<Task> otherTasks({Entity? entity}) {
    List<Task> toSort =
        entity != null ? tasksByEntity(entity.id!) : List.from(allTasks);
    toSort.removeWhere((element) =>
        !isAfterDay(DateTime.now().add(Duration(days: 2)), element.dueDate!));
    toSort.sort((a, b) => compareTasks(a, b));
    return toSort;
  }
}

bool sameDay(DateTime one, DateTime two) =>
    (one.year == two.year && one.month == two.month) && (one.day == two.day);

bool sameDayOrBefore(DateTime max, DateTime one) {
  if (one.isBefore(max)) {
    return true;
  } else {
    return sameDay(max, one);
  }
}

bool isAfterDay(DateTime min, DateTime compare) {
  DateTime tocompare = DateTime(min.year, min.month, min.day);
  if (compare.isAfter(tocompare) || compare.isAtSameMomentAs(tocompare)) {
    return true;
  } else {
    return false;
  }
}

int compareTasks(Task one, Task two) {
  bool oneFinished = one.finishedDate != null;
  bool twoFinished = two.finishedDate != null;
  if (oneFinished && !twoFinished) {
    return 1;
  } else if (twoFinished && !oneFinished) {
    return -1;
  } else {
    Duration timeDifference = (one.dueDate ??
            DateTime.now().add(Duration(days: 100)))
        .difference((one.dueDate ?? DateTime.now().add(Duration(days: 100))));
    //negativ, wenn b nach a
    return timeDifference.inHours;
  }
}
