import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveDBHelper {
  static final HiveDBHelper instance = HiveDBHelper();

  final Map<String, Box> _openedBoxes = {};

  Future<void> init() async {
    String appDir = (await getApplicationDocumentsDirectory()).path;
    Hive.init(appDir);

    await openBox("settings");
  }

  Box getBox(String name) {
    return _openedBoxes[name]!;
  }

  Future<Box> openBox(String name) async {
    Box result = await Hive.openBox(name);

    if (!_openedBoxes.containsKey(name)) {
      _openedBoxes[name] = result;
    }

    return Future.value(result);
  }

  Future<void> close() async {
    var copy = _openedBoxes.keys.toSet();
    for (String key in copy) {
      await _openedBoxes[key]!.close();
      _openedBoxes.remove(key);
    }
  }
}
