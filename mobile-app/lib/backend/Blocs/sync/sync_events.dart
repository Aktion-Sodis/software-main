abstract class SyncEvent {}

class StartSyncEvent extends SyncEvent {}

class LoadedFileEvent extends SyncEvent {}

class StartLoadingFileEvent extends SyncEvent {}

class FinishedSyncEvent extends SyncEvent {}

class CancelSyncEvent extends SyncEvent {}
