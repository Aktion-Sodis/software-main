import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:mobile_app/backend/callableModels/CallableModels.dart';
import 'package:mobile_app/backend/repositories/AppliedInterventionRepository.dart';
import 'package:mobile_app/backend/repositories/EntityRepository.dart';
import 'package:mobile_app/backend/repositories/ExecutedSurveyRepository.dart';
import 'package:mobile_app/models/ModelProvider.dart' as amp;

class TaskRepository {
  TaskRepository(this.user);
  User user;

  Future<List<Task>> getAllTasks() async {
    var queryResult = await Amplify.DataStore.query(amp.Task.classType,
        where: amp.Task.USER.eq(user.id));
    var populatedResults = await _populateList(queryResult);
    return List.generate(populatedResults.length,
        (index) => Task.fromAmplifyModel(populatedResults[index]));
  }

  Future<amp.Task> _populate(amp.Task task) async {
    amp.Task toReturn = task;
    toReturn = toReturn.copyWith(
        user: user.toAmplifyModel(),
        entity: toReturn.taskEntityId != null
            ? await EntityRepository.ampEntityByID(toReturn.taskEntityId!)
            : null,
        appliedIntervention: toReturn.taskAppliedInterventionId != null
            ? await AppliedInterventionRepository.getAmpAppliedInterventionByID(
                toReturn.taskAppliedInterventionId!)
            : null,
        executedSurvey: toReturn.taskExecutedSurveyId != null
            ? await ExecutedSurveyRepository.ampExecutedSurveyByID(
                toReturn.taskExecutedSurveyId!)
            : null);
    return toReturn;
  }

  Future<List<amp.Task>> _populateList(List<amp.Task> tasks) {
    List<Future<amp.Task>> toWait =
        List.generate(tasks.length, (index) => _populate(tasks[index]));
    return Future.wait(toWait);
  }

  Future<Task> createTask(Task task) async {
    task.id = task.id ?? UUID().toString();
    Amplify.DataStore.save(task.toAmplifyModel());
    return task;
  }

  Future<Task> updateTask(Task task) async {
    Amplify.DataStore.save(task.toAmplifyModel());
    return task;
  }
}
