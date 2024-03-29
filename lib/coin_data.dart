import 'package:http/http.dart'as http;
import 'dart:convert';

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
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const bitcoinAverageURL =
    'https://apiv2.bitcoinaverage.com/indices/global/ticker';

class CoinData {
  Future getCoinData()async{
    String requestURL = '$bitcoinAverageURL/BTCUSD';
    http.Response response = await http.get(requestURL);
    if (response.statusCode == 200){
      var decodedData = jsonDecode(response.body);
      var lastPrice = decodedData['last'];
      return lastPrice;
    }else{
      print(response.statusCode);
      throw 'problem with the get request';
    }
  }

}