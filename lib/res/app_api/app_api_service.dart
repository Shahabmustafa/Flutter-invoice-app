import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
  static final invoice =
  FirebaseFirestore.instance
      .collection("users")
      .doc(userId)
      .collection("invoice");

  static FirebaseStorage storage = FirebaseStorage.instance;
}