import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/amplifyconfiguration.dart';
import 'package:mobile_app/models/ModelProvider.dart';

///possess global access to the amplify plugin Instances

class AmplifyIntegration {
  ///database (automatically synced with cloud database)
  static final AmplifyDataStore _amplifyDataStore =
      AmplifyDataStore(modelProvider: ModelProvider.instance);

  ///api of cloud database (responsible for automated syncing)
  static final AmplifyAPI _amplifyAPI = AmplifyAPI();

  ///auth for api and storage
  static final AmplifyAuthCognito _amplifyAuthCognito = AmplifyAuthCognito();

  ///prior to any actions regarding amplify in app, this method has to be awaited once
  /// -> integrated as first step in app start
  static Future<bool> initialize() async {
    await Amplify.addPlugins(
        [_amplifyDataStore, _amplifyAPI, _amplifyAuthCognito]);
    await Amplify.configure(amplifyconfig);
    Amplify.DataStore.streamController.stream.asBroadcastStream().listen((t) {
      print("amplify data store event:");
      print((t as DataStoreHubEvent).eventName);
      print((t as DataStoreHubEvent).payload.toString());
    });
    //Amplify.DataStore.clear();
    Amplify.DataStore.start();
    print("amplify successfully initialized");
    return true;
  }
}
