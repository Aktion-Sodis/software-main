import 'dart:typed_data';

import 'package:flutter_sound/flutter_sound.dart';
import 'package:mobile_app/frontend/components/audio/audio_stateful_widget.dart';

/// This class is a wrapper for `flutter_sound`.
///
/// An "opened session" reserves some resources of the device. That is why you
/// should keep as few sessions opened as possible.
///
/// Also, take a look at `RecorderWidget` and `PlayerWidget`,
/// handling opened sessions automatically
class Audio {
  static final Audio instance = Audio();

  final FlutterSoundPlayer _player = FlutterSoundPlayer();
  final FlutterSoundRecorder recorder = FlutterSoundRecorder();
  final List<AudioStatefulWidget> attachedTo = [];
  bool keepSessionOpened = false;
  bool _sessionOpened = false;
  bool get sessionOpened => _sessionOpened;

  void Function()? _onPlayerStop;

  /// You have to open the audio session before using it. The method initState() is a good place for it.
  Future<void> openSession() async {
    await _player.openAudioSession();
    await recorder.openAudioSession();
    _sessionOpened = true;
    _refreshAttachedWidgets();
  }

  /// You have to close the audio session to release all the resources, used by the plugin. The method dispose() is a good place for it.
  Future<void> closeSession() async {
    await _player.closeAudioSession();
    await recorder.closeAudioSession();
    _sessionOpened = false;
    _refreshAttachedWidgets();
  }

  Future<void> startPlayer({
    String? fromURI,
    Uint8List? fromDataBuffer,
    Codec codec = Codec.aacADTS,
    void Function()? whenFinished,
  }) async {
    if (_onPlayerStop != null) _onPlayerStop!();
    _onPlayerStop = whenFinished;
    await _player.startPlayer(
        fromURI: fromURI,
        fromDataBuffer: fromDataBuffer,
        codec: codec,
        whenFinished: () {
          _onPlayerStop = null;
          if (whenFinished != null) whenFinished();
        });
  }

  Future<void> stopPlayer() async {
    _onPlayerStop = null;
    await _player.stopPlayer();
  }

  Future<void> attachTo(AudioStatefulWidget widget) async {
    attachedTo.add(widget);
    if (!_sessionOpened && attachedTo.length == 1) await openSession();
  }

  Future<void> detachFrom(AudioStatefulWidget widget) async {
    if (attachedTo.remove(widget) &&
        attachedTo.isEmpty &&
        _sessionOpened &&
        !keepSessionOpened) {
      await closeSession();
    }
  }

  void _refreshAttachedWidgets() {
    for (AudioStatefulWidget widget in attachedTo) {
      if (widget.refresh != null) widget.refresh!();
    }
  }
}
