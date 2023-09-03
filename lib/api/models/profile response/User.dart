/// id : 2
/// fullName : "test user1"

class User {
  User({
    this.id,
    this.fullName,
  });

  User.fromJson(dynamic json) {
    id = json['id'];
    fullName = json['fullName'];
  }

  num? id;
  String? fullName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['fullName'] = fullName;
    return map;
  }
}
