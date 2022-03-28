import 'package:mobile_app/backend/callableModels/I18nString.dart';
import 'package:mobile_app/models/ModelProvider.dart' as amp;

class AppliedCustomData {
  late String customDataID;
  late CustomDataType type;
  late I18nString name_ml;
  int? intValue;
  String? stringValue;
  String get name => name_ml.text;

  set name(String name) => name_ml.text = name;

  AppliedCustomData(
      {required this.customDataID,
      required this.type,
      required this.name_ml,
      this.intValue,
      this.stringValue});

  AppliedCustomData.fromAmplifyModel(amp.AppliedCustomData appliedCustomData) {
    customDataID = appliedCustomData.customDataID;
    type = customDataTypeByAmplifyType(appliedCustomData.type);
    name_ml = I18nString.fromAmplifyModel(appliedCustomData.name);
    intValue = appliedCustomData.intValue;
    stringValue = appliedCustomData.stringValue;
  }

  amp.AppliedCustomData toAmplifyModel() {
    return (amp.AppliedCustomData(
        customDataID: customDataID,
        type: ampDataTypeByCustomDataType(type),
        name: name_ml.toAmplifyModel(),
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
