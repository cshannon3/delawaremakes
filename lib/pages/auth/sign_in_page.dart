import 'package:delaware_makes/forms/components/form_components.dart';
import 'package:delaware_makes/routes.dart';
import 'package:delaware_makes/service_locator.dart';
import 'package:delaware_makes/shared_widgets/shared_widgets.dart';
import 'package:delaware_makes/state/app_state.dart';
import 'package:delaware_makes/utils/utils.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({
    Key key,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  CustomLoader loader;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _email;
  String _password;
  AppState state = locator<AppState>(); //  AuthState state;

  @override
  void initState() {
    loader = CustomLoader();
    super.initState();
  }

  void _emailLogin(BuildContext bc) async {
    loader.showLoader(context);
    if (validateCredentials()) {
      state.signIn(_email, _password, scaffoldKey: _scaffoldKey).then((status) {
        if (state.authState.user != null) {
          state.authState.getCurrentUser().whenComplete(() {
            loader.hideLoader();
            state.userProfileData = state.currentUser;
            // state.currentUser=state.authState.userModel;
            //  platformInfo.setOverlay("");
            tappedMenuButton(bc, "/profile");
          });
        } else {
          cprint('Unable to login', errorIn: '_emailLoginButton');
          loader.hideLoader();
        }
      });
    } else {
      loader.hideLoader();
    }
  }

  bool validateCredentials() =>
      !(_email == null || _email.isEmpty) &&
      !(_password == null || _password.isEmpty) &&
      !(_password.length < 8);

  @override
  Widget build(BuildContext context) {
    // double w = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Container(
            width: 400.0,
            height: 400.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: Stack(children: <Widget>[
              Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(children: <Widget>[
                        FormTitle(title: "Sign In"),
                        FormDescription(
                          title: "Email:",
                        ),
                        FormEntryField(
                            labelText: 'Email',
                            hint: 'Enter email',
                            onChange: (val) => setState(() => _email = val)),
                        FormDescription(
                          title: "Password:",
                        ),
                        FormEntryField(
                            //w: w,
                            labelText: 'Password',
                            hint: 'Enter password',
                            isPassword: true,
                            onChange: (val) => setState(() => _password = val)),
                        Expanded(
                          child: Container(),
                        ),
                        MainUIButton(
                            onPressed: () {
                              _emailLogin(context);
                            },
                            text: 'Submit'),
                        SizedBox(
                          height: 10.0,
                        ),
                      ]))),
            ])));
  }
}
