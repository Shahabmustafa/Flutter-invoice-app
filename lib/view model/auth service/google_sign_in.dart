import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class googleSignInController extends GetxController{


  RxBool _loading = false.obs;
  RxBool get loading => _loading;

  setLoading(bool value) {
    _loading.value = value;
  }

  Future<UserCredential> signInWithGoogle() async {
    setLoading(true);

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        setLoading(false);
        return Future.error('Google sign-in canceled');
      }

      final GoogleSignInAuthentication? googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      setLoading(false);
      return userCredential;
    } catch (e) {
      setLoading(false);
      return Future.error(e.toString());
    }
  }


}