import 'package:mobile_app/backend/callableModels/CallableModels.dart';

class OrganizationViewState {}

class EntitiesLoadedOrganizationViewState extends OrganizationViewState {
  final List<Level> allLevels;
  final OrganizationViewType organizationViewType;
  final Entity? currentDetailEntity;
  final String appBarString;
  final bool addEntityPossible;
  final AppliedIntervention? currentDetailAppliedIntervention;
  final ExecutedSurvey? executedSurveyToDisplay;
  final List<LevelContent> levelContentList;
  late final DateTime keyDateTime;

  LevelContent get currentLevelContent {
    return levelContentList.last;
  }

  bool addChildPossible(Entity entity) {
    List<Level> levelsInOrder = allLevels;
    return levelsInOrder.last.id != entity.level.id;
  }

  Level getCurrentLevel() {
    return levelContentList.last.level;
  }

  Level? getDaughterLevel(Level level) {
    return allLevels.firstWhere((element) => element.parentLevelID == level.id);
  }

  EntitiesLoadedOrganizationViewState({
    required this.allLevels,
    required this.organizationViewType,
    this.currentDetailEntity,
    required this.levelContentList,
    required this.appBarString,
    required this.addEntityPossible,
    this.currentDetailAppliedIntervention,
    this.executedSurveyToDisplay,
  }) {
    this.keyDateTime = DateTime.now();
    print("loaded state newly created");
  }

  /**
   * Notice: `currentDetailEntity` will be taken exactly like it stands in the arguments
   */
  EntitiesLoadedOrganizationViewState copyWith(
      {List<Level>? allLevels,
      OrganizationViewType? organizationViewType,
      Entity? currentDetailEntity,
      String? appBarString,
      bool? addEntityPossible,
      AppliedIntervention? currentDetailAppliedIntervention,
      ExecutedSurvey? executedSurveyToDisplay,
      List<LevelContent>? levelContentList}) {
    return EntitiesLoadedOrganizationViewState(
        allLevels: allLevels ?? this.allLevels,
        organizationViewType: organizationViewType ?? this.organizationViewType,
        currentDetailEntity: currentDetailEntity,
        appBarString: appBarString ?? this.appBarString,
        addEntityPossible: addEntityPossible ?? this.addEntityPossible,
        currentDetailAppliedIntervention: currentDetailAppliedIntervention ??
            this.currentDetailAppliedIntervention,
        executedSurveyToDisplay: executedSurveyToDisplay,
        levelContentList: levelContentList ?? this.levelContentList);
  }
}

class LevelContent {
  Level level;
  Entity? parentEntity;
  List<Entity> daughterEntities = [];
  int page = 0;
  bool hasMoreToLoad = true;

  LevelContent(this.level, this.parentEntity);
}

enum OrganizationViewType {
  LIST,
  OVERVIEW,
  INFO,
  SURVEYS,
  APPLIEDINTERVENTIONS,
  APPLIEDINTERVENTIONDETAIL,
  TASKS,
  HISTORY,
  EXECUTEDSURVEY
}

class LoadingOrganizationViewState extends OrganizationViewState {}
