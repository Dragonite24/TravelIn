import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {}

class AuthCheck extends AuthEvent {}

class GetDataWithToken extends AuthEvent {
  final String token;

  GetDataWithToken(this.token);

  @override
  List<Object> get props => [token];
}

class LoggedOut extends AuthEvent {
  @override
  String toString() => 'LoggedOut';
}

class LoginProcess extends AuthEvent {
  final String email;
  final String password;

  LoginProcess({@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];
}