import 'package:mobile_app/backend/callableModels/AppliedIntervention.dart';
import 'package:mobile_app/backend/callableModels/CallableModels.dart';
import 'package:mobile_app/backend/callableModels/Survey.dart';

abstract class OrganizationViewEvent {}

class BackTapEvent extends OrganizationViewEvent {}

class NavigateToDaughterView extends OrganizationViewEvent {
  String parentID;
  NavigateToDaughterView(this.parentID);
}

class NavigateToEntityOverview extends OrganizationViewEvent {
  Entity entity;
  NavigateToEntityOverview(this.entity);
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

class NavigateToEntityHistory extends OrganizationViewEvent {
  Entity entity;
  NavigateToEntityHistory(this.entity);
}

class NavigateToEntityAppliedInterventions extends OrganizationViewEvent {
  Entity entity;
  NavigateToEntityAppliedInterventions(this.entity);
}

class StartSurvey extends OrganizationViewEvent {
  Survey survey;
  AppliedIntervention appliedIntervention;
  StartSurvey(this.survey, this.appliedIntervention);
}

class AddEntity extends OrganizationViewEvent {
  Entity entity;
  AddEntity(this.entity);
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
