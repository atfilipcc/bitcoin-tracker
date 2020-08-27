import 'package:flutter/material.dart';
import 'classes/coin_database.dart';
import 'classes/coin_request.dart' as coinRequest;
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'package:bitcoin_ticker/utils/constants.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinDatabase coinDatabase = CoinDatabase();
  String selectedCurrency = 'USD';

  Map rates = {
    'ETH': 0,
    'BTC': 0,
    'LTC': 0,
  };

  void handleCurrencyChange(newValue) async {
    List<String> cryptoList = coinDatabase.getCryptoList();

    setState(() => selectedCurrency = newValue);
    for (var i = 0; i < cryptoList.length; i++) {
      coinRequest.CoinRequest request = coinRequest.CoinRequest(
          currency: selectedCurrency, currencyToCheckRate: cryptoList[i]);
      var newRate = await request.getExchangeRate();
      print(newRate);
      if (newRate != null) {
        double calculation = 1 / newRate['rate'];
        setState(() => rates[cryptoList[i]] = calculation.toStringAsFixed(2));
      }
    }
  }

  List<Card> getCurrencyCards() {
    CoinDatabase coinDatabase = CoinDatabase();
    List<Card> cryptoCardList = [];
    List<String> cryptoList = coinDatabase.getCryptoList();

    for (String crypto in cryptoList) {
      Widget newCard = Card(
        color: kMainColorLightBlue,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $crypto = ${rates[crypto]} $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      );
      cryptoCardList.add(newCard);
    }
    print(rates);
    return cryptoCardList;
  }

  Widget getDeviceMenu() =>
      Platform.isIOS ? getIOSPicker() : getAndroidDropdown();

  DropdownButton<String> getAndroidDropdown() {
    CoinDatabase coinDatabase = CoinDatabase();
    List<DropdownMenuItem<String>> dropdownItems = [];
    List<String> currencyList = coinDatabase.getCurrencyList();
    for (String currency in currencyList) {
      Widget newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }
    return DropdownButton<String>(
        value: selectedCurrency,
        items: dropdownItems,
        onChanged: (value) {
          setState(() {
            selectedCurrency = value;
          });
        });
  }

  CupertinoPicker getIOSPicker() {
    CoinDatabase coinDatabase = CoinDatabase();
    List<String> currenciesList = coinDatabase.getCurrencyList();
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      Widget newPickerItem = Text(currency);
      pickerItems.add(newPickerItem);
    }

    return CupertinoPicker(
      backgroundColor: kMainColorLightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (value) =>
          setState(() => selectedCurrency = currenciesList[value]),
      children: pickerItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cryptocurrency Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: getCurrencyCards(),
            ),
          ),
          Center(
            child: Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              child: RaisedButton(
                child: Text(
                  'GET DATA',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                color: kMainColorLightBlue,
                textColor: Colors.white,
                onPressed: () => handleCurrencyChange(selectedCurrency),
              ),
            ),
          ),
          Center(
            child: Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              child: getDeviceMenu(),
            ),
          ),
        ],
      ),
    );
  }
}
