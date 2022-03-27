import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/backend/Blocs/task/task_events.dart';
import 'package:mobile_app/backend/Blocs/task/task_state.dart';
import 'package:mobile_app/backend/callableModels/Task.dart';
import 'package:mobile_app/backend/repositories/TaskRepository.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskRepository taskRepository;

  TaskBloc(this.taskRepository) : super(LoadingTaskState()) {
    on<TaskEvent>(_mapEventToState);

    taskRepository.getAllTasks().then((value) {
      // ignore: invalid_use_of_visible_for_testing_member
      emit(LoadedTaskState(allTasks: value));

      print((state as LoadedTaskState).allTasks.length.toString());
    });
  }

  @override
  Future<void> close() {
    return super.close();
  }

  void _mapEventToState(TaskEvent event, Emitter<TaskState> emit) async {
    print(state.toString());

    print(event.toString());
    try {
      LoadedTaskState loadedTaskState = state as LoadedTaskState;
      print(loadedTaskState.allTasks.toString());
    } catch (e) {}
    if (state is LoadedTaskState) {
      LoadedTaskState loadedTaskState = state as LoadedTaskState;
      if (event is CreateTask) {
        Task toAdd =
            await taskRepository.createTask((event as CreateTask).task);
        List<Task> newList = List.from(loadedTaskState.allTasks);

        newList.add(toAdd);

        emit(loadedTaskState.copyWith(allTasks: newList));
      } else if (event is UpdateTask) {
        Task toUpdate =
            await taskRepository.updateTask((event as UpdateTask).task);
        List<Task> newList = List.from(loadedTaskState.allTasks);

        int index = newList.indexWhere((element) => element.id == toUpdate.id);
        if (index >= 0) {
          newList[index] = toUpdate;
        } else {
          newList.add(toUpdate);
        }

        emit(loadedTaskState.copyWith(allTasks: newList));
      }
    }
  }
}
