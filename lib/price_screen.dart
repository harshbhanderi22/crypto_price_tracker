import 'package:coin_tracker/coin_data.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';



class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  late String selectedCurrency='INR';

  late String btcprice="?";
  late String ethprice="?";
  late String ltcprice="?";

  void getData() async{

    CoinData btcd=CoinData("BTC", "$selectedCurrency");
    CoinData etcd=CoinData("ETH", "$selectedCurrency");
    CoinData ltcd=CoinData("LTC", "$selectedCurrency");

    double btc=await btcd.networkData();
    double eth=await etcd.networkData();
    double ltc=await ltcd.networkData();
    setState(() {
      btcprice=btc.toStringAsFixed(0);
      ethprice=eth.toStringAsFixed(0);
      ltcprice=ltc.toStringAsFixed(0);
    });

  }

  List<DropdownMenuItem<String>> getdropdownitems(){
    List<DropdownMenuItem<String>> dropdownitems=[];

    for(String currency in currenciesList){
      var newdropdown = DropdownMenuItem(child: Text("$currency"),value: "$currency");
      dropdownitems.add(newdropdown);
    }
    return dropdownitems;
  }
  @override
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Tracker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Currencyrow("BTC","$btcprice $selectedCurrency"),
          Currencyrow("ETH", "$ethprice $selectedCurrency"),
          Currencyrow("LTC", "$ltcprice $selectedCurrency"),
          SizedBox(height: 200.0),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton<String>(
                value: selectedCurrency,
                items: getdropdownitems(),
                onChanged: (value)
            {
              setState(() {
                 selectedCurrency=value!;
                 getData();
              });
            }),
          ),
        ],
      ),
    );
  }
}

class Currencyrow extends StatelessWidget {
  Currencyrow(this.coin,this.currency);

  final String coin;
  final String currency;

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
            '1 $coin =  $currency',
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
