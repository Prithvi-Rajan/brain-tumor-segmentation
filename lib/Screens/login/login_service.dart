import 'package:cancer_segmentation/Utils/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginService {
  FirebaseAuth firebaseIns = FirebaseAuth.instance;

  Future<User> loginWithEmailPassword({String email, String password}) async {
    await firebaseIns.signInWithEmailAndPassword(
        email: email, password: password);
    User user = firebaseIns.currentUser;
    uid = user.uid;
    firebaseUser = user;
    return user;
  }

  Future<void> logout() async {
    await firebaseIns.signOut();
    uid = null;
    firebaseUser = null;
  }
}
