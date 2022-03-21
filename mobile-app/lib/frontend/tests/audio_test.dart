import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:mobile_app/frontend/components/audio/player_widget.dart';
import 'package:mobile_app/frontend/components/audio/recorder_widget.dart';
import 'package:mobile_app/frontend/dependentsizes.dart';
import 'package:mobile_app/services/audio.dart';
import 'package:mobile_app/services/storage.dart';
import 'package:path_provider/path_provider.dart';

class AudioTest extends StatefulWidget {
  AudioTest({Key? key}) : super(key: key);

  @override
  State<AudioTest> createState() => _AudioTestState();
}

class _AudioTestState extends State<AudioTest> {
  final Audio audio = Audio();
  final Audio audio_for_widgets = Audio();
  String? _recordedURI;

  Future<void> _openSession() => audio.openSession();

  Future<void> _closeSession() => audio.closeSession();

  Future<void> _startRecording() async {
    Directory tempDir = await getTemporaryDirectory();
    String filepath = tempDir.path +
        "/test_audio_" +
        DateTime.now().microsecondsSinceEpoch.toString() +
        ".aac";
    String freeFilepath = await getFreeFilepath(filepath);

    audio.recorder.startRecorder(
      toFile: freeFilepath,
      codec: Codec.aacADTS,
    );
  }

  Future<void> _stopRecording() async {
    _recordedURI = await audio.recorder.stopRecorder();
    if (mounted) setState(() {});
  }

  void _startPlaying() {
    if (_recordedURI != null)
      audio.startPlayer(fromURI: _recordedURI);
    else
      print("Nothing has been recorded yet");
  }

  Future<void> _stopPlaying() => audio.stopPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test of flutter_sound"),
      ),
      body: ListView(
        padding: EdgeInsets.all(defaultPadding(context)),
        children: [
          ElevatedButton(
            onPressed: _openSession,
            child: const Text("Open session"),
          ),
          ElevatedButton(
            onPressed: _closeSession,
            child: const Text("Close session"),
          ),
          const Divider(),
          ElevatedButton(
            onPressed: _startRecording,
            child: const Text("Start recorder"),
          ),
          ElevatedButton(
            onPressed: _stopRecording,
            child: const Text("Stop recorder"),
          ),
          const Divider(),
          ElevatedButton(
            onPressed: _startPlaying,
            child: const Text("Start player"),
          ),
          ElevatedButton(
            onPressed: _stopPlaying,
            child: const Text("Stop player"),
          ),
          const Divider(),
          SizedBox(height: 20),
          Text("Tests of widgets with another instance of Audio()"),
          SizedBox(height: 10),
          RecorderWidget(
              audio: audio_for_widgets,
              loadingViewBuilder: () {
                return const ElevatedButton(
                    onPressed: null, child: Text("Start recording"));
              },
              restingViewBuilder: (startRecording) {
                return ElevatedButton(
                    onPressed: startRecording, child: Text("Start recording"));
              },
              recordingViewBuilder: (stopRecording) {
                return ElevatedButton(
                    onPressed: stopRecording, child: Text("Stop recording"));
              },
              onAudioRecorded: (url) {
                _recordedURI = url;

                if (mounted) setState(() {});
              }),
          _recordedURI == null
              ? const ElevatedButton(
                  onPressed: null, child: Text("Start playing"))
              : PlayerWidget(
                  audio: audio_for_widgets,
                  audioURL: _recordedURI!,
                  restingViewBuilder: (startPlaying) {
                    return ElevatedButton(
                        onPressed: startPlaying,
                        child: const Text("Start playing"));
                  },
                  loadingViewBuilder: () {
                    return Text("loading");
                  },
                  recordingViewBuilder: (stopPlaying) {
                    return ElevatedButton(
                        onPressed: stopPlaying,
                        child: const Text("Stop playing"));
                  })
        ],
      ),
    );
  }
}
