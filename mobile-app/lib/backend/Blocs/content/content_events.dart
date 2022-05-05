import 'package:mobile_app/backend/callableModels/CallableModels.dart';
import 'package:mobile_app/backend/callableModels/Intervention.dart';

abstract class ContentEvent {}

class AddInterventionFilter extends ContentEvent {
  Intervention intervention;
  AddInterventionFilter(this.intervention);
}

class RemoveInterventionFilter extends ContentEvent {
  Intervention intervention;
  RemoveInterventionFilter(this.intervention);
}

class UpdateSelectedInterventions extends ContentEvent {
  List<Intervention> selectedInterventions;
  UpdateSelectedInterventions(this.selectedInterventions);
}
