import 'package:mobile_app/models/ModelProvider.dart' as amp;

class StoragePaths {
  String? ownerPic;
  String? ownerIcon;

  StoragePaths({this.ownerIcon, this.ownerPic});

  StoragePaths.fromAmplifyModel(amp.StoragePaths storagePaths) {
    ownerPic = storagePaths.ownerPic;
    ownerIcon = storagePaths.ownerIcon;
  }

  amp.StoragePaths toAmplifyModel() {
    return (amp.StoragePaths(ownerIcon: ownerIcon, ownerPic: ownerPic));
  }
}
