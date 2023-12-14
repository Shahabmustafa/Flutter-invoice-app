class CustomerModel {
  String? CustomerName;
  String? CustomerEmail;
  String? CustomerPhone;
  String? CustomerAddress;

  CustomerModel(
      {
        this.CustomerName,
        this.CustomerEmail,
        this.CustomerPhone,
        this.CustomerAddress,
      });

  CustomerModel.fromJson(Map<String, dynamic> json) {
    CustomerName = json['CustomerName'];
    CustomerEmail = json['CustomerEmail'];
    CustomerPhone = json['CustomerPhone'];
    CustomerAddress = json['CustomerAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CustomerName'] = this.CustomerName;
    data['CustomerEmail'] = this.CustomerEmail;
    data['CustomerPhone'] = this.CustomerPhone;
    data['CustomerAddress'] = this.CustomerAddress;
    return data;
  }
}