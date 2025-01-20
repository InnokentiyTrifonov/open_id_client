import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_id/domain/interfaces/mock_request_interface.dart';
import 'package:open_id/domain/models/user_info.dart';

part 'mock_request_event.dart';
part 'mock_request_state.dart';

class MockRequestBloc extends Bloc<MockRequestEvent, MockRequestState> {
  final MockRequestInterface mockRequestService;
  MockRequestBloc({required this.mockRequestService}) : super(MockRequestInitial()) {
    on<MakeRequest>((event, emit) async {
      final userInfo = await mockRequestService.makeMockRequest(queryParameters: null);
      if (userInfo == null) {
        emit(const RequestError(message: 'something went wrong'));
        return;
      }
      if (userInfo is ErrorUserInfo) {
        emit(RequestError(message: userInfo.message));
        return;
      }

      if (userInfo is SuccessUserInfo) {
        emit(RequestSuccess(email: userInfo.email, familyName: userInfo.familyName, name: userInfo.name));
        return;
      }
    });
  }
}
