import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:mobile_app/frontend/components/audio/audio_stateful_widget.dart';
import 'package:mobile_app/services/audio.dart';
import 'package:mobile_app/services/storage.dart';
import 'package:path_provider/path_provider.dart';

/// Widget for recording audio data
///
/// Try to use just one instance of `Audio` for all active AudioStatefulWidgets
/// in order to keep device resources free. Remember that an audio session will
/// usually be closed after destroying all attached widgets like that.
///
/// You may need take advantage of setting `audio.keepSessionOpened = true;` in
/// order to keep session opened, even if all attached widgets are destroyed.
class RecorderWidget extends AudioStatefulWidget {
  RecorderWidget(
      {Key? key,
      required this.restingViewBuilder,
      required this.recordingViewBuilder,
      Audio? audio,
      required this.onAudioRecorded,
      required this.loadingViewBuilder})
      : super(key: key, audio: audio);

  final Function(String audioURL) onAudioRecorded;
  final Widget Function(Function()? startRecording) restingViewBuilder;
  final Widget Function() loadingViewBuilder;
  final Widget Function(Function() stopRecording) recordingViewBuilder;

  @override
  State<RecorderWidget> createState() => _RecorderWidgetState();
}

class _RecorderWidgetState extends AudioStatefulWidgetState<RecorderWidget> {
  bool _recording = false;

  Future<void> _startRecording() async {
    if (_recording || widget.audio.recorder.isRecording) return;

    if (mounted) {
      setState(() {
        _recording = true;
      });
    }

    Directory tempDir = await getTemporaryDirectory();
    String filepath = tempDir.path +
        "/recorded_audio_" +
        DateTime.now().microsecondsSinceEpoch.toString() +
        ".aac";
    String freeFilepath = await getFreeFilepath(filepath);

    widget.audio.recorder.startRecorder(
      toFile: freeFilepath,
      codec: Codec.aacADTS,
    );
  }

  Future<void> _stopRecording() async {
    if (!_recording) return;

    if (mounted) {
      setState(() {
        _recording = false;
      });
    }

    String? recordedURL = await widget.audio.recorder.stopRecorder();

    if (recordedURL != null) widget.onAudioRecorded(recordedURL);
  }

  @override
  Widget build(BuildContext context) {
    if (_recording) {
      return widget.recordingViewBuilder(_stopRecording);
    } else {
      if (widget.audio.sessionOpened) {
        return widget.restingViewBuilder(_startRecording);
      } else {
        return widget.loadingViewBuilder();
      }
    }
  }
}
