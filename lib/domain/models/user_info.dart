abstract class UserInfo {}

class SuccessUserInfo extends UserInfo {
  final String name;
  final String familyName;
  final String email;

  SuccessUserInfo({required this.name, required this.familyName, required this.email});
}

class ErrorUserInfo extends UserInfo {
  final String message;

  ErrorUserInfo({required this.message});
}
