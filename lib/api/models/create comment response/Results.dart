/// userId : 2
/// postId : 1
/// commentId : 1

class CreateCommentResult {
  CreateCommentResult({
    this.userId,
    this.postId,
    this.commentId,
  });

  CreateCommentResult.fromJson(dynamic json) {
    userId = json['userId'];
    postId = json['postId'];
    commentId = json['commentId'];
  }

  num? userId;
  num? postId;
  num? commentId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    map['postId'] = postId;
    map['commentId'] = commentId;
    return map;
  }
}
