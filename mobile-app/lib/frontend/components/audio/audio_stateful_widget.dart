import 'package:flutter/material.dart';
import 'package:mobile_app/services/audio.dart';

// ignore: must_be_immutable
abstract class AudioStatefulWidget extends StatefulWidget {
  AudioStatefulWidget({Key? key, Audio? audio}) : super(key: key) {
    this.audio = audio ?? Audio.instance;
  }

  late final Audio audio;
  Function()? refresh;
}

abstract class AudioStatefulWidgetState<T extends AudioStatefulWidget>
    extends State<T> {
  Future<void> initAudio() async {
    await widget.audio.attachTo(widget);
  }

  void deinitAudio() {
    widget.audio.detachFrom(widget);
  }

  @override
  void initState() {
    super.initState();
    widget.refresh = () {
      if (mounted) {
        setState(() {});
      }
    };
    initAudio();
  }

  @override
  void dispose() {
    super.dispose();
    deinitAudio();
  }
}
