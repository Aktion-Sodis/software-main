import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/backend/Blocs/auth/auth_cubit.dart';
import 'package:mobile_app/backend/Blocs/auth/auth_repository.dart';
import 'package:mobile_app/backend/Blocs/session/session_cubit.dart';
import 'package:mobile_app/backend/Blocs/session/session_state.dart';
import 'package:mobile_app/backend/Blocs/user/user_bloc.dart';
import 'package:mobile_app/backend/Blocs/user/user_state.dart';
import 'package:mobile_app/backend/repositories/UserRepository.dart';
import 'package:mobile_app/frontend/pages/loading_view.dart';
import 'package:mobile_app/frontend/pages/login_view.dart';
import 'package:mobile_app/frontend/session_view.dart';

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
                      authRepo: context.read<AuthRepository>(),
                      userID: state.userID,
                      userRepository: context.read<UserRepository>()),
                  child: BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                    return Navigator(
                      pages: [
                        if (state.user == null)
                          //todo: user initialization page
                          MaterialPage(child: Container()),
                        if (state.user != null)

                          ///hier beginnt der beef/App-Inhalt
                          MaterialPage(child: Container())
                      ],
                    );
                  })),
            )
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}
