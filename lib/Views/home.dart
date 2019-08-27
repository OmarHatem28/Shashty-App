import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Container(),
    );
  }

  Widget buildAppBar() {
    return AppBar(
      title: Icon(Icons.live_tv),
      centerTitle: true,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.search),
        ),
      ],
    );
  }
}
