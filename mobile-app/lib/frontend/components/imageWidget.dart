import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_app/backend/storage/image_synch.dart';
import 'package:mobile_app/frontend/components/loadingsign.dart';
import 'package:mobile_app/frontend/dependentsizes.dart';

class ImageWidget extends StatefulWidget {
  final SyncedFile? imageFile;
  final BoxConstraints? boxConstraints;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  ImageWidget(
      {Key? key,
      required this.imageFile,
      this.boxConstraints,
      this.width,
      this.height,
      this.borderRadius})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ImageWidgetState();
  }
}

class ImageWidgetState extends State<ImageWidget> {
  bool loading = true;
  File? imageFile;
  FileImage? fileImage;

  @override
  void initState() {
    print("reinitializing image widget");
    widget.imageFile?.file().then((value) async {
      imageFile = value;
      if (imageFile != null) {
        fileImage = FileImage(imageFile!);
        await fileImage!.evict();
      }
      if (mounted) {
        setState(() {
          fileImage = fileImage;
          loading = false;
        });
      } else {
        fileImage = fileImage;
        loading = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        constraints: widget.boxConstraints,
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
            image: loading
                ? null
                : imageFile != null
                    ? DecorationImage(
                        image: fileImage!,
                        fit: (widget.width != null || widget.height != null)
                            ? BoxFit.fitWidth
                            : BoxFit.contain)
                    : null,
            color: Colors.grey,
            borderRadius: widget.borderRadius),
        child: loading ? Center(child: loadingSign(context)) : Container());
  }
}

class ImageFromSyncedFile extends StatefulWidget {
  final SyncedFile? syncedFile;

  const ImageFromSyncedFile({Key? key, this.syncedFile}) : super(key: key);

  @override
  State<ImageFromSyncedFile> createState() => _ImageFromSyncedFileState();
}

class _ImageFromSyncedFileState extends State<ImageFromSyncedFile> {
  bool loading = true;
  File? imageFile;
  FileImage? fileImage;

  @override
  void initState() {
    print("reinitializing image widget");
    widget.syncedFile?.file().then((value) async {
      imageFile = value;
      fileImage = FileImage(imageFile!);
      await fileImage!.evict();
      if (mounted) {
        setState(() {
          fileImage = fileImage;
          loading = false;
        });
      } else {
        fileImage = fileImage;
        loading = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return imageFile == null
        ? Container()
        : Container(
            constraints: BoxConstraints(maxHeight: height(context) * .25),
            child: Image.file(imageFile!));
  }
}
