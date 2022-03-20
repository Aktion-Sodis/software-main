class InAppState {
  CurrentArea currentArea;

  InAppState({required this.currentArea});
}

enum CurrentArea {
  USER,
  SURVEY,
  MAIN_MENU,
}
