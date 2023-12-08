class BusinessModel {
  String? businessName;
  String? businessEmail;
  String? businessPhone;
  String? businessAddress;
  String? businessLogo;

  BusinessModel(
      {
        this.businessName,
        this.businessEmail,
        this.businessPhone,
        this.businessAddress,
        this.businessLogo,
      });

  BusinessModel.fromJson(Map<String, dynamic> json) {
    businessName = json['businessName'];
    businessEmail = json['businessEmail'];
    businessPhone = json['businessPhone'];
    businessAddress = json['businessAddress'];
    businessLogo = json['businessLogo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['businessName'] = this.businessName;
    data['businessEmail'] = this.businessEmail;
    data['businessPhone'] = this.businessPhone;
    data['businessAddress'] = this.businessAddress;
    data['businessLogo'] = this.businessLogo;
    return data;
  }
}