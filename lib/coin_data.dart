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
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {

  CoinData(this.coin,this.currency);

  final String coin;
  final String currency;

  Future  networkData() async{
    Uri uri=Uri.parse("https://rest.coinapi"
        ".io/v1/exchangerate/$coin/$currency?apikey=F4297A30-C007-4EFA-8DA5-D132BC4EBABB");
    http.Response response= await http.get(uri);
    if(response.statusCode==200)
    {
      String data=response.body;
      var finaldata =  jsonDecode(data);
      var price=finaldata['rate'];
      return price;
    }
    else
    {
      print(response.statusCode);
    }
  }
}

//https://rest.coinapi.io/v1/exchangerate/BTC/USD