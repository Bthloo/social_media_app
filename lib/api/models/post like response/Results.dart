/// likableId : 2
/// likableType : "post"
/// likeId : 2

class CreateLikeResults {
  CreateLikeResults({
    this.likableId,
    this.likableType,
    this.likeId,
  });

  CreateLikeResults.fromJson(dynamic json) {
    likableId = json['likableId'];
    likableType = json['likableType'];
    likeId = json['likeId'];
  }

  num? likableId;
  String? likableType;
  num? likeId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['likableId'] = likableId;
    map['likableType'] = likableType;
    map['likeId'] = likeId;
    return map;
  }
}
