import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'Views/home.dart';
import 'Views/homePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Online'),
    Tab(text: 'All Songs'),
    Tab(text: 'Playlists'),
    Tab(text: 'Playlists'),
    Tab(text: 'Playlists'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ar', 'AE'),
      ],
      locale: Locale('ar', 'AE'),
      title: 'Shashty',
      theme: ThemeData.dark(),
      home: FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          List categories = snapshot.data['categories'];
          categories.insert(0, {'name': 'الرئيسية'});
          return DefaultTabController(
            length: categories.length,
            child: Scaffold(
              appBar: buildAppBar(categories),
              body: TabBarView(
                children: categories.map((category) {
                  return buildNavPage(category['name']);
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildAppBar(List categories) {
    return AppBar(
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

  Widget buildNavPage(String name) {
    if (name == 'الرئيسية') return HomePage();
    print("name: $name");
    return Container();
  }

  Future<Map> fetchData() async {
    var url = 'http://shashtyapi.sports-mate.net/api/Home';

    http.Response response = await http.get(url);

    print(json.decode(response.body)['categories']);
    return json.decode(response.body);
  }
}

