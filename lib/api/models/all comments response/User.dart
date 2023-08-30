/// fullName : "test user1"

class User {
  User({
    this.fullName,
  });

  User.fromJson(dynamic json) {
    fullName = json['fullName'];
  }

  String? fullName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fullName'] = fullName;
    return map;
  }
}
