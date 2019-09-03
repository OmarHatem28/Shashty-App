import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Home extends StatefulWidget {
  final data;

  const Home({Key key, @required this.data}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String url = "http://shashtyapi.sports-mate.net/public/";
  String expandedTitle = "";
  int expandedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          buildSwiper(widget.data['slider']),
          buildHorizontalList(widget.data['topViews'], "اكتر مشاهده"),
          buildHorizontalList(widget.data['persons'], "مشاهير", circle: true),
          buildHorizontalList(widget.data['showSoon'], "يعرض قريبا"),
          buildHorizontalList(widget.data['showNow'], "يعرض الان"),
          buildHorizontalList(widget.data['suggested'], "مقترح لك"),
          buildHorizontalList(widget.data['topRated'], "الاكثر تقيما"),
          buildHorizontalList(widget.data['topFavourite'], "الاكثر تفضيلا"),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: buildHorizontalList(widget.data['channels'], "قنوات",
                circle: true),
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
                    ? buildCircleAvatar(data, i)
                    : buildGridTile(data, i, title),
              );
            },
          ),
          height: 150,
        ),
        expandedTitle.isEmpty || expandedTitle != title
            ? Container()
            : buildDetailsRow(data),
      ],
    );
  }

  Widget buildDetailsRow(List data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Text(
                  data[expandedIndex]['name'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SmoothStarRating(
                  color: Colors.yellow,
                  allowHalfRating: false,
                  borderColor: Colors.yellow,
                  rating: data[expandedIndex]['rating'] * 1.0,
                  starCount: 5,
                  size: 16,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    data[expandedIndex]['brief'],
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                buildAddToRow(),
              ],
            ),
          ),
          Expanded(
            child: Image.network(
              url + data[expandedIndex]['image'],
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAddToRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconButton(
            icon: Icon(
              Icons.favorite,
              color: Colors.grey,
            ),
            onPressed: addTo),
        IconButton(icon: Icon(Icons.star, color: Colors.grey,), onPressed: addTo),
      ],
    );
  }

  void addTo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.get('user_id') == null) {
      showDialog(
        context: context,
        child: AlertDialog(
            backgroundColor: Colors.grey,
            contentPadding: EdgeInsets.all(15),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            content: Container(
              height: 150,
              child: Column(
                children: <Widget>[
                  Text("قم بتسجيل الدخول اولا او انشاء حساب للحصول على الصلاحيات"),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.red,
                        child: Text("تسجيل الدخول"),
                        onPressed: () => Navigator.pushNamed(context, 'login'),
                      ),

                      RaisedButton(
                        color: Colors.red,
                        child: Text("انشاء حساب"),
                        onPressed: () => Navigator.pushNamed(context, 'signup'),
                      ),
                    ],
                  )
                ],
              ),
            )
        ),
      );
    }
  }

  Widget buildCircleAvatar(List data, int i) {
    return CircleAvatar(
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
          ),
        ],
      ),
      radius: 70,
    );
  }

  Widget buildGridTile(List data, int i, String title) {
    return InkWell(
      onTap: () {
        setState(() {
          if (expandedIndex == i && expandedTitle == title) {
            expandedTitle = "";
            expandedIndex = -1;
          } else {
            expandedTitle = title;
            expandedIndex = i;
          }
        });
      },
      child: Container(
        width: 120,
        height: 150,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/img.jpg'), fit: BoxFit.cover),
        ),
        child: GridTile(
          child: Image.network(
            url + data[i]['image'],
            fit: BoxFit.fill,
          ),
          footer: Icon(
            Icons.arrow_drop_down,
            color: expandedIndex == i && expandedTitle == title
                ? Colors.red
                : Colors.white,
            size: 25,
          ),
        ),
      ),
    );
  }
}
