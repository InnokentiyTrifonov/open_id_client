import 'package:open_id/domain/models/user_info.dart';

abstract interface class MockRequestInterface {
  Future<UserInfo?> makeMockRequest({required Map<String, dynamic>? queryParameters});
}
