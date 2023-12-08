class PayerModel {
  String? payerName;
  String? payerEmail;
  String? payerPhone;
  String? payerAddress;

  PayerModel(
      {this.payerName, this.payerEmail, this.payerPhone, this.payerAddress});

  PayerModel.fromJson(Map<String, dynamic> json) {
    payerName = json['payerName'];
    payerEmail = json['payerEmail'];
    payerPhone = json['payerPhone'];
    payerAddress = json['payerAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payerName'] = this.payerName;
    data['payerEmail'] = this.payerEmail;
    data['payerPhone'] = this.payerPhone;
    data['payerAddress'] = this.payerAddress;
    return data;
  }
}