import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/backend/Blocs/task_form/task_form_cubit.dart';
import 'package:mobile_app/backend/callableModels/localModels/image_attachment.dart';
import 'package:mobile_app/frontend/pages/task_form/task_attachment_box.dart';

class ImageAttachmentBox extends StatelessWidget {
  const ImageAttachmentBox({Key? key, required this.attachment})
      : super(key: key);

  final ImageAttachment attachment;

  @override
  Widget build(BuildContext context) {
    return TaskAttachmentBox(
        removeAttachment: () => BlocProvider.of<TaskFormCubit>(context)
            .removeAttachment(attachment),
        child: Image.file(
          attachment.toFile(),
          fit: BoxFit.cover,
        ));
  }
}
