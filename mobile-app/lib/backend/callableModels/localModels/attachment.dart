import 'dart:io';

abstract class Attachment {
  final String uri;

  Attachment(this.uri);

  File toFile() {
    return File.fromUri(Uri.parse(uri));
  }
}
