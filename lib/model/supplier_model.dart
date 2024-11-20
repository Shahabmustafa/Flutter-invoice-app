class SupplierModel {
  String? supplierId;
  String? companyName;
  String? companyEmail;
  String? phoneNumber;
  String? address;
  int? payment;
  String? supplierName;
  String? supplierPhoneNumber;
  String? supplierEmail;

  SupplierModel(
      {this.companyName,
        this.supplierId,
        this.companyEmail,
        this.phoneNumber,
        this.address,
        this.payment,
        this.supplierName,
        this.supplierPhoneNumber,
        this.supplierEmail});

  SupplierModel.fromJson(Map<String, dynamic> json) {
    supplierId = json['supplierId'];
    companyName = json['companyName'];
    companyEmail = json['companyEmail'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    payment = json['payment'];
    supplierName = json['supplierName'];
    supplierPhoneNumber = json['supplierPhoneNumber'];
    supplierEmail = json['supplierEmail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['supplierId'] = this.supplierId;
    data['companyName'] = this.companyName;
    data['companyEmail'] = this.companyEmail;
    data['phoneNumber'] = this.phoneNumber;
    data['address'] = this.address;
    data['payment'] = this.payment;
    data['supplierName'] = this.supplierName;
    data['supplierPhoneNumber'] = this.supplierPhoneNumber;
    data['supplierEmail'] = this.supplierEmail;
    return data;
  }
}