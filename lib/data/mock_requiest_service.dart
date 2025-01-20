import 'package:open_id/core/network_client/network_client.dart';
import 'package:open_id/domain/interfaces/mock_request_interface.dart';
import 'package:open_id/domain/models/user_info.dart';

class MockRequestService implements MockRequestInterface {
  final NetworkClient _client;

  MockRequestService({required NetworkClient client}) : _client = client;

  @override
  Future<UserInfo> makeMockRequest({required Map<String, dynamic>? queryParameters}) async {
    try {
      final result = await _client.get(endpoint: '/connect/userinfo', queryParameters: queryParameters);
      if (result.statusCode != 200) ErrorUserInfo(message: result.statusMessage ?? '');
      return SuccessUserInfo(
        name: result.data['name'],
        familyName: result.data['family_name'],
        email: result.data['email'],
      );
    } catch (e) {
      rethrow;
    }
  }
}
