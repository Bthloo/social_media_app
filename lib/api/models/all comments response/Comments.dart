import 'User.dart';

/// id : 1
/// content : "comment test1"
/// createdAt : "2023-08-30T18:40:26.881Z"
/// updatedAt : "2023-08-30T18:40:26.881Z"
/// user : {"fullName":"test user1"}

class Comments {
  Comments({
    this.id,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  Comments.fromJson(dynamic json) {
    id = json['id'];
    content = json['content'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  num? id;
  String? content;
  String? createdAt;
  String? updatedAt;
  User? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['content'] = content;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }
}
