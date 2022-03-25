import 'package:mobile_app/backend/callableModels/CallableModels.dart';
import 'package:mobile_app/models/ModelProvider.dart' as amp;

abstract class ContentState {}

class LoadingContentState extends ContentState {}

class LoadedContentState extends ContentState {
  //first two have same length and sort
  final List<amp.InterventionContentRelation> allRelations;
  final List<Content> allContents;

  final List<Content> contentsToDisplay;
  final List<Intervention> selectedInterventions;

  bool isSelectedIntervention(Intervention intervention) {
    return selectedInterventions
        .any((element) => element.id == intervention.id);
  }

  LoadedContentState(
      {required this.allRelations,
      required this.allContents,
      required this.contentsToDisplay,
      required this.selectedInterventions});

  LoadedContentState copyWith(
      {List<amp.InterventionContentRelation>? allRelations,
      List<Content>? allContents,
      List<Content>? contentsToDisplay,
      List<Intervention>? selectedInterventions}) {
    return LoadedContentState(
        allRelations: allRelations ?? this.allRelations,
        allContents: allContents ?? this.allContents,
        contentsToDisplay: contentsToDisplay ?? this.contentsToDisplay,
        selectedInterventions:
            selectedInterventions ?? this.selectedInterventions);
  }
}
