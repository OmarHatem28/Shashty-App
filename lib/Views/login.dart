import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shashty/Models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String email, password;
  bool _autoValidate = false;
  bool progressIndicator = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(10, 50, 10, 30),
            child: Column(
              children: <Widget>[
                buildLogo(),
                buildForm(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("او"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: buildSocialMediaLoginRow(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("ليس لديك حساب؟"),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "انشاء حساب",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      ),
                      onTap: () => Navigator.pushNamed(context, 'signup'),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            height: 70,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          )
        ],
      ),
    );
  }

  Widget buildLogo() {
    return Container(
      height: 150,
      width: 150,
      margin: EdgeInsets.only(bottom: 20, top: 40),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
            image: AssetImage('assets/images/img.jpg'),
            fit: BoxFit.cover),
      ),
    );
  }

  Widget buildForm() {
    return Form(
      key: _formKey,
      autovalidate: _autoValidate,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: buildEmailField(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: buildPasswordField(),
          ),
          InkWell(
            child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(8),
                child: Text(
                  "هل نسيت كلمة السر؟",
                  textAlign: TextAlign.start,
                )),
            onTap: () => print("HI"),
          ),
          RaisedButton(
            color: Colors.red,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Text("تسجيل الدخول"),
            onPressed: () => validate(),
          ),
        ],
      ),
    );
  }

  Widget buildEmailField() {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email),
        labelText: "البريد الالكتروني",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        hasFloatingPlaceholder: true,
      ),
      onSaved: (v) {
        v = v.trim();
        email = v;
      },
      validator: (v) {
        v = v.trim();
        Pattern pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regex = new RegExp(pattern);
        if (v.isEmpty || !regex.hasMatch(v))
          return 'Enter Valid Email';
        else
          return null;
      },
    );
  }

  Widget buildPasswordField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock),
        labelText: "كلمة المرور",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        hasFloatingPlaceholder: true,
      ),
      onSaved: (v) {
        password = v;
      },
      validator: (v) {
        if (v.isEmpty || v.length < 6)
          return 'Password must be at least 6 alpha-numeric characters';
        else
          return null;
      },
    );
  }

  Widget buildSocialMediaLoginRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          child: Icon(FontAwesomeIcons.facebookF),
          decoration: BoxDecoration(
              color: Colors.indigo, shape: BoxShape.circle),
          padding: EdgeInsets.all(8),
        ),
        Container(
          child: Icon(
            FontAwesomeIcons.google,
          ),
          decoration: BoxDecoration(
              color: Colors.red, shape: BoxShape.circle),
          padding: EdgeInsets.all(8),
        ),
      ],
    );
  }

  void validate() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      loginUser();
    } else
      _autoValidate = true;
  }

  void loginUser() async {
    var body = {"email": email, "password": password};
//    var headers = {
//      "Content-Type": "application/json"
//    };
    await http
        .post('http://shashtyapi.sports-mate.net/api/auth/login', body: body)
        .then((response) async {
          print(response.body);
      User user = User.fromJson(json.decode(response.body)['user']);

      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setInt('user_id', user.id);
      prefs.setString('user_name', user.name);
      prefs.setString('user_email', user.email);
      prefs.setString('user_phone', user.phone);
      prefs.setString('user_image', user.image);

      print(prefs.get('user_image'));

      Navigator.pushNamedAndRemoveUntil(context, "start", (r) => false);
    }, onError: (err) {
      showDialog(
          context: context,
          child: AlertDialog(
            actions: <Widget>[
              FlatButton(
                child: Text("Close"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
            title: Text("Error"),
            content:
                Text("Network Error, Please Check your network connection"),
          ));
    });
  }
}
