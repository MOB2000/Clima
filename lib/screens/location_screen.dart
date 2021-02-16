import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import './city_screen.dart';
import '../constants.dart';
import '../services/parser.dart';
import '../services/weather.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  Parser parser;

  int temp;
  String message;
  String icon;
  Function getLocation;

  Future<void> _getLocationData() async {
    parser = await WeatherModel.getLocationWeather();
    if (parser == null) {
      temp = 0;
      icon = '';
      message = 'Error, Try enter another city name';
      return;
    }
    temp = (parser.main.temp).toInt();
    icon = '${WeatherModel.getWeatherIcon(parser.weather[0].id)}️';
    message = "${WeatherModel.getMessage(temp)} in ${parser.name}!";
  }

  void _updateUI(Parser parser) {
    setState(() {
      if (parser == null) {
        temp = 0;
        icon = '';
        message = 'Error, Try enter another city name';
        return;
      }
      temp = (parser.main.temp).toInt();
      icon = '${WeatherModel.getWeatherIcon(parser.weather[0].id)}️';
      message = "${WeatherModel.getMessage(temp)} in ${parser.name}!";
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: FutureBuilder<void>(
        future: _getLocationData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitRotatingCircle(
                color: Colors.white,
                size: mediaQuery.size.height * .20,
              ),
            );
          }
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/location_background.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.8),
                  BlendMode.dstATop,
                ),
              ),
            ),
            constraints: BoxConstraints.expand(),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () async {
                          parser = await WeatherModel.getLocationWeather();
                          _updateUI(parser);
                        },
                        child: Icon(
                          Icons.near_me,
                          size: mediaQuery.size.height * .07,
                        ),
                      ),
                      FlatButton(
                        onPressed: () async {
                          final typedName = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CityScreen(),
                            ),
                          );
                          if (typedName != null) {
                            parser =
                                await WeatherModel.getCityWeather(typedName);
                            _updateUI(parser);
                          }
                        },
                        child: Icon(
                          Icons.location_city,
                          size: mediaQuery.size.height * .07,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: mediaQuery.size.height * .02),
                    child: Row(
                      children: <Widget>[
                        Text(
                          '$temp°',
                          style: kTempTextStyle,
                        ),
                        Text(
                          icon,
                          style: kConditionTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(right: mediaQuery.size.height * .03),
                    child: Text(
                      message,
                      textAlign: TextAlign.right,
                      style: kMessageTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
