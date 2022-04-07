import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/backend/Blocs/content/content_bloc.dart';
import 'package:mobile_app/backend/Blocs/organization_view/organization_view_bloc.dart';
import 'package:mobile_app/backend/Blocs/organization_view/organization_view_state.dart';
import 'package:mobile_app/backend/Blocs/sync/sync_events.dart';
import 'package:mobile_app/backend/Blocs/sync/sync_state.dart';
import 'package:mobile_app/backend/Blocs/task/task_bloc.dart';
import 'package:mobile_app/backend/Blocs/user/user_bloc.dart';
import 'package:mobile_app/backend/callableModels/CallableModels.dart';
import 'package:mobile_app/backend/repositories/AppliedInterventionRepository.dart';
import 'package:mobile_app/backend/repositories/ContentRepository.dart';
import 'package:mobile_app/backend/repositories/EntityRepository.dart';
import 'package:mobile_app/backend/repositories/ExecutedSurveyRepository.dart';
import 'package:mobile_app/backend/repositories/InterventionRepository.dart';
import 'package:mobile_app/backend/repositories/LevelRepository.dart';
import 'package:mobile_app/backend/repositories/SurveyRepository.dart';
import 'package:mobile_app/backend/repositories/TaskRepository.dart';
import 'package:mobile_app/backend/repositories/UserRepository.dart';
import 'package:mobile_app/backend/storage/image_synch.dart';
import 'package:mobile_app/backend/storage/storage_repository.dart';
import 'package:mobile_app/models/InterventionContentRelation.dart';

class SyncBloc extends Bloc<SyncEvent, SyncState> {
  TaskBloc taskBloc;
  UserBloc userBloc;

  SyncBloc({
    required this.taskBloc,
    required this.userBloc,
  }) : super(PrepareSyncState()) {
    on<SyncEvent>(_mapEventToState);
    fulfillSync();
  }

  void _mapEventToState(SyncEvent event, Emitter<SyncState> emit) async {
    if (event is StartSyncEvent) {
      if ((state is! InSyncState)) {
        emit(InSyncState(totalFiles: 0, loadedFiles: 0, progress: 0));
      }
    } else if (event is StartLoadingFileEvent) {
      if (state is InSyncState) {
        emit((state as InSyncState)
            .copyWith(totalFiles: (state as InSyncState).totalFiles + 1));
      } else {
        emit(InSyncState(totalFiles: 1, loadedFiles: 0, progress: 0));
      }
    } else if (event is LoadedFileEvent) {
      if (state is InSyncState) {
        InSyncState inSyncState = state as InSyncState;
        if (inSyncState.loadedFiles + 1 == inSyncState.totalFiles) {
          add(FinishedSyncEvent());
        } else {
          emit(inSyncState.copyWith(loadedFiles: inSyncState.loadedFiles + 1));
        }
      }
    } else if (event is FinishedSyncEvent) {
      emit(FullySyncedState());
    } else if (event is CancelSyncEvent) {
      emit(CannotSyncState());
    }
  }

  void fulfillSync() async {
    InternetConnectionType internetConnectionType =
        await StorageRepository.currentInternetConnectionType();
    if (internetConnectionType != InternetConnectionType.WIFI) {
      add(CancelSyncEvent());
      return;
    }
    add(StartSyncEvent());
    List<Future> toWaitData = [
      EntityRepository.getAllEntities(),
      taskBloc.taskRepository.getAllTasks(),
      ContentRepository.getAllRelationsWithPopulatedContentsAndInterventions(),
    ];
    List<dynamic> data = await Future.wait(toWaitData);
    List<Entity> allEntities = data[0] as List<Entity>;
    List<Task> allTasksToSync = data[1] as List<Task>;
    List<InterventionContentRelation> allContentRelations =
        data[2] as List<InterventionContentRelation>;
    List<Level> allLevels = [];
    List<Content> allContents = [];
    List<Intervention> allInterventions = [];
    for (InterventionContentRelation interventionContentRelation
        in allContentRelations) {
      if (!allContents.any(
          (element) => element.id == interventionContentRelation.content.id)) {
        allContents
            .add(Content.fromAmplifyModel(interventionContentRelation.content));
      }
    }
    for (var entity in allEntities) {
      if (!allLevels.any((element) => element.id == entity.level.id!)) {
        allLevels.add(entity.level);
      }
    }
    for (Level level in allLevels) {
      if (level.interventionsAreAllowed) {
        List<Intervention> toAdd =
            await InterventionRepository.getInterventionsByLevelConnections(
                level.allowedInterventions!);
        for (Intervention intervention in toAdd) {
          if (!allInterventions
              .any((element) => element.id == intervention.id)) {
            allInterventions.add(intervention);
          }
        }
      }
    }
    syncLevels(allLevels);
    syncInterventions(allInterventions);
    syncTasks(allTasksToSync);
    syncContents(allContents);
    syncEntities(allEntities);
    if (userBloc.state.user != null) {
      syncUser(userBloc.state.user!);
    }
  }

  void syncLevels(List<Level> levels) async {
    for (Level level in levels) {
      LevelRepository.getLevelPicFile(level).sync(this);
      for (CustomData customData in level.customData) {
        LevelRepository.getCustomDataPicFile(level, customData).sync(this);
      }
    }
  }

  void syncInterventions(List<Intervention> interventions) async {
    for (Intervention intervention in interventions) {
      InterventionRepository.getInterventionPic(intervention).sync(this);
      for (Survey survey in intervention.surveys) {
        SurveyRepository.getSurveyPic(survey).sync(this);
        for (Question question in survey.questions) {
          SurveyRepository.getQuestionPic(survey, question).sync(this);
          if (question.questionOptions != null) {
            for (QuestionOption questionOption in question.questionOptions!) {
              SurveyRepository.getQuestionOptionPic(
                      survey, question, questionOption)
                  .sync(this);
            }
          }
        }
      }
    }
  }

  void syncTasks(List<Task> tasks) async {
    for (Task task in tasks) {
      for (int audioID in task.audioList) {
        TaskRepository.getTaskAudio(task, audioID).sync(this);
      }
      for (int picID in task.picList) {
        TaskRepository.getTaskPic(task, picID).sync(this);
      }
    }
  }

  void syncContents(List<Content> contents) async {
    for (Content content in contents) {
      ContentRepository.getContentPDFFile(content).sync(this);
      ContentRepository.getContentPic(content).sync(this);
    }
  }

  void syncEntities(List<Entity> allEntities) async {
    for (Entity entity in allEntities) {
      EntityRepository.getEntityPic(entity).sync(this);
      for (AppliedIntervention appliedIntervention
          in entity.appliedInterventions) {
        AppliedInterventionRepository.appliedInterventionPic(
                appliedIntervention)
            .sync(this);
        for (ExecutedSurvey executedSurvey
            in appliedIntervention.executedSurveys) {
          for (QuestionAnswer questionAnswer in executedSurvey.answers) {
            if (questionAnswer.type == QuestionType.AUDIO) {
              ExecutedSurveyRepository.getQuestionAnswerAudio(
                      appliedIntervention,
                      executedSurvey.id!,
                      executedSurvey.survey.questions.firstWhere(
                          (element) => element.id == questionAnswer.id!))
                  .sync(this);
            } else if (questionAnswer.type == QuestionType.PICTURE ||
                questionAnswer.type == QuestionType.PICTUREWITHTAGS) {
              ExecutedSurveyRepository.getQuestionAnswerPic(
                      appliedIntervention,
                      executedSurvey.id!,
                      executedSurvey.survey.questions.firstWhere(
                          (element) => element.id == questionAnswer.id!))
                  .sync(this);
            }
          }
        }
      }
    }
  }

  void syncUser(User user) async {
    UserRepository.getUserPicFile(user).sync(this);
  }
}
