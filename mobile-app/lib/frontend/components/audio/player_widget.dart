import 'package:flutter/material.dart';
import 'package:mobile_app/frontend/components/audio/audio_stateful_widget.dart';
import 'package:mobile_app/services/audio.dart';

/// Widget for playing some audio data
///
/// Try to use just one instance of `Audio` for all active AudioStatefulWidgets
/// in order to keep device resources free. Remember that an audio session will
/// usually be closed after destroying all attached widgets like that.
///
/// You may need take advantage of setting `audio.keepSessionOpened = true;` in
/// order to keep session opened, even if all attached widgets are destroyed.
class PlayerWidget extends AudioStatefulWidget {
  PlayerWidget(
      {Key? key,
      Audio? audio,
      required this.audioURL,
      required this.restingViewBuilder,
      required this.loadingViewBuilder,
      required this.recordingViewBuilder})
      : super(key: key, audio: audio);

  final String audioURL;
  final Widget Function(Function()? startPlaying) restingViewBuilder;
  final Widget Function() loadingViewBuilder;
  final Widget Function(Function() stopPlaying) recordingViewBuilder;

  @override
  State<PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends AudioStatefulWidgetState<PlayerWidget> {
  bool _playing = false;

  void _startPlaying() {
    if (mounted) {
      setState(() {
        _playing = true;
      });
    }

    widget.audio.startPlayer(
        fromURI: widget.audioURL,
        whenFinished: () {
          // Refresh UI
          if (mounted) {
            setState(() {
              _playing = false;
            });
          }
        });
  }

  void _stopPlaying() {
    if (mounted) {
      setState(() {
        _playing = false;
      });
    }

    widget.audio.stopPlayer();
  }

  @override
  Widget build(BuildContext context) {
    if (_playing) {
      return widget.recordingViewBuilder(_stopPlaying);
    } else {
      if (widget.audio.sessionOpened) {
        return widget.restingViewBuilder(_startPlaying);
      } else {
        return widget.loadingViewBuilder();
      }
    }
  }
}
