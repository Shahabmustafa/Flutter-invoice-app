import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_invoice_app/res/calculation/calculation.dart';

class AppApiService{

  static Calculation calculation = Calculation();

  // firebaseAuth API
  static FirebaseAuth auth = FirebaseAuth.instance;
  static User? user = auth.currentUser;
  static final userId = auth.currentUser!.uid;
  static final userEmail = auth.currentUser!.email;
  static final userDisplayName = auth.currentUser!.displayName;
  static final userPhoto = auth.currentUser!.photoURL;

  // FirebaseFirestore API
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static final item =
  firestore.collection("users")
      .doc(userId)
      .collection("items");

  static final customer =
  firestore.collection("users")
      .doc(userId)
      .collection("customer");

  static final supplier =
  firestore.collection("users")
      .doc(userId)
      .collection("supplier");

  static final order =
  firestore.collection("users")
      .doc(userId)
      .collection("orders");

  static final dashboard =
  firestore.collection("users")
      .doc(userId)
      .collection("dashboard")
      .doc(calculation.date());

  static final categori =
  firestore.collection("users")
      .doc(userId)
      .collection("categori");

  static final sale =
  firestore.collection("users")
      .doc(userId)
      .collection("sale");
}