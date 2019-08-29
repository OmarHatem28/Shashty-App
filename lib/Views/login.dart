import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(10, 50, 10, 30),
        child: Column(
          children: <Widget>[
            Container(
              height: 150,
              width: 150,
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage('assets/images/img.jpg'),
                    fit: BoxFit.cover),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        labelText: "البريد الالكتروني",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        hasFloatingPlaceholder: true,
                      ),
                      onSaved: (v) {
                        email = v;
                      },
                      validator: (v) {
                        Pattern pattern =
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                        RegExp regex = new RegExp(pattern);
                        if (v.isEmpty || !regex.hasMatch(v))
                          return 'Enter Valid Email';
                        else
                          return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
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
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void validate() {
    if (_formKey.currentState.validate()) _formKey.currentState.save();
  }
}


//class Login extends StatelessWidget {
//  final _formKey = GlobalKey<FormState>();
//  String email, password;
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: SingleChildScrollView(
//        physics: BouncingScrollPhysics(),
//        padding: EdgeInsets.fromLTRB(10, 50, 10, 30),
//        child: Column(
//          children: <Widget>[
//            Container(
//              height: 150,
//              width: 150,
//              decoration: BoxDecoration(
//                shape: BoxShape.circle,
//                image: DecorationImage(
//                    image: AssetImage('assets/images/img.jpg'),
//                    fit: BoxFit.cover),
//              ),
//            ),
//            Form(
//              key: _formKey,
//              child: Column(
//                children: <Widget>[
//                  TextFormField(
//                    onSaved: (v) {
//                      email = v;
//                    },
//
//                    validator: (v) {
//                      Pattern pattern =
//                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//                      RegExp regex = new RegExp(pattern);
//                      if (v.isEmpty || !regex.hasMatch(v))
//                        return 'Enter Valid Email';
//                      else
//                        return null;
//                    },
//                  ),
//                  TextFormField(
//                    onSaved: (v) {
//                      password = v;
//                    },
//                    validator: (v) {
//                      if (v.isEmpty || v.length < 6)
//                        return 'Password must be at least 6 alpha-numeric characters';
//                      else
//                        return null;
//                    },
//                  ),
//                ],
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//
//  void validate() {
//    if (_formKey.currentState.validate()) _formKey.currentState.save();
//  }
//}
