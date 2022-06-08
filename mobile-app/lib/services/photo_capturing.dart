import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

abstract class CameraFunctionality {
  static Future<XFile?> takePicture({required BuildContext context}) async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? picture = await imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 80, maxWidth: 1080);
    return picture;
  }
}
