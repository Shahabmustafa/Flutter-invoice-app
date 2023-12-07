import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppApiService{

  // firebaseAuth API
  static FirebaseAuth auth = FirebaseAuth.instance;
  static User? user = auth.currentUser;
  static final userId = auth.currentUser!.uid;
  static final userEmail = auth.currentUser!.email;
  static final userDisplayName = auth.currentUser!.displayName;
  static final userPhoto = auth.currentUser!.photoURL;


  // FirebaseFirestore API
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static DocumentReference<Map<String, dynamic>> userdb = firestore.collection("users").doc(userId);
  static final business =
  FirebaseFirestore.instance
      .collection("users")
      .doc(userId)
      .collection("business");

  static final addItem =
  FirebaseFirestore.instance
      .collection("users")
      .doc(userId)
      .collection("addItem");

  static final payer =
  FirebaseFirestore.instance
      .collection("users")
      .doc(userId)
      .collection("payer");

  static final payment =
  FirebaseFirestore.instance
      .collection("users")
      .doc(userId)
      .collection("payment");
}