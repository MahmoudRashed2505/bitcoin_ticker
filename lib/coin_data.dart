import 'dart:convert';

import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR',
  'EGP'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const baseUrl = "https://rest.coinapi.io/v1/exchangerate/";
const apiKey = "?apikey=82184276-8D74-4C02-A5AC-D41F0B5096AA";

class CoinData {

  Future<String> getCoinData(String convertedCurrency,String baseCurrncy) async{
    String exchangeRate;
    http.Response response = await http.get('$baseUrl$baseCurrncy/$convertedCurrency/$apiKey');
    String data = response.body;
    double rate = jsonDecode(data)['rate'].toDouble();
    exchangeRate = rate.toStringAsFixed(0);
    return exchangeRate;
  }

}
