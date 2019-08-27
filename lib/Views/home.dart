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
          buildHorizontalList(data['topViews'], "اكتر مشاهده"),
          buildHorizontalList(data['persons'], "مشاهير", circle: true),
          buildHorizontalList(data['showSoon'], "يعرض قريبا"),
          buildHorizontalList(data['showNow'], "يعرض الان"),
          buildHorizontalList(data['suggested'], "مقترح لك"),
          buildHorizontalList(data['topRated'], "الاكثر تقيما"),
          buildHorizontalList(data['topFavourite'], "الاكثر تفضيلا"),
          buildHorizontalList(data['channels'], "قنوات", circle: true),
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

  Widget buildHorizontalList(List data, String title, {bool circle = false}) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Text(title, style: TextStyle(fontSize: 24),),
              Spacer(),
              Icon(Icons.grid_on)
            ],
          ),
        ),
        Container(
//          padding: EdgeInsets.only(bottom: 8, top: 8),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (context, i) {
              return Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: circle
                    ? CircleAvatar(
                        backgroundImage: AssetImage('assets/images/img.jpg'),
                        radius: 70,
                      )
                    : Container(
                        height: 100,
                        width: 100,
                        child: GridTile(
                          child: Image.asset('assets/images/img.jpg', fit: BoxFit.cover,),
                          footer: Text(data[i]['name']),
                        ),
                      ),
              );
            },
          ),
          height: 150,
        ),
      ],
    );
  }
}
