import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  String? barcode;
  String? itemId;
  String? itemName;
  int? salePrice;
  int? purchasePrice;
  int? discount;
  int? stock;
  String? category;
  int? tax;
  String? companyName;

  ItemModel(
      {
        this.barcode,
        this.itemName,
        this.itemId,
        this.salePrice,
        this.purchasePrice,
        this.discount,
        this.stock,
        this.category,
        this.tax,
        this.companyName,
       });

  factory ItemModel.fromSnap(DocumentSnapshot json) =>
      ItemModel(
        barcode: json['barcode'],
        itemId: json['itemId'],
        itemName: json['itemName'],
        salePrice: json['salePrice'],
        purchasePrice: json['purchasePrice'],
        discount: json['discount'],
        stock: json['stock'],
        category: json['category'],
        tax: json['tax'],
        companyName: json['companyName'],
      );


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['barcode'] = this.barcode;
    data['itemId'] = this.itemId;
    data['itemName'] = this.itemName;
    data['salePrice'] = this.salePrice;
    data['purchasePrice'] = this.purchasePrice;
    data['discount'] = this.discount;
    data['stock'] = this.stock;
    data['category'] = this.category;
    data['tax'] = this.tax;
    data['companyName'] = this.companyName;
    return data;
  }
}