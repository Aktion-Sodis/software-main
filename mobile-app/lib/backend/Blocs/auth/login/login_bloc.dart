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
        print("form is getting submitted");
        print("authRepo not null: ${authRepo != null}");
        final userId = await authRepo.login(
          email: state.isPhoneNumber ? null : state.emailOrPhoneNumber,
          phoneNumber: state.isPhoneNumber ? state.emailOrPhoneNumber : null,
          password: state.password,
        );
        emit(state.copyWith(formStatus: SubmissionSuccess()));
        print("now launching session");

        if (userId == "CONFIRM_SIGN_IN_WITH_NEW_PASSWORD") {
          //todo: ask for password update
        }

        authCubit.launchSession(AuthCredentials(
          userName: state.emailOrPhoneNumber,
          email: state.isPhoneNumber ? null : state.emailOrPhoneNumber,
          phoneNumber: state.isPhoneNumber ? state.emailOrPhoneNumber : null,
          password: state.password,
          userId: userId,
        ));
        print("session launched");
      } catch (e) {
        print("error in authentication");
        print(e.toString());

        //todo: hier error management einbauen
        emit(state.copyWith(
            formStatus: SubmissionFailed(e as Exception, e.toString())));
      }
    }
  }
}
