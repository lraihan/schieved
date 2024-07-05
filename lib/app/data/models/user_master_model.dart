class UserMaster {
  String? uid;
  String? name;
  String? photoUrl;
  String? email;

  UserMaster({this.uid, this.name, this.photoUrl, this.email});

  UserMaster.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    photoUrl = json['photoUrl'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['uid'] = uid;
    data['name'] = name;
    data['photoUrl'] = photoUrl;
    data['email'] = email;
    return data;
  }

  // Factory constructor to create an instance from a map
  factory UserMaster.fromMap(Map<String, dynamic> map) {
    return UserMaster(
      uid: map['uid'] as String?,
      name: map['name'] as String?,
      email: map['email'] as String?,
      photoUrl: map['photoUrl'] as String?,
    );
  }
}
