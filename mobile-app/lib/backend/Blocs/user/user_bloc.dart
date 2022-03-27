import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/backend/Blocs/auth/auth_cubit.dart';
import 'package:mobile_app/backend/Blocs/auth/auth_repository.dart';
import 'package:mobile_app/backend/Blocs/user/user_events.dart';
import 'package:mobile_app/backend/Blocs/user/user_state.dart';
import 'package:mobile_app/backend/callableModels/CallableModels.dart';
import 'package:mobile_app/backend/repositories/UserRepository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthRepository authRepo;
  final UserRepository userRepository;
  final String userID;

  UserBloc(
      {required this.authRepo,
      required this.userID,
      required this.userRepository,
      UserState? userState})
      : super(userState ?? UserState()) {
    on<UserEvent>(_mapEventToState);
  }

  void _mapEventToState(UserEvent event, Emitter<UserState> emit) async {
    if (event is CreateUserEvent) {
      //Create user if it does not exist with current auth ID
      User toCreate = event.user;
      toCreate.id = userID;
      emit(state.copyWith(user: toCreate));
      userRepository.createUser(event.user);
    } else if (event is UpdateUserEvent) {
      ///updaet user and save to db
      emit(state.copyWith(user: event.user));
      userRepository.updateUser(event.user);
      // Form submitted
    } else if (event is InitializeUserEvent) {
      ///initialize user without saving to db anything
      emit(state.copyWith(user: event.user, userPic: event.userPic));
    } else if (event is UpdatePicUserEvent) {
      emit(state.copyWith(userPic: event.userPic));
      userRepository.updateUserPic(event.userPic, userID);
    } else if (event is LogOutUserEvent) {
      emit(UserState());
    }
  }
}
