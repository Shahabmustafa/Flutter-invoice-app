class SupplierModel {
  String? companyName;
  String? companyEmail;
  String? phoneNumber;
  String? address;
  String? supplierName;
  String? supplierPhoneNumber;
  String? supplieremail;

  SupplierModel(
      {this.companyName,
        this.companyEmail,
        this.phoneNumber,
        this.address,
        this.supplierName,
        this.supplierPhoneNumber,
        this.supplieremail});

  SupplierModel.fromJson(Map<String, dynamic> json) {
    companyName = json['companyName'];
    companyEmail = json['companyEmail'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    supplierName = json['supplierName'];
    supplierPhoneNumber = json['supplierPhoneNumber'];
    supplieremail = json['supplieremail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyName'] = this.companyName;
    data['companyEmail'] = this.companyEmail;
    data['phoneNumber'] = this.phoneNumber;
    data['address'] = this.address;
    data['supplierName'] = this.supplierName;
    data['supplierPhoneNumber'] = this.supplierPhoneNumber;
    data['supplieremail'] = this.supplieremail;
    return data;
  }
}