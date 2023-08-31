import 'Results.dart';

/// success : true
/// status_message : "created post"
/// results : {"postId":10,"userId":2,"userFullName":"test user1"}

class CreatePostResponse {
  CreatePostResponse({
    this.success,
    this.statusMessage,
    this.results,
  });

  CreatePostResponse.fromJson(dynamic json) {
    success = json['success'];
    statusMessage = json['status_message'];
    results = json['results'] != null
        ? CreatePostResults.fromJson(json['results'])
        : null;
  }

  bool? success;
  String? statusMessage;
  CreatePostResults? results;

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
