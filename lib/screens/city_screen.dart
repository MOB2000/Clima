import 'package:flutter/material.dart';

import '../constants.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: mediaQuery * .05,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(mediaQuery * .02),
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  decoration: KTextFieldInputDecoration,
                  onChanged: (value) {
                    cityName = value;
                  },
                ),
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  primary: Colors.blue,
                  textStyle: kButtonTextStyle,
                  shape: StadiumBorder(),
                  side: BorderSide(color: Colors.greenAccent),
                ),
                onPressed: () {
                  Navigator.pop(context, cityName);
                },
                child: Text('Get Weather'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
