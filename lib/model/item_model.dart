class ItemModel {
  String? itemName;
  String? itemCost;
  String? itemQuantity;
  String? total;

  ItemModel({this.itemName, this.itemCost, this.itemQuantity, this.total});

  ItemModel.fromJson(Map<String, dynamic> json) {
    itemName = json['itemName'];
    itemCost = json['itemCost'];
    itemQuantity = json['itemQuantity'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemName'] = this.itemName;
    data['itemCost'] = this.itemCost;
    data['itemQuantity'] = this.itemQuantity;
    data['total'] = this.total;
    return data;
  }
}