import 'User.dart';

/// id : 1
/// content : "test user 1"
/// createdAt : "2023-08-29T17:41:09.171Z"
/// updatedAt : "2023-08-29T17:41:09.171Z"
/// user : {"fullName":"test user1","id":2}

class Posts {
  Posts(
      {this.id,
      this.content,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.commentCount,
      this.likedByUser,
      this.likesCount});

  Posts.fromJson(dynamic json) {
    id = json['id'];
    content = json['content'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    commentCount = json['commentCount'];
    likesCount = json['likesCount'];
    likedByUser = json['likedByUser'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  num? id;
  String? content;
  String? createdAt;
  String? updatedAt;
  User? user;
  String? commentCount;
  String? likesCount;
  bool? likedByUser;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['content'] = content;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['commentCount'] = commentCount;
    map['likesCount'] = likesCount;
    map['likedByUser'] = likedByUser;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }
}
