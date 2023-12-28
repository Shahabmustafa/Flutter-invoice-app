import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  String? itemName;
  String? sale;
  String? cost;
  String? wholeSale;
  String? tax;
  String? companyName;
  String? saleDate;
  String? expiryDate;

  ItemModel(
      {this.itemName,
        this.sale,
        this.cost,
        this.wholeSale,
        this.tax,
        this.companyName,
        this.saleDate,
        this.expiryDate});

  static ItemModel fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String,dynamic>;
    return ItemModel(
      itemName: snapshot["itemName"],
      sale: snapshot["sale"],
      cost: snapshot["cost"],
      wholeSale: snapshot["wholeSale"],
      tax: snapshot["tax"],
      companyName: snapshot["companyName"],
      saleDate: snapshot["saleDate"],
      expiryDate: snapshot["expiryDate"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemName'] = this.itemName;
    data['sale'] = this.sale;
    data['cost'] = this.cost;
    data['wholeSale'] = this.wholeSale;
    data['tax'] = this.tax;
    data['companyName'] = this.companyName;
    data['saleDate'] = this.saleDate;
    data['expiryDate'] = this.expiryDate;
    return data;
  }
}