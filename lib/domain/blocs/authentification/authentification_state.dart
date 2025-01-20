part of 'authentification_bloc.dart';

sealed class AuthentificationState extends Equatable {
  const AuthentificationState();

  @override
  List<Object> get props => [];
}

final class AuthentificationInitial extends AuthentificationState {}

final class Unauthorized extends AuthentificationState {}

final class Authorized extends AuthentificationState {}
