import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile_app/backend/Blocs/task_form/task_form_cubit.dart';
import 'package:mobile_app/backend/callableModels/localModels/audio_attachment.dart';
import 'package:mobile_app/frontend/components/audio/player_widget.dart';
import 'package:mobile_app/frontend/pages/task_form/task_attachment_box.dart';
import 'package:mobile_app/frontend/theme.dart';
import 'package:mobile_app/services/audio.dart';

class AudioAttachmentBox extends StatefulWidget {
  AudioAttachmentBox({
    Key? key,
    required this.attachment,
    Audio? audio,
  }) : super(key: key) {
    this.audio = audio ?? Audio.instance;
  }

  final AudioAttachment attachment;
  late final Audio audio;

  @override
  State<AudioAttachmentBox> createState() => _AudioAttachmentBoxState();
}

class _AudioAttachmentBoxState extends State<AudioAttachmentBox> {
  bool _isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return TaskAttachmentBox(
      removeAttachment: () => BlocProvider.of<TaskFormCubit>(context)
          .removeAttachment(widget.attachment),
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          color: _isPlaying ? ThemeColors.yellow : ThemeColors.green,
          child: Material(
            color: Colors.transparent,
            child: Center(
              child: PlayerWidget(
                audio: widget.audio,
                onStatusChange: (isPlaying) {
                  _isPlaying = isPlaying;
                  if (mounted) setState(() {});
                },
                loadingViewBuilder: () {
                  return IconButton(
                      onPressed: () {
                        // TODO: create a toast notifying that the audio has not been initialized yet
                      },
                      iconSize: 50,
                      splashRadius: 40,
                      icon: const Icon(MdiIcons.playCircleOutline));
                },
                audioURL: widget.attachment.uri,
                playingViewBuilder: (dynamic Function() stopPlaying) {
                  return IconButton(
                    onPressed: () {
                      stopPlaying();
                    },
                    iconSize: 50,
                    splashRadius: 40,
                    icon: const Icon(MdiIcons.stopCircleOutline),
                  );
                },
                restingViewBuilder: (dynamic Function() startPlaying) {
                  return IconButton(
                      onPressed: () {
                        startPlaying();
                      },
                      iconSize: 50,
                      splashRadius: 40,
                      icon: const Icon(MdiIcons.playCircleOutline));
                },
              ),
            ),
          )),
    );
  }
}
