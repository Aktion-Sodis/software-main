import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_app/backend/storage/image_synch.dart';
import 'package:mobile_app/frontend/components/loadingsign.dart';

class ImageWidget extends StatefulWidget {
  final SyncedFile? imageFile;
  final BoxConstraints? boxConstraints;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  const ImageWidget(
      {required this.imageFile,
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

  @override
  void initState() {
    widget.imageFile?.file().then((value){
      if(mounted){
        setState(() {
          imageFile = value;
          loading = false;
        });
      }else{
        imageFile = value;
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
