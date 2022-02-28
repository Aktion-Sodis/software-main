import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/backend/Blocs/auth/auth_credentials.dart';
import 'package:mobile_app/backend/Blocs/auth/auth_cubit.dart';
import 'package:mobile_app/backend/Blocs/auth/auth_repository.dart';
import 'package:mobile_app/backend/Blocs/auth/form_submission_status.dart';
import 'package:mobile_app/backend/Blocs/auth/login/login_event.dart';
import 'package:mobile_app/backend/Blocs/auth/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  LoginBloc({required this.authRepo, required this.authCubit})
      : super(LoginState()) {
    on<LoginEvent>(_mapEventToState);
  }

  void _mapEventToState(LoginEvent event, Emitter<LoginState> emit) async {
    // Username updated
    if (event is LoginEmailOrPhoneNumberChanged) {
      emit(state.copyWith(emailOrPhoneNumber: event.emailOrPhoneNumber));

      // Password updated
    } else if (event is LoginPasswordChanged) {
      emit(state.copyWith(password: event.password));

      // Form submitted
    } else if (event is LoginSubmitted) {
      emit(state.copyWith(formStatus: FormSubmitting()));

      try {
        final userId = await authRepo.login(
          username: state.emailOrPhoneNumber,
          password: state.password,
        );
        emit(state.copyWith(formStatus: SubmissionSuccess()));

        authCubit.launchSession(AuthCredentials(
          userName: state.emailOrPhoneNumber,
          password: state.password,
          userId: userId,
        ));
      } catch (e) {
        //todo: hier error management einbauen
        emit(state.copyWith(
            formStatus: SubmissionFailed(e as Exception, e.toString())));
      }
    }
  }
}
