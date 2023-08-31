import 'Results.dart';

/// success : true
/// status_message : "liked"
/// results : {"likableId":2,"likableType":"post","likeId":2}

class CreateLikeResponse {
  CreateLikeResponse({
    this.success,
    this.statusMessage,
    this.results,
  });

  CreateLikeResponse.fromJson(dynamic json) {
    success = json['success'];
    statusMessage = json['status_message'];
    results = json['results'] != null
        ? CreateLikeResults.fromJson(json['results'])
        : null;
  }

  bool? success;
  String? statusMessage;
  CreateLikeResults? results;

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
