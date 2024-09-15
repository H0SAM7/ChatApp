part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final String email;

  LoginSuccess({required this.email});

}

final class LoginFuailer extends LoginState {
  final String errmessage;

  LoginFuailer({required this.errmessage});

}
