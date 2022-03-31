abstract class SyncState {}

class PrepareSyncState extends SyncState {}

class InSyncState extends SyncState {
  final int totalFiles;
  final int loadedFiles;
  final int progress;
  InSyncState(
      {required this.totalFiles,
      required this.loadedFiles,
      required this.progress});

  InSyncState copyWith({int? totalFiles, int? loadedFiles}) {
    totalFiles = totalFiles ?? this.totalFiles;
    loadedFiles = loadedFiles ?? this.loadedFiles;
    int progressToSet;
    if (totalFiles == 0) {
      progressToSet = 100;
    } else {
      progressToSet = ((loadedFiles / totalFiles) * 100).round();
    }
    return InSyncState(
        totalFiles: totalFiles,
        loadedFiles: loadedFiles,
        progress: progressToSet);
  }
}

class CannotSyncState extends SyncState {}

class FullySyncedState extends SyncState {}
