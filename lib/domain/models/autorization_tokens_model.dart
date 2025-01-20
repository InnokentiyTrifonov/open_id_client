class AutorizationTokensModel {
  String? accessToken;
  String? idToken;
  String? refreshToken;
  DateTime? accessTokenExpirationDateTime;
  AutorizationTokensModel({
    this.accessToken,
    this.idToken,
    this.refreshToken,
    this.accessTokenExpirationDateTime,
  });
}
