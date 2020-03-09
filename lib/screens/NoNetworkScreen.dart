import 'package:flutter/material.dart';
import 'package:shashty_app/utils/FixedAssets.dart';

class NoNetworkScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              FixedAssets.noNetwork,
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width / 2,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "تاكد من الاتصال بالشبكة",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
