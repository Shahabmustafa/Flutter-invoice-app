class UserModel {
  String? uid;
  String? userName;
  String? email;
  String? profileImage;
  String? phoneNumber;
  int? cashInHand;

  UserModel(
      {this.uid,
        this.userName,
        this.email,
        this.profileImage,
        this.phoneNumber,
        this.cashInHand,
        });

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    userName = json['userName'];
    email = json['email'];
    profileImage = json['profileImage'];
    phoneNumber = json['phoneNumber'];
    cashInHand = json['cashInHand'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['profileImage'] = this.profileImage;
    data['phoneNumber'] = this.phoneNumber;
    data['cashInHand'] = this.cashInHand;
    return data;
  }
}