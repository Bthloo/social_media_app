import 'Posts.dart';

/// posts : [{"id":1,"content":"test user 1","createdAt":"2023-08-29T17:41:09.171Z","updatedAt":"2023-08-29T17:41:09.171Z","user":{"fullName":"test user1","id":2}},{"id":2,"content":"test user ٢","createdAt":"2023-08-30T17:27:21.638Z","updatedAt":"2023-08-30T17:27:21.638Z","user":{"fullName":"test user1","id":2}},{"id":3,"content":"test user ٢","createdAt":"2023-08-30T17:31:40.545Z","updatedAt":"2023-08-30T17:31:40.545Z","user":{"fullName":"test user1","id":2}},{"id":4,"content":"test user ٢","createdAt":"2023-08-30T17:32:30.391Z","updatedAt":"2023-08-30T17:32:30.391Z","user":{"fullName":"test user1","id":2}},{"id":5,"content":"test user ٣","createdAt":"2023-08-30T17:33:57.260Z","updatedAt":"2023-08-30T17:33:57.260Z","user":{"fullName":"test user1","id":2}},{"id":6,"content":"test user ٤","createdAt":"2023-08-30T17:56:35.593Z","updatedAt":"2023-08-30T17:56:35.593Z","user":{"fullName":"test user1","id":2}},{"id":7,"content":"test user 555","createdAt":"2023-08-30T18:22:25.027Z","updatedAt":"2023-08-30T18:22:25.027Z","user":{"fullName":"test user1","id":2}},{"id":8,"content":"test user with name","createdAt":"2023-08-30T18:24:41.839Z","updatedAt":"2023-08-30T18:24:41.839Z","user":{"fullName":"test user1","id":2}},{"id":9,"content":"test user with name٣٣","createdAt":"2023-08-30T18:30:03.801Z","updatedAt":"2023-08-30T18:30:03.801Z","user":{"fullName":"test user1","id":2}}]

class Results {
  Results({
    this.posts,
  });

  Results.fromJson(dynamic json) {
    if (json['posts'] != null) {
      posts = [];
      json['posts'].forEach((v) {
        posts?.add(Posts.fromJson(v));
      });
    }
  }

  List<Posts>? posts;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (posts != null) {
      map['posts'] = posts?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
