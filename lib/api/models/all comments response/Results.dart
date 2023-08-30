import 'Comments.dart';

/// comments : [{"id":1,"content":"comment test1","createdAt":"2023-08-30T18:40:26.881Z","updatedAt":"2023-08-30T18:40:26.881Z","user":{"fullName":"test user1"}}]
/// postId : 1

class Results {
  Results({
    this.comments,
    this.postId,
  });

  Results.fromJson(dynamic json) {
    if (json['comments'] != null) {
      comments = [];
      json['comments'].forEach((v) {
        comments?.add(Comments.fromJson(v));
      });
    }
    postId = json['postId'];
  }

  List<Comments>? comments;
  num? postId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (comments != null) {
      map['comments'] = comments?.map((v) => v.toJson()).toList();
    }
    map['postId'] = postId;
    return map;
  }
}
