/// success : false
/// status_message : "user is already registered"

class RegisterResponse {
  RegisterResponse({
    this.success,
    this.statusMessage,
  });

  RegisterResponse.fromJson(dynamic json) {
    success = json['success'];
    statusMessage = json['status_message'];
  }

  bool? success;
  String? statusMessage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['status_message'] = statusMessage;
    return map;
  }
}
