class IsVerifiedResponse {
  final bool isVerified;

  IsVerifiedResponse(this.isVerified);

  factory IsVerifiedResponse.fromJsonMap(Map<String, dynamic> jsonMap) {
    return IsVerifiedResponse(
      jsonMap['is_verified'],
    );
  }
}
