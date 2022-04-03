import 'package:hive/hive.dart';
import 'package:mobile_app/frontend/strings.dart';
import 'package:mobile_app/services/hive_db_helper.dart';

class SettingsRepository {
  static final SettingsRepository instance = SettingsRepository();

  Box get _table => HiveDBHelper.instance.getBox("settings");

  String? get locale => _table.get("locale");
  set locale(String? value) => _table.put("locale", value);
}
