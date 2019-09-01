import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  var passKey = GlobalKey<FormFieldState>();

  String name, email, phone, password, rePassword;
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

  Widget buildAppBar() {
    return Container(
      height: 70,
      child: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Exp",
              style: TextStyle(color: Colors.white),
            ),
            Text(
              "lore",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
//              iconTheme: IconThemeData(color: Colors.black),
        actionsIconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.search),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.notifications),
          ),
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
            image: AssetImage('assets/images/img.jpg'), fit: BoxFit.cover),
      ),
    );
  }

  Widget buildForm() {
    return Form(
      key: _formKey,
      autovalidate: _autoValidate,
      child: Column(
        children: <Widget>[
          buildFormField('الاسم', Icons.person, 3),
          buildEmailField(),
          buildFormField('رقم الهاتف', Icons.phone, 6),
          buildPasswordField(),
          buildConfirmPasswordField(),
          RaisedButton(
            color: Colors.red,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Text("انشاء حساب"),
            onPressed: () => validate(),
          ),
        ],
      ),
    );
  }

  Widget buildEmailField() {
    return Padding(
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
          v = v.trim();
          Pattern pattern =
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
          RegExp regex = new RegExp(pattern);
          if (v.isEmpty || !regex.hasMatch(v))
            return 'Enter Valid Email';
          else
            return null;
        },
      ),
    );
  }

  Widget buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        key: passKey,
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
    );
  }

  Widget buildConfirmPasswordField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          labelText: "تأكيد كلمة المرور",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          hasFloatingPlaceholder: true,
        ),
        onSaved: (v) {
          rePassword = v;
        },
        validator: (v) {
          var password = passKey.currentState.value;
          if ( v.isEmpty || v != password)
            return "Passwords must match";
          return null;
        },
      ),
    );
  }

  Widget buildFormField(String label, IconData icon, int minimum) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          hasFloatingPlaceholder: true,
        ),
        onSaved: (v) {
          if (label == 'الاسم')
            name = v;
          else
            phone = v;
        },
        validator: (v) {
          if (v.isEmpty || v.length < minimum)
            return '$label must be at least 6 alpha-numeric characters';
          else
            return null;
        },
      ),
    );
  }

  void validate() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
//      loginUser();
    } else
      _autoValidate = true;
  }
}
