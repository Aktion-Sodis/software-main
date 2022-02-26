import 'package:mobile_app/models/ModelProvider.dart' as amp;

class AppliedCustomData {
  late String customDataID;
  late CustomDataType type;
  late String name;
  int? intValue;
  String? stringValue;

  AppliedCustomData(
      {required this.customDataID,
      required this.type,
      required this.name,
      this.intValue,
      this.stringValue});

  AppliedCustomData.fromAmplifyModel(amp.AppliedCustomData appliedCustomData) {
    customDataID = appliedCustomData.customDataID;
    type = customDataTypeByAmplifyType(appliedCustomData.type);
    name = appliedCustomData.name;
    intValue = appliedCustomData.intValue;
    stringValue = appliedCustomData.stringValue;
  }

  amp.AppliedCustomData toAmplifyModel() {
    return (amp.AppliedCustomData(
        customDataID: customDataID,
        type: ampDataTypeByCustomDataType(type),
        name: name,
        intValue: intValue,
        stringValue: stringValue));
  }
}

enum CustomDataType { INT, STRING }

CustomDataType customDataTypeByAmplifyType(amp.Type type) {
  switch (type) {
    case amp.Type.INT:
      return CustomDataType.INT;
      break;
    case amp.Type.STRING:
      return CustomDataType.STRING;
      break;
  }
}

amp.Type ampDataTypeByCustomDataType(CustomDataType customDataType) {
  switch (customDataType) {
    case CustomDataType.INT:
      return amp.Type.INT;
      break;
    case CustomDataType.STRING:
      return amp.Type.STRING;
      break;
  }
}
