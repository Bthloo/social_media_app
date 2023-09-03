import 'User.dart';

/// id : 26
/// content : "dsdsd"
/// createdAt : "2023-09-02T19:16:27.936Z"
/// updatedAt : "2023-09-02T19:16:27.936Z"
/// commentCount : "0"
/// likesCount : "0"
/// likedByUser : false
/// user : {"id":2,"fullName":"test user1"}

class UserPosts {
  UserPosts({
    this.id,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.commentCount,
    this.likesCount,
    this.likedByUser,
    this.user,
  });

  UserPosts.fromJson(dynamic json) {
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
  String? commentCount;
  String? likesCount;
  bool? likedByUser;
  User? user;

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
