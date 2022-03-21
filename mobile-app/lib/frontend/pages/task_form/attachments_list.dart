import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/backend/Blocs/task_form/task_form_cubit.dart';
import 'package:mobile_app/backend/callableModels/localModels/attachment.dart';
import 'package:mobile_app/backend/callableModels/localModels/audio_attachment.dart';
import 'package:mobile_app/frontend/dependentsizes.dart';
import 'package:mobile_app/frontend/pages/task_form/audio_attachment_box.dart';
import 'package:mobile_app/frontend/theme.dart';

class AttachmentsList extends StatelessWidget {
  const AttachmentsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskFormCubit, TaskFormState>(builder: (context, state) {
      return Container(
        height: 150,
        margin: EdgeInsets.only(bottom: defaultPadding(context)),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.symmetric(
                horizontal: BorderSide(
                    width: 1, color: ThemeColors.mobster.withOpacity(0.2)))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  EdgeInsets.only(left: 1.5 * defaultPadding(context), top: 10),
              child: const Text(
                "Attachments",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(
                    left: defaultPadding(context), top: 5, bottom: 10),
                scrollDirection: Axis.horizontal,
                itemCount: state.attachments.length,
                itemBuilder: (context, index) =>
                    _attachmentItemBuilder(context, index, state.attachments),
              ),
            )
          ],
        ),
      );
    });
  }

  Widget _attachmentItemBuilder(
      BuildContext context, int index, List<Attachment> attachments) {
    Widget? attachmentBox;
    Attachment attachment = attachments[index];
    if (attachment is AudioAttachment) {
      attachmentBox = AudioAttachmentBox(
        attachment: attachment,
      );
    }

    return Padding(
        padding: EdgeInsets.only(
          right: defaultPadding(context) / 2,
        ),
        child: attachmentBox ?? const SizedBox.shrink());
  }
}
