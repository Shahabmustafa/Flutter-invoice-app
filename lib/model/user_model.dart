class UserModel {
  String? uid;
  String? userName;
  String? email;
  String? profileImage;
  String? language;
  bool? theme;

  UserModel(
      {this.uid,
        this.userName,
        this.email,
        this.profileImage,
        this.language,
        this.theme});

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    userName = json['userName'];
    email = json['email'];
    profileImage = json['profileImage'];
    language = json['Language'];
    theme = json['theme'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['profileImage'] = this.profileImage;
    data['Language'] = this.language;
    data['theme'] = this.theme;
    return data;
  }
}