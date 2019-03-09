class User {
  String uid;
  String profileUrl;
  String name;
  String regDttm;

  User(this.uid, this.profileUrl, this.name, this.regDttm);

  factory User.fromDs(dynamic data) {
    return User(data['uid'], data['profileUrl'], data['name'], data['regDttm']);
  }

  void setDetail(String regDttm) {
    this.regDttm = regDttm;
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'profileUrl': profileUrl,
      'regDttm': regDttm,
    };
  }
}
