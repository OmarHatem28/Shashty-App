import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        return Scaffold(
          appBar: buildAppBar(snapshot.data['categories']),
          body: Container(),
        );
      },
    );
  }

  Widget buildAppBar(List categories) {
    categories.insert(0, {'name': 'الرئيسية'});
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
        controller: TabController(length: categories.length, vsync: AnimatedListState()),
        isScrollable: true,
        indicatorColor: Colors.red,
        onTap: (selected) {
          print(selected);
        },
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.search),
        ),
      ],
    );
  }

  Future<Map> fetchData() async {
    var url = 'http://shashtyapi.sports-mate.net/api/Home';

    http.Response response = await http.get(url);

    print(json.decode(response.body)['categories']);
    return json.decode(response.body);
  }
}
