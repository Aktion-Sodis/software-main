class AppliedCustomData {
  String? customDataID;
  CustomDataType? type;
  String? name;
  int? intValue;
  String? stringValue;

  AppliedCustomData(
      {this.customDataID,
      this.type,
      this.name,
      this.intValue,
      this.stringValue});
}

enum CustomDataType { INT, STRING }
