import 'dart:io';

import 'package:path/path.dart' as p;

/**
 * This function returns an unused path in the mobile storage. For example, if the parameter path is "../debug/example.txt"
 * and there is a file with that path, the function returns "../debug/example (1).txt". Otherwise, the function returns the value of `path`
 */
Future<String> getFreeFilepath(String path) async {
  String dir = p.dirname(path);
  String basename = p.basenameWithoutExtension(path);
  String ext = p.extension(path);

  for (int i = 0; true; i++) {
    String newPath = dir + "/" + basename;
    if (i > 0) newPath += " ($i)";
    newPath += ext;

    File file = File(newPath);
    bool fileExists = await file.exists();
    if (!fileExists) return Future.value(newPath);
  }
}
