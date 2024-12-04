class UserModel {
  String? uid;
  String? userName;
  String? email;
  String? profileImage;
  String? phoneNumber;
  String? password;
  int? cashInHand;

  UserModel(
      {this.uid,
        this.userName,
        this.email,
        this.profileImage,
        this.phoneNumber,
        this.cashInHand,
        this.password,
        });

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    userName = json['userName'];
    email = json['email'];
    profileImage = json['profileImage'];
    phoneNumber = json['phoneNumber'];
    cashInHand = json['cashInHand'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['profileImage'] = this.profileImage;
    data['phoneNumber'] = this.phoneNumber;
    data['cashInHand'] = this.cashInHand;
    data['password'] = this.password;
    return data;
  }
}