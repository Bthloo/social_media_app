import 'Results.dart';

/// success : true
/// status_message : "comment created"
/// results : {"userId":2,"postId":1,"commentId":1}

class CreateCommentResponse {
  CreateCommentResponse({
    this.success,
    this.statusMessage,
    this.results,
  });

  CreateCommentResponse.fromJson(dynamic json) {
    success = json['success'];
    statusMessage = json['status_message'];
    results = json['results'] != null
        ? CreateCommentResult.fromJson(json['results'])
        : null;
  }

  bool? success;
  String? statusMessage;
  CreateCommentResult? results;

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
