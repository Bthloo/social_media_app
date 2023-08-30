/// content : "comment test1"

class CreateCommentRequest {
  CreateCommentRequest({
    this.content,
  });

  CreateCommentRequest.fromJson(dynamic json) {
    content = json['content'];
  }

  String? content;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['content'] = content;
    return map;
  }
}
