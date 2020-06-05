
import 'package:delaware_makes/forms/components/form_components.dart';
import 'package:delaware_makes/login/login.dart';
import 'package:delaware_makes/shared_widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  final FirebaseAuth firebaseAuth;
  final Function(FirebaseUser, bool) onSignIn;
  final Function() onClose;
  
  LoginPage({Key key, @required this.firebaseAuth, @required this.onSignIn,@required this.onClose }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String currentScreen = "selectAuth";
  AuthState _authState;
  @override
  void initState() {
    _authState = AuthState(widget.firebaseAuth);
    _authState.onDone = widget.onSignIn;
    super.initState();
    // _authState.addListener(() async {
    //   var currentUser =  await _authState.getCurrentUser();
    //   if(currentUser !=null) 
    //   {
    //     print(currentUser.displayName);
    //    widget.onSignIn(currentUser, _authState.isNewUser);
    //    setState(() {
         
    //    });
    //   }
    // });
  }

 
  @override
  Widget build(BuildContext context) {
    return currentScreen=="selectAuth"?selectAuth()
    :currentScreen=="signIn"?SignIn(
      authState: _authState,
      onClose: widget.onClose,
      
      )
    :SignUp(
      authState: _authState,
      onClose: widget.onClose,
      );

  }


    selectAuth()=>Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.grey[200],
      child: Center(
        child: Container(
          width: 400.0,
          height:400.0,
           decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          padding: EdgeInsets.symmetric(
            horizontal: 40,
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FormTitle(title:'Already Have an Account?'),//, fontSize: 25,),
                  SizedBox( height: 20,),
                  MainUIButton(text: 'Sign In', 
                      onPressed: () { 
                        setState(() {
                           currentScreen = "signIn";
                          
                        });
                       
                   },
                         ),
                  SizedBox(height: 20),
                  FormTitle(title:'Creating a New Account?'),//fontSize: 25,),
                  SizedBox(height: 20),
                  MainUIButton(text: 'Create account', 
                      onPressed: () {
                           setState(() {
                           currentScreen = "signUp";
                          
                        });
                         }, ),
                ],
              ),
              CloseButton(onPressed:widget.onClose)
            ],
          ),
        ),
      ),
    );

}
