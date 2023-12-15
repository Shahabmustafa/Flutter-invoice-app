class ItemModel {
  String? customerName;
  String? customerEmail;
  String? customerPhone;
  String? customerAddress;
  String? itemName;
  String? itemCost;
  String? discount;
  String? tax;
  String? total;
  String? paid;
  String? totalDept;

  ItemModel({
    this.customerName,
    this.customerEmail,
    this.customerPhone,
    this.customerAddress,
    this.itemName,
    this.itemCost,
    this.discount,
    this.tax,
    this.total,
    this.paid,
    this.totalDept,
  });

  ItemModel.fromJson(Map<String, dynamic> json) {
    customerName = json['customerName'];
    customerEmail = json['customerEmail'];
    customerPhone = json['customerPhone'];
    customerAddress = json['customerAddress'];
    itemName = json['itemName'];
    itemCost = json['itemCost'];
    discount = json['discount'];
    tax = json['tax'];
    total = json['total'];
    paid = json['paid'];
    totalDept = json['totalDept'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerName'] = this.customerName;
    data['customerEmail'] = this.customerEmail;
    data['customerPhone'] = this.customerPhone;
    data['customerAddress'] = this.customerAddress;
    data['itemName'] = this.itemName;
    data['itemCost'] = this.itemCost;
    data['discount'] = this.discount;
    data['tax'] = this.tax;
    data['total'] = this.total;
    data['paid'] = this.paid;
    data['totalDept'] = this.totalDept;
    return data;
  }
}