import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:user_repository/models/models.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const AuthenticationState.unknown()) {
    on<AuthenticationStatusChanged>(_onAuthenticationStausChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
  }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  FutureOr<void> _onAuthenticationStausChanged(AuthenticationStatusChanged event, Emitter<AuthenticationState> emit) {}

  FutureOr<void> _onAuthenticationLogoutRequested(AuthenticationLogoutRequested event, Emitter<AuthenticationState> emit) {}
}
