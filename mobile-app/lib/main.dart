import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/backend/Blocs/auth/auth_repository.dart';
import 'package:mobile_app/backend/Blocs/request_permissions/request_permissions_cubit.dart';
import 'package:mobile_app/backend/Blocs/session/session_cubit.dart';
import 'package:mobile_app/backend/Blocs/user/user_bloc.dart';
import 'package:mobile_app/backend/repositories/SettingsRepository.dart';
import 'package:mobile_app/backend/repositories/UserRepository.dart';
import 'package:mobile_app/frontend/components/hive_db_initializer.dart';
import 'package:mobile_app/frontend/dependentsizes.dart';
import 'package:mobile_app/frontend/pages/permissions_checker.dart';
import 'package:mobile_app/frontend/pages/survey.dart';
import 'package:mobile_app/frontend/theme.dart';

import 'package:mobile_app/services/amplify.dart';
import 'package:mobile_app/app_navigator.dart';
import 'package:mobile_app/services/hive_db_helper.dart';
import 'package:mobile_app/services/photo_capturing.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveDBHelper.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  ///Theme data returned after initalization
  ThemeData? themeData;

  //async initStateMethod handling the futures
  initStateAsync() async {
    await AmplifyIntegration.initialize();

    // todo: set _isAmplifyConfigured Flag for showing loading view?

    ///todo: dummy data, replace with db-version
    getThemeData().then((data) => setState(() {
          themeData = data;
        }));
  }

  @override
  void initState() {
    super.initState();
    initStateAsync();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: themeData ?? ThemeData.light(),
        home: themeData == null
            ? const Center(child: CircularProgressIndicator())
            : HiveDBInitializer(
                child: MultiRepositoryProvider(
                providers: [
                  RepositoryProvider(create: (context) => AuthRepository()),
                  RepositoryProvider(create: (context) => UserRepository()),
                  RepositoryProvider(create: (context) => SettingsRepository())
                ],
                child: MultiBlocProvider(
                  providers: [
                    BlocProvider<SessionCubit>(
                        create: (context) => SessionCubit(
                              authRepo: context.read<AuthRepository>(),
                              userRepo: context.read<UserRepository>(),
                            )),
                    BlocProvider<RequestPermissionsCubit>(
                        create: (context) => RequestPermissionsCubit.instance),
                  ],
                  child: PermissionsChecker(child: const AppNavigator()),
                ),
              )));
  }
}
