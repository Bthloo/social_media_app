/// fullName : "user test 2"
/// email : "usertest2@test.com"
/// password : "123456789"

class RegisterRequest {
  RegisterRequest({
    this.fullName,
    this.email,
    this.password,
  });

  RegisterRequest.fromJson(dynamic json) {
    fullName = json['fullName'];
    email = json['email'];
    password = json['password'];
  }

  String? fullName;
  String? email;
  String? password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fullName'] = fullName;
    map['email'] = email;
    map['password'] = password;
    return map;
  }
}
