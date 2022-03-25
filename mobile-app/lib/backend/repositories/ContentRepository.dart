import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:mobile_app/models/ModelProvider.dart' as amp;

class ContentRepository {
  static Future<List<amp.InterventionContentRelation>>
      getAllRelationsWithPopulatedContents() async {
    List<amp.InterventionContentRelation> raw = await Amplify.DataStore.query(
        amp.InterventionContentRelation.classType);
    return _populateContentsInConnectionList(raw);
  }

  static Future<List<amp.InterventionContentRelation>>
      _populateContentsInConnectionList(
          List<amp.InterventionContentRelation> toPopulate) async {
    List<Future<amp.InterventionContentRelation>> toWait = List.generate(
        toPopulate.length,
        (index) =>
            _populateInterventionContentRelationContent(toPopulate[index]));
    return Future.wait(toWait);
  }

  static Future<amp.InterventionContentRelation>
      _populateInterventionContentRelationContent(
          amp.InterventionContentRelation relation) async {
    amp.InterventionContentRelation toReturn =
        relation.copyWith(content: await _populate(relation.content));
    return toReturn;
  }

  static Future<amp.Content> _populate(amp.Content content) async {
    amp.Content toReturn = content.copyWith(
        tags: await contentContentTagRelationsByContentID(content.id));
    return toReturn;
  }

  static Future<List<amp.ContentContentTagRelation>>
      contentContentTagRelationsByContentID(String ID) async {
    List<amp.ContentContentTagRelation> toReturn =
        await Amplify.DataStore.query(amp.ContentContentTagRelation.classType,
            where: amp.ContentContentTagRelation.CONTENT.eq(ID));
    return toReturn;
  }
}
