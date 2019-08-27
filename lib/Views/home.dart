import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class Home extends StatelessWidget {
  final data;

  const Home({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          buildSwiper(data['slider']),
          buildHorizontalList(data['topViews']),
          buildHorizontalList(data['suggested']),
          buildHorizontalList(data['suggested']),
          buildHorizontalList(data['suggested']),
          buildHorizontalList(data['suggested']),
        ],
      ),
    );
  }

  Widget buildSwiper(List slider) {
    return Container(
      height: 200,
      child: Swiper(
        outer: false,
        itemBuilder: (context, i) {
          return Image.asset('assets/images/img.jpg');
        },
        autoplay: true,
        duration: 300,
        pagination: new SwiperPagination(
          margin: new EdgeInsets.all(5.0),
          builder: DotSwiperPaginationBuilder(
              activeColor: Colors.red, color: Colors.white),
        ),
        itemCount: slider.length,
      ),
    );
  }

  Widget buildHorizontalList(List data) {
    return Container(
      padding: EdgeInsets.only(bottom: 8, top: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemCount: data.length,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.only(left: 8,right: 8),
            child: Container(
              height: 100,
              width: 100,
              child: GridTile(
                child: Image.asset('assets/images/img.jpg'),
                footer: Text(data[i]['name']),
              ),
            ),
          );
        },
      ),
      height: 150,
    );
  }
}
