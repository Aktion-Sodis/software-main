import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/backend/Blocs/auth/auth_cubit.dart';
import 'package:mobile_app/backend/Blocs/auth/auth_repository.dart';
import 'package:mobile_app/backend/Blocs/content/content_bloc.dart';
import 'package:mobile_app/backend/Blocs/in_app/in_app_bloc.dart';
import 'package:mobile_app/backend/Blocs/in_app/in_app_events.dart';
import 'package:mobile_app/backend/Blocs/in_app/in_app_state.dart';
import 'package:mobile_app/backend/Blocs/organization_view/organization_view_state.dart';
import 'package:mobile_app/backend/Blocs/session/session_cubit.dart';
import 'package:mobile_app/backend/Blocs/session/session_state.dart';
import 'package:mobile_app/backend/Blocs/task/task_bloc.dart';
import 'package:mobile_app/backend/Blocs/user/user_bloc.dart';
import 'package:mobile_app/backend/Blocs/user/user_state.dart';
import 'package:mobile_app/backend/repositories/ContentRepository.dart';
import 'package:mobile_app/backend/repositories/SurveyRepository.dart';
import 'package:mobile_app/backend/repositories/TaskRepository.dart';
import 'package:mobile_app/backend/repositories/UserRepository.dart';
import 'package:mobile_app/frontend/pages/loading_view.dart';
import 'package:mobile_app/frontend/pages/login_view.dart';
import 'package:mobile_app/frontend/pages/main_menu.dart';
import 'package:mobile_app/frontend/pages/update_password_view.dart';
import 'package:mobile_app/frontend/pages/user_data_view.dart';
import 'package:mobile_app/frontend/session_view.dart';

import 'backend/Blocs/auth/auth_repository.dart';
import 'backend/callableModels/Survey.dart';
import 'frontend/pages/survey.dart';
import 'backend/Blocs/organization_view/organization_view_bloc.dart';
import 'backend/repositories/AppliedInterventionRepository.dart';
import 'backend/repositories/EntityRepository.dart';
import 'backend/repositories/SurveyRepository.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(builder: (context, state) {
      return Navigator(
        pages: [
          // Show loading screen
          if (state is UnknownSessionState)
            const MaterialPage(child: LoadingView()),

          // Show auth flow
          if (state is RequiresAuthentificationSessionState)
            MaterialPage(
              child: BlocProvider(
                create: (context) =>
                    AuthCubit(sessionCubit: context.read<SessionCubit>()),
                child: LoginView(),
              ),
            ),

          // Show further app content
          //todo: insert user Bloc here
          if (state is FullyAuthenticatedSessionState)
            MaterialPage(
              child: BlocProvider<UserBloc>(
                  create: (context) => UserBloc(
                      userState: UserState(user: state.user),
                      authRepo: context.read<AuthRepository>(),
                      userID: state.userID,
                      userRepository: context.read<UserRepository>()),
                  child: BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                    return Navigator(
                      pages: [
                        if (state.user == null)
                          //todo: user initialization page
                          MaterialPage(
                              child: UserDataView(
                                  userBloc: context.read<UserBloc>())),
                        if (state.user != null)
                          MaterialPage(
                              child: MultiRepositoryProvider(
                                  providers: [
                                RepositoryProvider<ContentRepository>(
                                    create: (context) => ContentRepository()),
                                RepositoryProvider<EntityRepository>(
                                    create: (context) => EntityRepository()),
                                RepositoryProvider<SurveyRepository>(
                                    create: (context) => SurveyRepository()),
                                RepositoryProvider<
                                        AppliedInterventionRepository>(
                                    create: (context) =>
                                        AppliedInterventionRepository())
                              ],
                                  child: Builder(
                                      builder: (context) => MultiBlocProvider(
                                              providers: [
                                                BlocProvider<InAppBloc>(
                                                    create: (context) =>
                                                        InAppBloc()),
                                                BlocProvider<ContentBloc>(
                                                    create: (context) =>
                                                        ContentBloc(context.read<
                                                            ContentRepository>())),
                                                BlocProvider(
                                                    create: (context) =>
                                                        TaskBloc(TaskRepository(
                                                            state.user!))),
                                                BlocProvider(create: (context) => OrganizationViewBloc(
                                                    context.read<
                                                        EntityRepository>(),
                                                    context.read<
                                                        AppliedInterventionRepository>(),
                                                    context.read<
                                                        InAppBloc>()
                                                )),
                                              ],
                                              child: BlocBuilder<OrganizationViewBloc, OrganizationViewState>(
                                                builder: (context, orgState) => BlocBuilder<InAppBloc,
                                                        InAppState>(
                                                    builder:
                                                        (context, inAppState) {

                                                      if (inAppState
                                                      is MainInAppState) {
                                                    return const MainMenu();
                                                  } else if (inAppState
                                                      is UserPageInAppState) {
                                                    return UserDataView(
                                                        userBloc: context
                                                            .read<UserBloc>(),
                                                        inApp: true);
                                                  } else if (inAppState
                                                      is SurveyInAppState) {
                                                    return SurveyWidget(
                                                        survey:
                                                            inAppState.survey);
                                                  } else {
                                                    return Scaffold(
                                                        body: Container());
                                                  }
                                                }),
                                              )))))

                        ///hier beginnt der beef/App-Inhalt
                      ],
                      onPopPage: (route, result) => route.didPop(result),
                    );
                  })),
            ),
          if (state is RequiresPasswordChangeSessionState)
            MaterialPage(
                child: UpdatePasswordView(
              authCredentials: state.authCredentials,
              sessionCubit: context.read<SessionCubit>(),
            ))
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}
