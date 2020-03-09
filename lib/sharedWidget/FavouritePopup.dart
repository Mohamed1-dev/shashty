import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shashty_app/controllers/ShowController.dart';

typedef void favValue(newValue);

class FavouritePopup extends StatefulWidget {
  bool isFav;
  final isParentShow;
  final isPerson;
  var showId;
  final favValue callbacak;
  FavouritePopup(this.showId, this.isFav, this.isParentShow, this.callbacak,
      {this.isPerson = false});

  @override
  createState() => _FavouritePopupView();
}

class _FavouritePopupView extends StateMVC<FavouritePopup> {
  _FavouritePopupView() : super(ShowController()) {
    _showController = ShowController.con;
  }
  ShowController _showController;

  @override
  Widget build(BuildContext context) {
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
                    widget.isFav
                        ? "هل تريد حذفه من المفضلة؟"
                        : "هل تريد إضافته إلى المفضلة ؟",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height / 52,
            ),
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
                      if (widget.isPerson) {
                        _showController
                            .favPerson(widget.showId, widget.isFav, context)
                            .then((res) {
                          if (res) {
                            widget.callbacak(widget.isFav ? 0 : 1);
                            Navigator.pop(context);
                          }
                        });
                      } else {
                        _showController
                            .favShow(widget.showId, widget.isParentShow,
                            widget.isFav, context)
                            .then((res) {
                          print("fav response ${res.toString()}");
                          widget.callbacak(widget.isFav ? 0 : 1);
                          Navigator.pop(context);

                        });
                      }
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
