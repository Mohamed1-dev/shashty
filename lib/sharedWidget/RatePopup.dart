import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shashty_app/controllers/ShowController.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

typedef void rateValue(newValue, int rateValue);

class RatePopup extends StatefulWidget {
  double valueRating;
  final isParentShow;
  var showId;
  final rateValue callbacak;
  RatePopup(this.showId, this.valueRating, this.isParentShow, this.callbacak);

  @override
  createState() => _RatePopupView();
}

class _RatePopupView extends StateMVC<RatePopup> {
  _RatePopupView() : super(ShowController()) {
    _showController = ShowController.con;
  }
  ShowController _showController;

  @override
  Widget build(BuildContext context) {
    print(widget.showId.toString() + " aaaaaa");
    var height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.only(
          left: 10, right: 10, top: height / 3, bottom: height / 3),
      child: Card(
        shape: OutlineInputBorder(
            borderRadius:
            new BorderRadius.all(new Radius.elliptical(10.0, 10.0))),
        color: Colors.grey,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "تقييمك للعمل",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height / 52,
            ),
            SmoothStarRating(
                allowHalfRating: false,
                onRatingChanged: (v) {
                  widget.valueRating = v;
                  refresh();
                },
                starCount: 5,
                rating: widget.valueRating,
                size: 35.0,
                color: Colors.yellowAccent,
                borderColor: Colors.yellowAccent,
                spacing: 1.0),
            Padding(
              padding: EdgeInsets.only(left: 8, right: 8, top: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RaisedButton(
                    padding: EdgeInsets.only(
                        top: 6.0, bottom: 6.0, right: 20.0, left: 20.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Text(
                      "اغلاق",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.red,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  RaisedButton(
                    padding: EdgeInsets.only(
                        top: 6.0, bottom: 6.0, right: 20.0, left: 20.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Text(
                      "تأكيد",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.red,
                    onPressed: () {
                      _showController
                          .rateShow(widget.showId, widget.isParentShow,
                          widget.valueRating.toInt(), context)
                          .then((res) {
                        if (res != null) {
                          widget.callbacak(widget.valueRating, int.parse(res));
                          Navigator.pop(context);

                        }
                      });
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
