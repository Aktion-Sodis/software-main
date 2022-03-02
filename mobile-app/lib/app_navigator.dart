import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/backend/Blocs/auth/auth_cubit.dart';
import 'package:mobile_app/backend/Blocs/session/session_cubit.dart';
import 'package:mobile_app/backend/Blocs/session/session_state.dart';
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
          if (state is Unauthenticated)
            MaterialPage(
              child: BlocProvider(
                create: (context) =>
                    AuthCubit(sessionCubit: context.read<SessionCubit>()),
                child: LoginView(),
              ),
            ),

          // Show session flow
          if (state is AuthenticatedAndUserCreated)
            MaterialPage(
                child: SessionView(
              username: '${state.user.firstName} ${state.user.lastName}',
            )),

          //todo: create user name and pic page when user not created
          if (state is AuthenticatedAndNoUserCreated)
            MaterialPage(child: Container()) //todo: implement
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}
