import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  String? itemName;
  String? sale;
  String? cost;
  String? wholeSale;
  List? stock;
  String? categori;
  String? tax;
  String? companyName;
  String? saleDate;
  String? expiryDate;

  ItemModel(
      {this.itemName,
        this.sale,
        this.cost,
        this.wholeSale,
        this.stock,
        this.categori,
        this.tax,
        this.companyName,
        this.saleDate,
        this.expiryDate});

  factory ItemModel.fromSnap(DocumentSnapshot json) =>
      ItemModel(
        itemName: json['itemName'],
        sale: json['sale'],
        cost: json['cost'],
        wholeSale: json['wholeSale'],
        stock: json['stock'],
        categori: json['categori'],
        tax: json['tax'],
        companyName: json['companyName'],
        saleDate: json['saleDate'],
        expiryDate: json['expiryDate'],
      );


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemName'] = this.itemName;
    data['sale'] = this.sale;
    data['cost'] = this.cost;
    data['wholeSale'] = this.wholeSale;
    data['stock'] = this.stock;
    data['categori'] = this.categori;
    data['tax'] = this.tax;
    data['companyName'] = this.companyName;
    data['saleDate'] = this.saleDate;
    data['expiryDate'] = this.expiryDate;
    return data;
  }
}