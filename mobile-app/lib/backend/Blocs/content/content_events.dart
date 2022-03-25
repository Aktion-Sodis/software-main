import 'package:mobile_app/backend/callableModels/Intervention.dart';

abstract class ContentEvent {}

class AddInterventionFilter {
  Intervention intervention;
  AddInterventionFilter(this.intervention);
}

class RemoveInterventionFilter {
  Intervention intervention;
  RemoveInterventionFilter(this.intervention);
}
