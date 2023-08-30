/// access_token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjIsImVtYWlsIjoidGVzdHVzZXIxQHRlc3QuY29tIiwiaWF0IjoxNjkzMzMwMTkwLCJleHAiOjE2OTQ2MjYxOTB9.XOkWhdU6h8b0Q88J_vSpz_I5CssQx7yZaLRswSZlxb0"
/// userId : 2

class LoginResults {
  LoginResults({
    this.accessToken,
    this.userId,
    this.userFullName,
  });

  LoginResults.fromJson(dynamic json) {
    accessToken = json['access_token'];
    userId = json['userId'];
    userFullName = json['userFullName'];
  }

  String? accessToken;
  num? userId;
  String? userFullName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['access_token'] = accessToken;
    map['userId'] = userId;
    map['userFullName'] = userFullName;
    return map;
  }
}
