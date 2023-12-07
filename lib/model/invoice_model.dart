class InvoiceModel {
  String? businessName;
  String? businessEmail;
  String? businessNumber;
  String? businessAddress;
  String? payerName;
  String? payerEmail;
  String? payerNumber;
  String? payerAddress;
  String? note;
  String? date;

  InvoiceModel(
      {this.businessName,
        this.businessEmail,
        this.businessNumber,
        this.businessAddress,
        this.payerName,
        this.payerEmail,
        this.payerNumber,
        this.payerAddress,
        this.note,
        this.date});

  InvoiceModel.fromJson(Map<String, dynamic> json) {
    businessName = json['businessName'];
    businessEmail = json['businessEmail'];
    businessNumber = json['businessNumber'];
    businessAddress = json['businessAddress'];
    payerName = json['payerName'];
    payerEmail = json['payerEmail'];
    payerNumber = json['payerNumber'];
    payerAddress = json['payerAddress'];
    note = json['note'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['businessName'] = this.businessName;
    data['businessEmail'] = this.businessEmail;
    data['businessNumber'] = this.businessNumber;
    data['businessAddress'] = this.businessAddress;
    data['payerName'] = this.payerName;
    data['payerEmail'] = this.payerEmail;
    data['payerNumber'] = this.payerNumber;
    data['payerAddress'] = this.payerAddress;
    data['note'] = this.note;
    data['date'] = this.date;
    return data;
  }
}