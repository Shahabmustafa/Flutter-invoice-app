class ItemModel {
  String? itemName;
  String? itemCost;
  String? itemQuantity;
  String? WholePrice;

  ItemModel({this.itemName, this.itemCost, this.itemQuantity, this.WholePrice});

  ItemModel.fromJson(Map<String, dynamic> json) {
    itemName = json['itemName'];
    itemCost = json['itemCost'];
    itemQuantity = json['itemQuantity'];
    WholePrice = json['WholePrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemName'] = this.itemName;
    data['itemCost'] = this.itemCost;
    data['itemQuantity'] = this.itemQuantity;
    data['WholePrice'] = this.WholePrice;
    return data;
  }
}