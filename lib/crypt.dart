import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
//import 'dart:convert';
import './main.dart';
import 'package:flutter/foundation.dart';

class Crypt extends StatefulWidget {
  final List currencies;
  Crypt(this.currencies);

  @override
  _CryptState createState() => _CryptState();
}

class _CryptState extends State<Crypt> {
  List currencies;
  List<MaterialColor> _colors = [Colors.green,Colors.lime,Colors.orange,Colors.yellow,Colors.blue, Colors.indigo, Colors.red];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crypt'),
        elevation: defaultTargetPlatform==TargetPlatform.iOS?0.0: 5.0,
        backgroundColor: Colors.blue,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getCurrencies,
        child: Icon(Icons.refresh),
      ),
      body: _cryptoWidget(),
    );
  }

  Widget _cryptoWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              itemCount: widget.currencies.length,
              itemBuilder: (BuildContext context, int index) {
                final Map currency = widget.currencies[index];
                final MaterialColor color = _colors[index % _colors.length];

                return _getListItemUI(currency, color);
              },
            ),
          ),
        ],
      ),
    );
  }

  ListTile _getListItemUI(Map currency, MaterialColor color) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color,
        child: Text(currency['name'][0]),
      ),
      title: Text(
        currency['name'],
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: _getSubtitleText(
          currency['price_usd'], currency['percent_change_1h']),
      isThreeLine: true,
    );
  }

  Widget _getSubtitleText(String priceUSD, String percentageChange) {
    TextSpan priceTextWidget = new TextSpan(
      text: ' \$$priceUSD\n',
      style: TextStyle(color: Colors.black),
    );
    String percentageChangeText = "1 hour: $percentageChange%";
    TextSpan percentageChangeWidgetText;
    if (double.parse(percentageChange) > 0) {
      percentageChangeWidgetText = new TextSpan(
        text: percentageChangeText,
        style: TextStyle(color: Colors.green),
      );
    } else {
      percentageChangeWidgetText = new TextSpan(
        text: percentageChangeText,
        style: TextStyle(color: Colors.red),
      );
    }

    return RichText(
      text: TextSpan(children: [priceTextWidget, percentageChangeWidgetText]),
    );
  }
}
