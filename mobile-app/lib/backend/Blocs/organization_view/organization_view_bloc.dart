import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/backend/Blocs/inapp/inapp_bloc.dart';
import 'package:mobile_app/backend/Blocs/inapp/inapp_event.dart';
import 'package:mobile_app/backend/Blocs/organization_view/organization_view_events.dart';
import 'package:mobile_app/backend/Blocs/organization_view/organization_view_state.dart';
import 'package:mobile_app/backend/callableModels/CallableModels.dart';
import 'package:mobile_app/backend/repositories/AppliedInterventionRepository.dart';
import 'package:mobile_app/backend/repositories/EntityRepository.dart';
import 'package:mobile_app/frontend/strings.dart' as strings;

class OrganizationViewBloc
    extends Bloc<OrganizationViewEvent, OrganizationViewState> {
  EntityRepository entityRepository;
  AppliedInterventionRepository appliedInterventionRepository;
  InAppBloc inAppBloc;

  OrganizationViewBloc(
      this.entityRepository, this.appliedInterventionRepository, this.inAppBloc)
      : super(LoadingOrganizationViewState()) {
    on<OrganizationViewEvent>(_mapEventToState);
    EntityRepository.getAllEntities().then((value) {
      List<Entity> startingEntities =
          List.from(value.where((element) => element.parentEntityID == null));
      String startingAppBarString = startingEntities.first.level.name;

      // ignore: invalid_use_of_visible_for_testing_member
      emit(EntitiesLoadedOrganizationViewState(
          allEntities: value,
          organizationViewType: OrganizationViewType.LIST,
          currentListEntities: startingEntities,
          appBarString: startingAppBarString,
          addEntityPossible: true));
    });
  }

  void _mapEventToState(
      OrganizationViewEvent event, Emitter<OrganizationViewState> emit) async {
    if (state is EntitiesLoadedOrganizationViewState) {
      EntitiesLoadedOrganizationViewState loadedState =
          state as EntitiesLoadedOrganizationViewState;

      if (event is BackTapEvent) {
        switch (loadedState.organizationViewType) {
          case OrganizationViewType.LIST:
            if (loadedState.currentListEntities.first.parentEntityID != null) {
              Entity parentEntity = loadedState.entityByID(
                  loadedState.currentListEntities.first.parentEntityID!);
              print("parent Entity found");
              List<Entity> newListEntities =
                  loadedState.entitiesByParentID(parentEntity.parentEntityID);
              print("daughters of new parent: ${newListEntities.length}");
              print("daughters of new list: ${newListEntities.first.name}");
              String appBarName = newListEntities.first.level.name;
              emit(loadedState.copyWith(
                  currentListEntities: newListEntities,
                  appBarString: appBarName));
            }
            break;
          case OrganizationViewType.OVERVIEW:
            emit(loadedState.copyWith(
                organizationViewType: OrganizationViewType.LIST,
                currentDetailEntity: null,
                appBarString:
                    loadedState.currentListEntities.first.level.name));
            break;
          case OrganizationViewType.APPLIEDINTERVENTIONS:
            emit(loadedState.copyWith(
                organizationViewType: OrganizationViewType.OVERVIEW,
                currentDetailEntity: loadedState.currentDetailEntity,
                appBarString: loadedState.currentDetailEntity!.name));
            break;
          case OrganizationViewType.APPLIEDINTERVENTIONDETAIL:
            emit(loadedState.copyWith(
                organizationViewType: OrganizationViewType.APPLIEDINTERVENTIONS,
                currentDetailEntity: loadedState.currentDetailEntity,
                appBarString: strings.organization_view_applied_interventions));
            break;
          case OrganizationViewType.SURVEYS:
            emit(loadedState.copyWith(
                organizationViewType: OrganizationViewType.OVERVIEW,
                currentDetailEntity: loadedState.currentDetailEntity,
                appBarString: loadedState.currentDetailEntity!.name));
            break;
          case OrganizationViewType.TASKS:
            emit(loadedState.copyWith(
                organizationViewType: OrganizationViewType.OVERVIEW,
                currentDetailEntity: loadedState.currentDetailEntity,
                appBarString: loadedState.currentDetailEntity!.name));
            break;
          case OrganizationViewType.HISTORY:
            emit(loadedState.copyWith(
                organizationViewType: OrganizationViewType.SURVEYS,
                currentDetailEntity: loadedState.currentDetailEntity,
                appBarString: strings.organization_view_surveys +
                    " (${loadedState.currentDetailEntity!.name})"));
            break;
          case OrganizationViewType.EXECUTEDSURVEY:
            emit(loadedState.copyWith(
                organizationViewType: OrganizationViewType.HISTORY,
                currentDetailEntity: loadedState.currentDetailEntity,
                appBarString: strings.organization_view_history +
                    " (${loadedState.currentDetailEntity!.name})"));
            break;
          default:
            emit(loadedState.copyWith(
                organizationViewType: OrganizationViewType.OVERVIEW,
                appBarString: loadedState.currentDetailEntity!.name));
            break;
        }
      } else if (event is NavigateToDaughterView) {
        List<Entity> newEntities =
            loadedState.entitiesByParentID(event.parentID);
        emit(loadedState.copyWith(
            organizationViewType: OrganizationViewType.LIST,
            currentListEntities: newEntities,
            appBarString: newEntities.first.level.name));
      } else if (event is NavigateToEntityOverview) {
        emit(loadedState.copyWith(
            organizationViewType: OrganizationViewType.OVERVIEW,
            currentDetailEntity: event.entity,
            appBarString: event.entity.name));
      } else if (event is NavigateToEntityTasks) {
        emit(loadedState.copyWith(
            organizationViewType: OrganizationViewType.TASKS,
            currentDetailEntity: event.entity,
            appBarString:
                strings.organization_view_taks + " (${event.entity.name})"));
      } else if (event is NavigateToEntityInfo) {
        emit(loadedState.copyWith(
            organizationViewType: OrganizationViewType.INFO,
            currentDetailEntity: event.entity,
            appBarString:
                strings.organization_view_info + " (${event.entity.name})"));
      } else if (event is NavigateToEntitySurveys) {
        emit(loadedState.copyWith(
            organizationViewType: OrganizationViewType.SURVEYS,
            currentDetailEntity: event.entity,
            appBarString:
                strings.organization_view_surveys + " (${event.entity.name})"));
      } else if (event is NavigateToEntityHistory) {
        emit(loadedState.copyWith(
            organizationViewType: OrganizationViewType.HISTORY,
            currentDetailEntity: event.entity,
            appBarString:
                strings.organization_view_history + " (${event.entity.name})"));
      } else if (event is NavigateToEntityAppliedInterventions) {
        emit(loadedState.copyWith(
            organizationViewType: OrganizationViewType.APPLIEDINTERVENTIONS,
            currentDetailEntity: event.entity,
            appBarString: strings.organization_view_applied_interventions +
                " (${event.entity.name})"));
      } else if (event is StartSurvey) {
        inAppBloc
            .add(StartSurveyEvent(event.survey, event.appliedIntervention));
      } else if (event is AddEntity) {
        Entity newEntity = event.entity;
        String id = await EntityRepository.createEntity(newEntity);
        newEntity.id = id;
        List<Entity> newAllEntities = loadedState.allEntities;
        newAllEntities.add(newEntity);
        List<Entity> newCurrentEntities = loadedState.currentListEntities;
        newCurrentEntities.add(newEntity);
        emit(loadedState.copyWith(
            allEntities: newAllEntities,
            currentListEntities: newCurrentEntities));
      } else if (event is UpdateEntity) {
        EntityRepository.updateEntity(event.entity);
        int index = loadedState.allEntities
            .indexWhere((element) => element.id == event.entity.id);
        List<Entity> newAllEntities = loadedState.allEntities;
        newAllEntities[index] = event.entity;

        int currentIndex = loadedState.currentListEntities
            .indexWhere((element) => element.id == event.entity.id);
        List<Entity> newCurrentEntities = loadedState.currentListEntities;
        if (currentIndex >= 0) {
          newCurrentEntities[currentIndex] = event.entity;
        }
        emit(loadedState.copyWith(
            allEntities: newAllEntities,
            currentListEntities: newCurrentEntities,
            currentDetailEntity: event.entity));
      } else if (event is AddAppliedIntervention) {
        String id =
            await AppliedInterventionRepository.createAppliedIntervention(
                event.appliedIntervention, event.entity);
        print("new InterventionID: $id");
        AppliedIntervention toAdd = event.appliedIntervention;
        toAdd.id = id;
        List<Entity> newAllEntities = loadedState.allEntities;
        int allIndex = newAllEntities
            .indexWhere((element) => element.id == event.entity.id);
        newAllEntities[allIndex].appliedInterventions.add(toAdd);
        List<Entity> newCurrentEntities = loadedState.currentListEntities;
        int currentIndex = newCurrentEntities
            .indexWhere((element) => element.id == event.entity.id);
        if (currentIndex > -1) {
          newCurrentEntities[currentIndex].appliedInterventions.add(toAdd);
        }
        Entity? newCurrentEntity = loadedState.currentDetailEntity;
        if (newCurrentEntity?.id == event.entity.id) {
          newCurrentEntity!.appliedInterventions.add(toAdd);
        }
        emit(loadedState.copyWith(
            allEntities: newAllEntities,
            currentListEntities: newCurrentEntities,
            currentDetailEntity: newCurrentEntity));
      } else if (event is UpdateAppliedIntervention) {
        AppliedInterventionRepository.updateAppliedIntervention(
            event.appliedIntervention, event.entity);
        AppliedIntervention toAdd = event.appliedIntervention;
        Entity toSet = event.entity;
        int aIIndex = toSet.appliedInterventions.indexWhere(
            (element) => element.id == event.appliedIntervention.id);
        toSet.appliedInterventions[aIIndex] = event.appliedIntervention;
        List<Entity> newAllEntities = loadedState.allEntities;
        int allIndex = newAllEntities
            .indexWhere((element) => element.id == event.entity.id);
        newAllEntities[allIndex] = toSet;
        List<Entity> newCurrentEntities = loadedState.currentListEntities;
        int currentIndex = newCurrentEntities
            .indexWhere((element) => element.id == event.entity.id);
        if (currentIndex > -1) {
          newCurrentEntities[currentIndex] = toSet;
        }
        Entity? newCurrentEntity = loadedState.currentDetailEntity;
        if (newCurrentEntity?.id == event.entity.id) {
          newCurrentEntity = toSet;
        }
        emit(loadedState.copyWith(
            allEntities: newAllEntities,
            currentListEntities: newCurrentEntities,
            currentDetailEntity: newCurrentEntity,
            currentDetailAppliedIntervention:
                loadedState.currentDetailAppliedIntervention != null
                    ? toAdd
                    : null));
      } else if (event is NavigateToEntityAppliedInterventionDetail) {
        emit(loadedState.copyWith(
            appBarString: event.appliedIntervention.intervention.name,
            currentDetailEntity: loadedState.currentDetailEntity,
            organizationViewType:
                OrganizationViewType.APPLIEDINTERVENTIONDETAIL,
            currentDetailAppliedIntervention: event.appliedIntervention));
      } else if (event is NavigateToExecutedSurvey) {
        emit(loadedState.copyWith(
          appBarString: event.executedSurvey.date.toString() +
              ": " +
              event.executedSurvey.survey.name,
          currentDetailEntity: loadedState.currentDetailEntity,
          organizationViewType: OrganizationViewType.EXECUTEDSURVEY,
        ));
      }
    }
  }
}
