import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'price_screen.dart';
import 'package:bitcoin_ticker/utils/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          primaryColor: kMainColorBlue,
          scaffoldBackgroundColor: kMainColorBlue,
          buttonTheme: ButtonThemeData(
            minWidth: 200.0,
            height: 50.0,
          ),
          cupertinoOverrideTheme: CupertinoThemeData(
              textTheme: CupertinoTextThemeData(
            pickerTextStyle: TextStyle(color: Colors.white, fontSize: 18.0),
          ))),
      home: PriceScreen(),
    );
  }
}
