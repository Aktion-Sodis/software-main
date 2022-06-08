import 'package:mobile_app/backend/callableModels/AppliedIntervention.dart';
import 'package:mobile_app/backend/callableModels/CallableModels.dart';
import 'package:mobile_app/backend/callableModels/Survey.dart';

abstract class OrganizationViewEvent {}

class BackTapEvent extends OrganizationViewEvent {}

class NavigateToDaughterView extends OrganizationViewEvent {
  Entity parent;
  NavigateToDaughterView(this.parent);
}

class LoadDaughterEntities extends OrganizationViewEvent {
  Entity? parent;
  int page;
  LoadDaughterEntities(this.parent, this.page);
}

class NavigateToEntityOverview extends OrganizationViewEvent {
  Entity entity;
  NavigateToEntityOverview(this.entity);
}

class AddExecutedSurvey extends OrganizationViewEvent {
  Entity entity;
  AppliedIntervention appliedIntervention;
  ExecutedSurvey executedSurvey;

  AddExecutedSurvey(this.entity, this.appliedIntervention, this.executedSurvey);
}

class NavigateToEntityTasks extends OrganizationViewEvent {
  Entity entity;
  NavigateToEntityTasks(this.entity);
}

class NavigateToEntityInfo extends OrganizationViewEvent {
  Entity entity;
  NavigateToEntityInfo(this.entity);
}

class NavigateToEntitySurveys extends OrganizationViewEvent {
  Entity entity;
  NavigateToEntitySurveys(this.entity);
}

class NavigateToExecutedSurvey extends OrganizationViewEvent {
  ExecutedSurvey executedSurvey;
  NavigateToExecutedSurvey(this.executedSurvey);
}

class NavigateToEntityHistory extends OrganizationViewEvent {
  Entity entity;
  NavigateToEntityHistory(this.entity);
}

class NavigateToEntityAppliedInterventions extends OrganizationViewEvent {
  Entity entity;
  NavigateToEntityAppliedInterventions(this.entity);
}

class NavigateToEntityAppliedInterventionDetail extends OrganizationViewEvent {
  AppliedIntervention appliedIntervention;
  NavigateToEntityAppliedInterventionDetail(this.appliedIntervention);
}

class StartSurvey extends OrganizationViewEvent {
  Survey survey;
  AppliedIntervention appliedIntervention;
  Entity entity;
  StartSurvey(this.survey, this.appliedIntervention, this.entity);
}

class AddEntity extends OrganizationViewEvent {
  Entity entity;
  //bool isDaughter;
  AddEntity(
    this.entity,
    /*{this.isDaughter = false}*/
  );
}

class UpdateEntity extends OrganizationViewEvent {
  Entity entity;
  UpdateEntity(this.entity);
}

class AddAppliedIntervention extends OrganizationViewEvent {
  Entity entity;
  AppliedIntervention appliedIntervention;

  AddAppliedIntervention(this.entity, this.appliedIntervention);
}

class UpdateAppliedIntervention extends OrganizationViewEvent {
  Entity entity;
  AppliedIntervention appliedIntervention;

  UpdateAppliedIntervention(this.entity, this.appliedIntervention);
}

class UpdatePic extends OrganizationViewEvent {}
