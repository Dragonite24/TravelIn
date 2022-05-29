import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_in/blocs/auth/auth_event.dart';
import 'package:travel_in/blocs/auth/auth_state.dart';
import 'package:travel_in/models/data_model.dart';
import 'package:travel_in/repositories/api_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // AuthBloc({required this.authRepository}) : assert(authRepository != null);

  AuthBloc({@required this.authRepository})
      : assert(authRepository != null),
        super(AuthInit()) {
    on<AuthCheck>(_onAuthCheck);
    on<LoginProcess>(_onAuthLoginProcess);
    on<GetDataWithToken>(_onGetData);
    // on<AuthCheck>((event, emit) {});
  }

  // AuthState get initialState => AuthInit();

  final AuthRepository authRepository;

  void _onAuthCheck(AuthEvent event, Emitter<AuthState> emit) async {
    emit(AuthData(email: 'user.email', name: ''));
    if (event is AuthCheck) {
      emit(AuthLoading());

      final hasToken = await authRepository.hasToken();
      if (hasToken != null) {
        emit(AuthHasToken(token: hasToken));
      } else {
        emit(AuthFailed());
      }
    }

    if (event is GetDataWithToken) {
      emit(AuthLoading());

      final user = await authRepository.getData(event.token);
      emit(AuthData(email: user.email, name: user.name));
    }
    if (event is LoggedOut) {
      final String token = await authRepository.hasToken();
      try {
        final Logout logout = await authRepository.userLogout();
        if (logout.message == "success") {
          await authRepository.unsetLocalToken();
          emit(AuthFailed());
        }
      } catch (e) {}
    }
  }

  void _onAuthLoginProcess(AuthEvent event, Emitter<AuthState> emit) async {
    if (event is LoginProcess) {
      emit(AuthLoading());
      emit(LoginSuccess());
      // try {
      //   final login =
      //   await authRepository.loginUser(event.email, event.password);
      //   if (login.message != "failed") {
      //     emit(LoginSuccess());
      //     await authRepository.setLocalToken(login.data.token);
      //     emit(AuthHasToken(token: login.data.token));
      //   }
      // } catch (e) {
      //   emit(LoginFailed("Неудалось войти"));
      // }
    }
  }

  void _onGetData(AuthEvent event, Emitter<AuthState> emit) async {
    if (event is GetDataWithToken) {
      emit(AuthLoading());

      final user = await authRepository.getData(event.token);
      emit(AuthData(email: user.email, name: user.name));
    }
  }
}