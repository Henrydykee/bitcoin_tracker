import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform, platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  List<Widget> dropdownItems = [];

  String selectedCurrency = 'USD';

 CupertinoPicker iOSPicker(){
   List<Text> pickerItems = [];
   for(String currency in currenciesList){
     pickerItems.add(Text(currency));
   }
   CupertinoPicker(
       backgroundColor: Colors.lightBlue,
       itemExtent: 32.0,
       onSelectedItemChanged: (selectedIndex) {
         print(selectedIndex);
       },
       children: getPickerItems()
   );
 }


  DropdownButton<String> androidDropdown() {
    for (int i = 0; i < currenciesList.length; i++) {
      String currency = currenciesList[i];
      var newItem = DropdownMenuItem(
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

  List<Widget> getPickerItems() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      Text(currency);
      pickerItems.add(Text(currency));
    }
    return pickerItems;
  }

  String bitcoinValaueInUSD = '?';
 void  getData  () async {
   try{
     double data = await CoinData().getCoinData();
     setState(() {
       bitcoinValaueInUSD = data.toStringAsFixed(0);
     });
   } catch (e){
     print(e);
   }
 }
  @override
  void initState() {
    super.initState();
      getData();
  }


 Widget getPicker(){
   if(Platform.isIOS){
     return iOSPicker();
   }else if (Platform.isAndroid){
     return androidDropdown();
   }
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
          Padding(
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
                  '1 BTC = $bitcoinValaueInUSD USD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: getPicker(),)
        ],
      ),
    );
  }
}
