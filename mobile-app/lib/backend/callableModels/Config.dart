import 'package:mobile_app/backend/callableModels/ColorTheme.dart';
import 'package:mobile_app/backend/callableModels/StoragePaths.dart';

class Config {
  String id;
  String? name;
  ColorTheme? colorTheme;
  StoragePaths? storagePaths;
  int? schemeVersion;
  DateTime? createdAt;
  DateTime? updatedAt;

  Config(
      {required this.id,
      this.name,
      this.colorTheme,
      this.storagePaths,
      this.schemeVersion,
      this.createdAt,
      this.updatedAt});
}
