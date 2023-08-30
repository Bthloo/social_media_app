import 'Results.dart';

/// success : true
/// status_message : "fetched all comments"
/// results : {"comments":[{"id":1,"content":"comment test1","createdAt":"2023-08-30T18:40:26.881Z","updatedAt":"2023-08-30T18:40:26.881Z","user":{"fullName":"test user1"}}],"postId":1}

class CommentsResponse {
  CommentsResponse({
    this.success,
    this.statusMessage,
    this.results,
  });

  CommentsResponse.fromJson(dynamic json) {
    success = json['success'];
    statusMessage = json['status_message'];
    results =
        json['results'] != null ? Results.fromJson(json['results']) : null;
  }

  bool? success;
  String? statusMessage;
  Results? results;

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
