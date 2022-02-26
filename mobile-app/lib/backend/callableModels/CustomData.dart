import 'package:mobile_app/backend/callableModels/AppliedCustomData.dart';
import 'package:mobile_app/models/ModelProvider.dart' as amp;

class CustomData {
  String? id;
  late String name;
  late CustomDataType type;

  CustomData({required this.id, required this.name, required this.type});

  CustomData.fromAmplifyModel(amp.CustomData customData) {
    id = customData.id;
    name = customData.name;
    type = customDataTypeByAmplifyType(customData.type);
  }

  amp.CustomData toAmplifyModel() {
    return (amp.CustomData(
        name: name, type: ampDataTypeByCustomDataType(type), id: id));
  }
}
