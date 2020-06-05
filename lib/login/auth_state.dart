
import 'package:delaware_makes/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class AuthState extends ChangeNotifier{
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  bool isNewUser = false;
  FirebaseUser user;
  String userId;//final  fb.Messaging _firebaseMessaging = fb.messaging();
  final FirebaseAuth _firebaseAuth;
  Function(FirebaseUser, bool) onDone;

  bool _isBusy;

  AuthState(this._firebaseAuth);
  
  bool get isbusy => _isBusy;
  set loading(bool value){
    _isBusy = value;
    notifyListeners();
  }
  /// Logout from device
  void logoutCallback() {
    authStatus = AuthStatus.NOT_LOGGED_IN;
    userId = ''; 
    user = null;
    _firebaseAuth.signOut();
    notifyListeners();
  }
  /// Verify user's credentials for login
  Future<String> signIn(String email, String password,
      {GlobalKey<ScaffoldState> scaffoldKey}) async {
    try {
      isNewUser= false;
      loading = true;
      var result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      user = result.user;
      print(user);
      userId = user.uid; // loading=false;
      onDone(user, false);
      return user.uid;
    } catch (error) {
      loading = false;
      cprint(error, errorIn: 'signIn');
      //customSnackBar(scaffoldKey, error.message);
      return null;
    }
  }


  /// Create new user's profile in db
  Future<String> signUp(//User newUserModel,
  String userEmail,
      {GlobalKey<ScaffoldState> scaffoldKey, String password}) async {
    try {
      isNewUser=true;
      loading = true;//   print("s");
      var result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: userEmail,
        password: password,).catchError((onError){
          print(onError);
        });
      user = result.user;

      //print(user);
      authStatus = AuthStatus.LOGGED_IN;  //  kAnalytics.logSignUp(signUpMethod: 'register');
       onDone(user, true);
      return user.uid;
    } catch (error) {
      loading = false;
      cprint(error, errorIn: 'signUp');//  customSnackBar(scaffoldKey, error.message);
      return null;
    }
  }
  /// Fetch current user profile
  Future<FirebaseUser> getCurrentUser() async {
    try {
      loading = true;  // logEvent('get_currentUSer');
      user = await _firebaseAuth.currentUser();
      if (user != null) {
        print("User"); // print(user.displayName);
        authStatus = AuthStatus.LOGGED_IN;
        userId = user.uid;   //  await getProfileUser();
         return user;
      } else {
        authStatus = AuthStatus.NOT_LOGGED_IN;
      } //  loading = false;
    return user;
    } catch (error) {
      loading = false;
      cprint(error, errorIn: 'getCurrentUser');
      authStatus = AuthStatus.NOT_LOGGED_IN;
      return null;
    }
  }

  /// Reload user to get refresh user data
  Future<bool> reloadUser() async {
    await user.reload();
    user = await _firebaseAuth.currentUser();
    
    if (user.isEmailVerified) {
      cprint('User email verification complete');
      return true;
    }
    return false;
  }
  /// Send email verification link to email2
  Future<void> sendEmailVerification({ 
      GlobalKey<ScaffoldState> scaffoldKey}) async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification().then((_) {
    }).catchError((error) {
      cprint(error.message, errorIn: 'sendEmailVerification');
    });
  }
    /// Check if user's email is verified
  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }

  /// Send password reset link to email
  Future<void> forgetPassword(String email,
      {GlobalKey<ScaffoldState> scaffoldKey}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email).then((value) {
      }).catchError((error) {
        cprint(error.message);
        return false;
      });
    } catch (error) {
      return Future.value(false);
    }
  }

}



