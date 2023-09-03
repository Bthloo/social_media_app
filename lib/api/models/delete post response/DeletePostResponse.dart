/// success : false
/// status_message : "the requested resource is not found"

class DeletePostResponse {
  DeletePostResponse({
    this.success,
    this.statusMessage,
  });

  DeletePostResponse.fromJson(dynamic json) {
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
