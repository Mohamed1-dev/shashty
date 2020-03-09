import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shashty_app/utils/FixedAssets.dart';

class SideMenuScreen extends StatefulWidget {
  @override
  createState() => SideMenuScreenState();
}

class SideMenuScreenState extends State<SideMenuScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(FixedAssets.backgroundImage),
                fit: BoxFit.cover)),
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 7,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/Login");
                },
                child: Text(
                  "الدخول",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/Register");
                },
                child: Text(
                  "انشاء حساب",
                  style: TextStyle(color: Colors.redAccent, fontSize: 20),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 1.5,
                  color: Colors.white,
                ),
              ],
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                "اتصل بنا",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                "حقوق الملكيه",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                "الشروط و الاحكام",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Icon(
                        FontAwesomeIcons.facebookF,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Icon(
                        FontAwesomeIcons.twitter,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Icon(
                        FontAwesomeIcons.instagram,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
