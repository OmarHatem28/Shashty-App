import 'package:flutter/material.dart';

class PostersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 0.7),
        itemCount: 4,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              child: Image.asset('assets/images/img.jpg', fit: BoxFit.cover,),
              borderRadius: BorderRadius.circular(15),
            ),
          );
        });
  }
}
