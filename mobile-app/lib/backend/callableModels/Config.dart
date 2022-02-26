import 'package:mobile_app/backend/callableModels/ColorTheme.dart';
import 'package:mobile_app/backend/callableModels/StoragePaths.dart';
import 'package:mobile_app/models/ModelProvider.dart' as amp;

class Config {
  String? id;
  late String name;
  ColorTheme? colorTheme;
  late StoragePaths storagePaths;
  int? schemeVersion;
  DateTime? createdAt;
  DateTime? updatedAt;

  Config(
      {this.id,
      required this.name,
      this.colorTheme,
      required this.storagePaths,
      this.schemeVersion,
      this.createdAt,
      this.updatedAt});

  Config.fromAmplifyModel(amp.Config config) {
    id = config.id;
    name = config.name;
    colorTheme = config.colorTheme == null
        ? null
        : ColorTheme.fromAmplifyModel(config.colorTheme!);
    storagePaths = StoragePaths.fromAmplifyModel(config.storagePaths);
    schemeVersion = config.schemeVersion;
    createdAt = config.createdAt?.getDateTimeInUtc();
    updatedAt = config.updatedAt?.getDateTimeInUtc();
  }

  amp.Config toAmplifyModel() {
    return (amp.Config(
        name: name,
        colorTheme: colorTheme?.toAmplifyModel(),
        id: id,
        storagePaths: storagePaths.toAmplifyModel(),
        schemeVersion: schemeVersion));
  }
}
