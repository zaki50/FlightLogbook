import 'package:firebase_auth/firebase_auth.dart';
import 'package:flightlogbook/bloc/authentication/current_user.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthenticationRepository {
  Future<void> logout();

  Future<bool> isLoggedIn();

  Future<CurrentUser> getCurrentUser();
}

class FirebaseAuthenticationRepository extends AuthenticationRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthenticationRepository(
      {FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  @override
  Future<CurrentUser> getCurrentUser() async {
    final currentUser = await _firebaseAuth.currentUser();
    return CurrentUser(
      id: currentUser.uid,
      name: currentUser.displayName,
    );
  }

  @override
  Future<bool> isLoggedIn() async =>
      (await _firebaseAuth.currentUser()) != null;

  @override
  Future<void> logout() =>
      Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]);
}
