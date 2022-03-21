import 'package:mobile_app/backend/callableModels/CallableModels.dart';

class OrganizationViewState {}

class EntitiesLoadedOrganizationViewState extends OrganizationViewState {
  final List<Entity> allEntities;
  final OrganizationViewType organizationViewType;
  final Entity? currentDetailEntity;
  final List<Entity> currentListEntities;
  final String appBarString;
  final bool addEntityPossible;

  Entity entityByID(String id) => allEntities.firstWhere((e) => e.id == id);

  List<Entity> entitiesByParentID(String? id) {
    return List.from(
        allEntities.where((element) => element.parentEntityID == id));
  }

  List<Level> getLevelsInOrder() {
    List<Level> toOrder = [];
    allEntities.forEach((element) {
      if (!toOrder.contains(element.level)) {
        toOrder.add(element.level);
      }
    });
    int parentIndex =
        toOrder.indexWhere((element) => element.parentLevelID == null);
    List<Level> inOrder = [toOrder.removeAt(parentIndex)];
    while (toOrder.isNotEmpty) {
      int removeIndex = toOrder
          .indexWhere((element) => element.parentLevelID == inOrder.last.id);
      inOrder.add(toOrder.removeAt(removeIndex));
    }
    return inOrder;
  }

  Level getCurrentLevel() {
    return currentListEntities.first.level;
  }

  EntitiesLoadedOrganizationViewState(
      {required this.allEntities,
      required this.organizationViewType,
      this.currentDetailEntity,
      required this.currentListEntities,
      required this.appBarString,
      required this.addEntityPossible});

  EntitiesLoadedOrganizationViewState copyWith(
      {List<Entity>? allEntities,
      OrganizationViewType? organizationViewType,
      Entity? currentDetailEntity,
      List<Entity>? currentListEntities,
      String? appBarString,
      bool? addEntityPossible}) {
    return EntitiesLoadedOrganizationViewState(
        allEntities: allEntities ?? this.allEntities,
        organizationViewType: organizationViewType ?? this.organizationViewType,
        currentListEntities: currentListEntities ?? this.currentListEntities,
        currentDetailEntity: currentDetailEntity,
        appBarString: appBarString ?? this.appBarString,
        addEntityPossible: addEntityPossible ?? this.addEntityPossible);
  }
}

enum OrganizationViewType {
  LIST,
  OVERVIEW,
  INFO,
  SURVEYS,
  APPLIEDINTERVENTIONS,
  TASKS,
  HISTORY
}

class LoadingOrganizationViewState extends OrganizationViewState {}
