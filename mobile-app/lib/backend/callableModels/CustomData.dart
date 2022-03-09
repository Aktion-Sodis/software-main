import 'package:mobile_app/backend/callableModels/AppliedCustomData.dart';
import 'package:mobile_app/backend/callableModels/MultiLanguageText.dart';
import 'package:mobile_app/models/ModelProvider.dart' as amp;

class CustomData {
  String? id;
  late MultiLanguageText name_ml;
  late CustomDataType type;

  String get name => name_ml.text;

  set name(String name) => name_ml.text = name;

  CustomData({required this.id, required this.name_ml, required this.type});

  CustomData.fromAmplifyModel(amp.CustomData customData) {
    id = customData.id;
    name_ml = MultiLanguageText.fromAmplifyModel(customData.name);
    type = customDataTypeByAmplifyType(customData.type);
  }

  amp.CustomData toAmplifyModel() {
    return (amp.CustomData(
        name: name_ml.toAmplifyModel(),
        type: ampDataTypeByCustomDataType(type),
        id: id));
  }
}
