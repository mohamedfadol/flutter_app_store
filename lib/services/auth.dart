import 'package:firebase_auth/firebase_auth.dart';
class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<UserCredential> signUp( name,  email,  password) async {
    final authResult = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return authResult;
  }

  Future<UserCredential> signIn(email, password) async {
    final authResult = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return authResult;
  }

   getUser() {
     User? user = _auth.currentUser;
    if (user != null ) {
      return user = _auth.currentUser;
    }
  }



  Future<void> signOut() async {
    await _auth.signOut();
  }
}
