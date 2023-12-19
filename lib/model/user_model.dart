class UserModel {
  String? uid;
  String? userName;
  String? email;
  String? profileImage;
  String? specificId;
  String? phoneNumber;
  String? token;

  UserModel(
      {this.uid,
        this.userName,
        this.email,
        this.profileImage,
        this.specificId,
        this.phoneNumber,
        this.token,
        });

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    userName = json['userName'];
    email = json['email'];
    profileImage = json['profileImage'];
    specificId = json['specificId'];
    phoneNumber = json['phoneNumber'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['profileImage'] = this.profileImage;
    data['specificId'] = this.specificId;
    data['phoneNumber'] = this.phoneNumber;
    data['token'] = this.token;
    return data;
  }
}