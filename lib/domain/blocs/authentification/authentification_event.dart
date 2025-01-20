part of 'authentification_bloc.dart';

sealed class AuthentificationEvent extends Equatable {
  const AuthentificationEvent();

  @override
  List<Object> get props => [];
}

final class SignIn extends AuthentificationEvent {}

final class SignOut extends AuthentificationEvent {}

final class CheckAuthentificationStatus extends AuthentificationEvent {}
