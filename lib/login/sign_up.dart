
import 'package:delaware_makes/forms/components/form_components.dart';
import 'package:delaware_makes/login/login.dart';
import 'package:delaware_makes/shared_widgets/shared_widgets.dart';
import 'package:delaware_makes/utils/utils.dart';
import 'package:flutter/material.dart';
import '../extensions/hover_extension.dart';



class SignUp extends StatefulWidget {
  final AuthState authState;
  final Function() onClose;
  const SignUp({Key key, @required this.authState, @required this.onClose}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _SignUpState();
}
class _SignUpState extends State<SignUp> {
  CustomLoader loader;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _name; String _email;
  String _password;String _passwordConfirm;

  List screens = [false, false];//, false];
  List icons = [  Icons.person_outline, Icons.lock];//,Icons.verified_user,];
  List screenWidgets;
  int currentScreenNum = 0;
  var _userKey = GlobalKey<FormState>();
  var _passwordKey = GlobalKey<FormState>();
  
  @override
  void initState() {
    loader = CustomLoader();
    super.initState();
  }
    @override
  Widget build(BuildContext context) {
       screenWidgets = [
      padForm(userInfoForm(),  h: 450.0),
      padForm(passwordForm(),  h: 350.0),
     
    ];
    return Center(
      child: SafeArea(
        child: Container(
        width: 400.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             progressRow(),
              SizedBox(
      height: 10.0,
        ),
              screenWidgets[currentScreenNum]
          ]),
      )),
    );
  }
  Widget userInfoForm()=>Form(
    key:_userKey,
    child: Column(children: <Widget>[
                      FormTitle(title:"Sign Up"),
                      FormDescription(title:"Name:"),
                      FormEntryField(
                        initVal: _name,
                          labelText: 'Name',hint: 'Enter name',
                          onChange: (val) => setState(() => _name = val)),
                      FormDescription(title:"Email:"),
                      FormEntryField(
                        validator:(val)=>!validateEmail(val)?'Please enter email correctly':null,
                        initVal:_email ,
                          labelText: 'Email',hint: 'Enter email',
                          onChange: (val) => setState(() => _email = val)),
                                   Expanded(child: Container(),),
          MaterialButton(
              hoverColor: Colors.white,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              color: Colors.grey[200],
              onPressed: () {
              if (_userKey.currentState.validate()) {
                  _userKey.currentState.save();
                  setState(() {
                  screens[0] = true;
                  currentScreenNum += 1;
                }); 
                }
              },
              child: Text("Next")).showCursorOnHover.moveUpOnHover,
               SizedBox(
          height:10.0,
        ),
    ],),
  );

  
  Widget passwordForm()=>Form(
    key: _passwordKey,
    child: Column(children: <Widget>[
                          FormDescription(title:"Password:"),
                      FormEntryField(
                          labelText: 'Password',hint: 'Enter password',isPassword: true,
                          onChange: (val) => setState(() => _password = val)),

                    FormDescription(title:"Confirm Password:"),
                      FormEntryField(
                        validator: (val) =>val!=_password?"Password Doesn't Match":null,
                          labelText: 'Confirm Password',hint: 'Confirm password',isPassword: true,
                          onChange: (val) => setState(() => _passwordConfirm = val)),
                          
                            Expanded(child: Container(),),
                              MaterialButton(
              hoverColor: Colors.white,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              color: Colors.grey[200],
              onPressed: () {
                if (_passwordKey.currentState.validate()) {
                  _passwordKey.currentState.save();
                 _submitForm();
                }
              },
              child: Text("Submit")).showCursorOnHover.moveUpOnHover,
               SizedBox(
          height:10.0,
        ),
    ]),
  );
    

    Widget padForm(Widget widget, {double h = 400}) => Center(
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          width: 400.0,
          height: h,
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: widget)));

  void _submitForm() async {
    
    loader.showLoader(context);
    await widget.authState.signUp(_email,
      password: _password,
      scaffoldKey: _scaffoldKey,);
    loader.hideLoader();
  }
    Widget iconButton(int itemNum){
        bool current = itemNum==currentScreenNum;
        bool done = screens[itemNum];
      return  Container(
          decoration: BoxDecoration(
          border: Border.all(color:current?Colors.blue:done?Colors.green:Colors.grey, width: 2.0),
            shape:BoxShape.circle
            ),
          child: Padding(
            padding: EdgeInsets.all(3.0),
            child: IconButton(
              onPressed: (){
                bool isAvailable=true;
                for (int i = 0;i<itemNum; i++){
                  if(!screens[i])isAvailable=false;
                }
                if(isAvailable)
                setState(() {
                  currentScreenNum=itemNum;
                });
              },
              icon: Icon(icons[itemNum], color: done?Colors.green:Colors.grey,)),
          )).showCursorOnHover.moveUpOnHover;
  }   


  Widget progressRow()=>Container(
       decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
          ),
    width: 400.0,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          iconButton(0),
          iconButton(1),
         // iconButton(2),
        ],
      ),
    ),
  );


}
