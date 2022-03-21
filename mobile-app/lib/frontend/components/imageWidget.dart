import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_app/frontend/components/loadingsign.dart';

class ImageWidget extends StatefulWidget {
  final String path;
  final File? imageFile;
  final BoxConstraints? boxConstraints;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  ImageWidget(
      {required this.path,
      this.imageFile,
      this.boxConstraints,
      this.width,
      this.height,
      this.borderRadius});

  @override
  State<StatefulWidget> createState() {
    return ImageWidgetState();
  }
}

class ImageWidgetState extends State<ImageWidget> {
  bool loading = true;
  File? imageFile;

  Future<File?> fileFromPath(String path) async {
    //todo: implement
    return null;
  }

  @override
  void initState() {
    if (widget.imageFile != null) {
      imageFile = widget.imageFile;
      loading = false;
    }
    super.initState();
    if (widget.imageFile == null) {
      fileFromPath(widget.path).then((value) {
        setState(() {
          imageFile = value;
          loading = false;
        });
      });
    }
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
                        image: FileImage(imageFile!),
                        fit: (widget.width != null || widget.height != null)
                            ? BoxFit.fitWidth
                            : BoxFit.contain)
                    : null,
            color: Colors.grey,
            borderRadius: widget.borderRadius),
        child: loading ? Center(child: loadingSign(context)) : Container());
  }
}
