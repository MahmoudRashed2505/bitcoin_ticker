
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;


class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';

  String BTCexchangeRate;
  String ETHexchangeRate;
  String LTCexchangeRate;

 Widget getPicker(){
   if(Platform.isIOS)
     return buildCupertinoPicker();
   else if(Platform.isAndroid)
     return buildDropdownButton();
 }

 void getData () async {
  try{
    BTCexchangeRate = await CoinData().getCoinData(selectedCurrency,'BTC');
   ETHexchangeRate = await CoinData().getCoinData(selectedCurrency,'ETH');
    LTCexchangeRate = await CoinData().getCoinData(selectedCurrency,'LTC');

    setState(() {
      print("Done");
    });
  } catch(e){
    print(e);
  }
 }

 @override
  void initState(){
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                CurrncyCard(exchangeRate: BTCexchangeRate, selectedCurrency: selectedCurrency, baseCurrency: 'BTC',),
                CurrncyCard(exchangeRate: ETHexchangeRate, selectedCurrency: selectedCurrency, baseCurrency: 'ETH',),
                CurrncyCard(exchangeRate: LTCexchangeRate, selectedCurrency: selectedCurrency, baseCurrency: 'LTC',),
              ],
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getPicker(),
          ),
        ],
      ),
    );
  }

  CupertinoPicker buildCupertinoPicker() {
    return CupertinoPicker(
            itemExtent: 32.0,
            onSelectedItemChanged: (selectedCurrency) {
              print(selectedCurrency);
            },
            children: [
              for (String currency in currenciesList)
                Text(currency)
            ],
          );
  }

  DropdownButton<String> buildDropdownButton() {
    return DropdownButton<String>(
      value: selectedCurrency,
      items: [
        for (String currency in currenciesList)
          DropdownMenuItem(
            child: Text(currency),
            value: currency,
          )
      ],
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getData();
        });
      },
    );
  }
}

class CurrncyCard extends StatelessWidget {
  const CurrncyCard({
    Key key,
    @required this.exchangeRate,
    @required this.selectedCurrency,
    @required this.baseCurrency,
  }) : super(key: key);

  final String exchangeRate;
  final String selectedCurrency;
  final String baseCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $baseCurrency = $exchangeRate $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
