import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bordered_text/bordered_text.dart';

class Home extends StatelessWidget {
  final data;

  const Home({Key key, @required this.data}) : super(key: key);

  final String url = "http://shashtyapi.sports-mate.net/public/";

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
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: buildHorizontalList(data['channels'], "قنوات", circle: true),
          ),
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
          return Image.network(
            url + slider[i]['image'],
            fit: BoxFit.fill,
          );
        },
//        autoplay: true,
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
              Text(
                title,
                style: TextStyle(fontSize: 24),
              ),
              Spacer(),
              Icon(FontAwesomeIcons.th, size: 15),
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
                        child: Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(url + data[i]['image']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                BorderedText(
                                  strokeWidth: 8.0,
                                  strokeColor: Colors.black,
                                  child: Text(
                                    data[i]['name'],
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        radius: 70,
                      )
                    : Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/img.jpg'),
                              fit: BoxFit.cover),
                        ),
                        child: GridTile(
                          child: Image.network(
                            url + data[i]['image'],
                            fit: BoxFit.fill,
                          ),
                          footer: Icon(
                            Icons.arrow_drop_down,
                            size: 25,
                          ),
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
