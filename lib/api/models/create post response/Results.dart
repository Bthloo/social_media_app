/// postId : 10
/// userId : 2
/// userFullName : "test user1"

class CreatePostResults {
  CreatePostResults({
    this.postId,
    this.userId,
    this.userFullName,
  });

  CreatePostResults.fromJson(dynamic json) {
    postId = json['postId'];
    userId = json['userId'];
    userFullName = json['userFullName'];
  }

  num? postId;
  num? userId;
  String? userFullName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['postId'] = postId;
    map['userId'] = userId;
    map['userFullName'] = userFullName;
    return map;
  }
}
