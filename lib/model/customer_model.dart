class CustomerModel {
  String? customerId;
  String? customerName;
  String? email;
  String? phoneNumber;
  String? address;
  int? payment;
  String? cnic;
  String? category;

  CustomerModel(
      {this.customerName,
        this.customerId,
        this.email,
        this.phoneNumber,
        this.address,
        this.payment,
        this.cnic,
        this.category});

  CustomerModel.fromJson(Map<String, dynamic> json) {
    customerId = json['customerId'];
    customerName = json['customerName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    payment = json['payment'];
    cnic = json['cnic'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerId'] = this.customerId;
    data['customerName'] = this.customerName;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['address'] = this.address;
    data['payment'] = this.payment;
    data['cnic'] = this.cnic;
    data['category'] = this.category;
    return data;
  }
}