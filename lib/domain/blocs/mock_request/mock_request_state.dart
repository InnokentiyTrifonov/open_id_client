part of 'mock_request_bloc.dart';

sealed class MockRequestState extends Equatable {
  const MockRequestState();

  @override
  List<Object> get props => [];
}

final class MockRequestInitial extends MockRequestState {}

final class RequestSuccess extends MockRequestState {
  final String email;
  final String familyName;
  final String name;

  const RequestSuccess({required this.email, required this.familyName, required this.name});
}

final class RequestError extends MockRequestState {
  final String message;

  const RequestError({required this.message});
}
