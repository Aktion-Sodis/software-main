import 'dart:io';

abstract class Attachment {
  final String uri;
  final bool isPic;
  int? number;

  Attachment(this.uri, this.isPic);

  File toFile() {
    return File.fromUri(Uri.parse(uri));
  }
}
