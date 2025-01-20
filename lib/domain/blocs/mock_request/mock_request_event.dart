part of 'mock_request_bloc.dart';

sealed class MockRequestEvent extends Equatable {
  const MockRequestEvent();

  @override
  List<Object> get props => [];
}

final class MakeRequest extends MockRequestEvent {}
