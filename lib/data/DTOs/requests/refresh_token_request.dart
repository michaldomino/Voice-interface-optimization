class RefreshTokenRequest {
  String refresh;

  RefreshTokenRequest(this.refresh);

  Map<String, dynamic> toJson() => {
    'refresh': refresh,
  };
}