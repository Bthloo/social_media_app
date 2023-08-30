import 'Results.dart';

/// success : true
/// status_message : "logged in user"
/// results : {"access_token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjIsImVtYWlsIjoidGVzdHVzZXIxQHRlc3QuY29tIiwiaWF0IjoxNjkzMzMwMTkwLCJleHAiOjE2OTQ2MjYxOTB9.XOkWhdU6h8b0Q88J_vSpz_I5CssQx7yZaLRswSZlxb0","userId":2}

class LoginResponse {
  LoginResponse({
    this.success,
    this.statusMessage,
    this.results,
  });

  LoginResponse.fromJson(dynamic json) {
    success = json['success'];
    statusMessage = json['status_message'];
    results =
        json['results'] != null ? LoginResults.fromJson(json['results']) : null;
  }

  bool? success;
  String? statusMessage;
  LoginResults? results;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['status_message'] = statusMessage;
    if (results != null) {
      map['results'] = results?.toJson();
    }
    return map;
  }
}
