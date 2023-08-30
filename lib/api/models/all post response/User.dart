/// fullName : "test user1"
/// id : 2

class User {
  User({
    this.fullName,
    this.id,
  });

  User.fromJson(dynamic json) {
    fullName = json['fullName'];
    id = json['id'];
  }

  String? fullName;
  num? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fullName'] = fullName;
    map['id'] = id;
    return map;
  }
}
