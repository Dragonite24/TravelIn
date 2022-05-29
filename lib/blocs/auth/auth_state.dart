import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInit extends AuthState {}

class AuthLoading extends AuthState {}

class AuthHasToken extends AuthState {
  final String token;
  AuthHasToken({@required this.token});

  @override
  List<Object> get props => [token];
}

class AuthFailed extends AuthState {}

class AuthData extends AuthState {
  final String name;
  final String email;

  AuthData({@required this.email, @required this.name});
  @override
  List<Object> get props => [name, email];
}

class LoginInit extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginFailed extends AuthState {
  final String error;
  LoginFailed(this.error);

  @override
  List<Object> get props => [error];
}