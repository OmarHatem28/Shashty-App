import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shashty/Models/user.dart';

import 'home.dart';
import 'postersPage.dart';

class StartingView extends StatelessWidget {
  List categories = [
    {'name': 'الرئيسية'},
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        categories.addAll(snapshot.data['categories']);
        return DefaultTabController(
          length: categories.length,
          child: Scaffold(
            backgroundColor: Colors.black,
            appBar: buildAppBar(categories),
            body: TabBarView(
              children: categories.map((category) {
                return buildNavPage(category['name'], snapshot.data);
              }).toList(),
            ),
            drawer: buildDrawer(context),
          ),
        );
      },
    );
  }

  Widget buildAppBar(List categories) {
    return AppBar(
      backgroundColor: Colors.black,
      title: Icon(Icons.live_tv),
      centerTitle: true,
      bottom: TabBar(
        tabs: categories.map((category) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(category['name']),
          );
        }).toList(),
        isScrollable: true,
        indicatorColor: Colors.red,
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.search),
        ),
      ],
    );
  }

  Widget buildDrawer(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 1.2,
        color: Color.fromRGBO(0, 0, 0, 0.6),
        child: FutureBuilder(
          future: getUser(),
          builder: (context, snapshot) {
            return ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: snapshot.hasData &&
                                      snapshot.data.image != null
                                  ? NetworkImage(
                                      "http://shashtyapi.sports-mate.net/public/${snapshot.data.image}")
                                  : AssetImage('assets/images/img.jpg'),
                              fit: BoxFit.cover),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.red, width: 5)),
                    ),
                    InkWell(
                      onTap: () {
                        if (snapshot.hasData && snapshot.data.image != null)
                          return null;
                        return Navigator.pushNamed(context, 'login');
                      },
                      child: Text(
                        snapshot.hasData && snapshot.data.name != null
                            ? snapshot.data.name
                            : "تسجيل الدخول",
                        style: TextStyle(fontSize: 28),
                      ),
                    ),
                  ],
                ),
                ListTile(
                  leading: Icon(Icons.help_outline),
                  title: Text("المساعدة"),
                ),
                ListTile(
                  leading: Icon(Icons.headset_mic),
                  title: Text("اتصل بنا"),
                ),
                ListTile(
                  leading: Icon(Icons.star),
                  title: Text("حقوق الملكية"),
                ),
                ListTile(
                  leading: Icon(Icons.help_outline),
                  title: Text("الشروط و الاحكام"),
                ),
                snapshot.hasData && snapshot.data.name != null
                    ? ListTile(
                        leading: Icon(Icons.exit_to_app),
                        title: Text("خروج"),
                        onTap: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.clear();
                          Navigator.pushNamedAndRemoveUntil(context, "start", (r) => false);
                        },
                      )
                    : Container(),
              ],
            );
          },
        ));
  }

  Widget buildNavPage(String name, data) {
    if (name == 'الرئيسية')
      return Home(
        data: data,
      );
    return PostersPage();
  }

  Future<Map> fetchData() async {
    var url = 'http://shashtyapi.sports-mate.net/api/Home';
    http.Response response = await http.get(url);
    return json.decode(response.body);
  }

  Future<User> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    User user = new User();
    user.name = prefs.get('user_name');
    user.image = prefs.get('user_image');

    return user;
  }
}
