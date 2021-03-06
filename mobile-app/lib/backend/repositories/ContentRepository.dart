import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:mobile_app/backend/callableModels/Content.dart';
import 'package:mobile_app/backend/repositories/InterventionRepository.dart';
import 'package:mobile_app/backend/storage/dataStorePaths.dart';
import 'package:mobile_app/backend/storage/image_synch.dart';
import 'package:mobile_app/models/ModelProvider.dart' as amp;

class ContentRepository {
  static Future<List<amp.InterventionContentRelation>>
      getAllRelationsWithPopulatedContentsAndInterventions() async {
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
    amp.InterventionContentRelation toReturn = relation.copyWith(
        content: await _populate(relation.content),
        intervention:
            await InterventionRepository.populate(relation.intervention));
    return toReturn;
  }

  static Future<amp.Content> _populate(amp.Content content) async {
    amp.Content toReturn = content.copyWith(
        tags: await contentContentTagRelationsByContentID(content.id),
        interventions: []);
    return toReturn;
  }

  static Future<List<amp.ContentContentTagRelation>>
      contentContentTagRelationsByContentID(String ID) async {
    List<amp.ContentContentTagRelation> toReturn =
        await Amplify.DataStore.query(amp.ContentContentTagRelation.classType,
            where: amp.ContentContentTagRelation.CONTENT.eq(ID));
    return toReturn;
  }

  static SyncedFile getContentPDFFile(Content content) {
    String path = dataStorePath(DataStorePaths.docPdfPath, [content.id!]);
    print("synced pdf file called for path: $path");
    return SyncedFile(path);
  }

  static SyncedFile getContentPic(Content content) {
    String path = dataStorePath(DataStorePaths.docPicPath, [content.id!]);
    return SyncedFile(path);
  }
}
