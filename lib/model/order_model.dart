


class OrderModel {
  String? itemName;
  String? companyName;
  String? sale;
  String? cost;
  String? wholeSale;
  String? discount;
  String? Tax;
  String? Stock;
  String? type;

  OrderModel(
      {this.itemName,
        this.companyName,
        this.sale,
        this.cost,
        this.wholeSale,
        this.discount,
        this.Tax,
        this.Stock,
        this.type,
      });

  OrderModel.fromJson(Map<String, dynamic> json) {
    itemName = json['itemName'];
    companyName = json['companyName'];
    sale = json['sale'];
    cost = json['cost'];
    wholeSale = json['wholeSale'];
    discount = json['discount'];
    Tax = json['Tax'];
    Stock = json['Stock'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemName'] = this.itemName;
    data['companyName'] = this.companyName;
    data['sale'] = this.sale;
    data['cost'] = this.cost;
    data['wholeSale'] = this.wholeSale;
    data['discount'] = this.discount;
    data['Tax'] = this.Tax;
    data['Stock'] = this.Stock;
    data['type'] = this.type;
    return data;
  }
}