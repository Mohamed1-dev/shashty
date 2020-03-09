import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shashty_app/data/Models/CategoryModel.dart';
import 'package:shashty_app/screens/Show/ShowDetails/MovieShowScreen.dart';
import 'package:shashty_app/screens/Show/ShowDetails/ProgramAndSeriesShowScreen.dart';
import 'package:shashty_app/utils/ApiRoutes.dart';
import 'package:shashty_app/utils/AppProvider.dart';
import 'package:shashty_app/utils/Auth.dart';
import 'package:shashty_app/utils/FixedAssets.dart';

class HomeSlider extends StatefulWidget {
  List<CategoryModel> categoryModels;

  HomeSlider(this.categoryModels);
  @override
  HomeSliderState createState() => HomeSliderState();
}

class HomeSliderState extends State<HomeSlider> {
  Auth auth;
  @override
  Widget build(BuildContext context) {
    auth = AppProvider.of(context).auth;

    return sliderContainer(context);
  }

  int photoIndex;

  Widget sliderContainer(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
          child: Container(
//            padding: EdgeInsets.all(8),
//            height: 200,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: Stack(
                  children: <Widget>[
                    carousel2(context),
                    Positioned(
                        bottom: 10.0,
                        left: 25.0,
                        right: 25.0,
                        child: SelectedPhoto(
                          numberOfDots: widget.categoryModels.length,
                          photoIndex: photoIndex,
                        )),
                  ],
                )),
          ),
        )
      ],
    );
  }

  static List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  Widget carousel2(BuildContext context) => new CarouselSlider(
        onPageChanged: (x) {
          photoIndex = x;
          setState(() {});
        },
        items: map<Widget>(
          widget.categoryModels,
          (index, CategoryModel i) {
            return Container(
//              child: ClipRRect(
//                borderRadius: BorderRadius.all(Radius.circular(0)),
              child: GestureDetector(
                onTap: () {
                  if (i.category[0].name.toString().trim() == "افلام") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MovieShowScreen(i.id, "افلام")));
                  } else if (i.category[0].name.toString().trim() ==
                      "مسلسلات") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProgramAndSeriesShowScreen(
                              i.id, "مسلسلات", false)),
                    );
                  } else if (i.category[0].name.toString().trim() == "برامج") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ProgramAndSeriesShowScreen(i.id, "برامج", true)),
                    );
                  }
                },
                child: FadeInImage(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  image: i.image != null
                      ? NetworkImage(ApiRoutes.public + i.slider[0].image)
                      : AssetImage(FixedAssets.noImage),
                  placeholder: new AssetImage(FixedAssets.noImage),
                  fit: BoxFit.fitWidth,
                ),
              ),
//              ),
            );
          },
        ).toList(),
        autoPlay: widget.categoryModels.length != 1 ? true : false,
        viewportFraction: 1.0,
//        aspectRatio: 40 / 20,
        enlargeCenterPage: true,
      );
}

class SelectedPhoto extends StatelessWidget {
  final int numberOfDots;

  final int photoIndex;
  SelectedPhoto({this.numberOfDots, this.photoIndex});
  Widget _inactivePhoto() {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 3.0, right: 3.0),
        child: Container(
          height: 8.0,
          width: 8.0,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(4.0)),
        ),
      ),
    );
  }

  Widget _activePhoto() {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 5.0, right: 5.0),
        child: Container(
          height: 10.0,
          width: 10.0,
          decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.white, spreadRadius: 0.0, blurRadius: 2.0)
              ]),
        ),
      ),
    );
  }

  List<Widget> _buildDots() {
    List<Widget> dots = [];

    for (int i = 0; i < numberOfDots; i++) {
      dots.add(i == photoIndex ? _activePhoto() : _inactivePhoto());
    }

    return dots;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildDots(),
      ),
    );
  }
}
