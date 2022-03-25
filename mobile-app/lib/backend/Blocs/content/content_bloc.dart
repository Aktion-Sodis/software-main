import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/backend/Blocs/content/content_events.dart';
import 'package:mobile_app/backend/Blocs/content/content_state.dart';
import 'package:mobile_app/backend/callableModels/CallableModels.dart';
import 'package:mobile_app/backend/repositories/ContentRepository.dart';
import 'package:mobile_app/models/InterventionContentRelation.dart';

class ContentBloc extends Bloc<ContentEvent, ContentState> {
  ContentRepository contentRepository;

  ContentBloc(this.contentRepository) : super(LoadingContentState()) {
    on<ContentEvent>(_mapEventToState);
    ContentRepository.getAllRelationsWithPopulatedContents().then((value) {
      List<InterventionContentRelation> all = value;
      List<Content> allContents = List.generate(
          all.length, (index) => Content.fromAmplifyModel(all[index].content));
      List<Intervention> toDisplayInterventions = [];
      List<Content> toDisplayContents = List.from(allContents);
      emit(LoadedContentState(
          allRelations: all,
          allContents: allContents,
          contentsToDisplay: toDisplayContents,
          selectedInterventions: toDisplayInterventions));
    });
  }

  void _mapEventToState(ContentEvent event, Emitter<ContentState> emit) async {
    if (state is LoadedContentState) {
      LoadedContentState loadedState = state as LoadedContentState;
      if (event is AddInterventionFilter) {
        List<Intervention> newInterventions =
            List.from(loadedState.selectedInterventions);
        newInterventions.add((event as AddInterventionFilter).intervention);
        List<Content> toDisplayContent =
            toDisplay(loadedState, newInterventions);
        emit(loadedState.copyWith(
            selectedInterventions: newInterventions,
            contentsToDisplay: toDisplayContent));
      } else if (event is RemoveInterventionFilter) {
        List<Intervention> newInterventions =
            List.from(loadedState.selectedInterventions);
        newInterventions.removeWhere((obj) =>
            (event as AddInterventionFilter).intervention.id == obj.id);
        List<Content> toDisplayContent =
            toDisplay(loadedState, newInterventions);
        emit(loadedState.copyWith(
            selectedInterventions: newInterventions,
            contentsToDisplay: toDisplayContent));
      }
    }
  }

  List<Content> toDisplay(LoadedContentState loadedContentState,
      List<Intervention> toDisplayInterventions) {
    if (toDisplayInterventions.isEmpty) {
      return loadedContentState.allContents;
    } else {
      List<Content> toReturn = [];
      for (int i = 0; i < loadedContentState.allRelations.length; i++) {
        if (toDisplayInterventions.any((element) =>
            element.id == loadedContentState.allRelations[i].intervention.id)) {
          toReturn.add(loadedContentState.allContents[i]);
        }
      }
      return toReturn;
    }
  }
}
