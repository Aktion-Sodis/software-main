class InAppState {
  final CurrentArea currentArea;

  InAppState({required this.currentArea});

  InAppState copyWith({CurrentArea? currentArea}) {
    return InAppState(currentArea: currentArea ?? this.currentArea);
  }
}

enum CurrentArea {
  USER,
  SURVEY,
  MAIN_MENU,
}
