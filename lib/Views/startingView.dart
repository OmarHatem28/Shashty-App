import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'home.dart';
import 'postersPage.dart';

class StartingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        List categories = snapshot.data['categories'];
        categories.insert(0, {'name': 'الرئيسية'});
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
      child: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/img.jpg'),
                        fit: BoxFit.cover),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.red, width: 5)),
              ),
              InkWell(
                onTap: () => Navigator.pushNamed(context, 'login'),
                child: Text(
                  "تسجيل الدخول",
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
        ],
      ),
    );
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
}
