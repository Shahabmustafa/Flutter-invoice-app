import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_invoice_app/res/calculation/calculation.dart';

class AppApiService{

  static Calculation calculation = Calculation();


  // FirebaseFirestore API
  static FirebaseFirestore firestore = FirebaseFirestore.instance;


}