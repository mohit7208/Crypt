import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './crypt.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


void main() async { 
  List currencies=await getCurrencies();
  print(currencies);
  runApp(MyApp(currencies));
}


class MyApp extends StatelessWidget {
  final List _currencies;
  MyApp(this._currencies);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  home: Crypt(_currencies),
  theme: ThemeData(
    primarySwatch: Colors.blue,
    primaryColor: defaultTargetPlatform==TargetPlatform.iOS?Colors.grey[100]:null
  ),
  debugShowCheckedModeBanner: false,
);
  }
}
Future<List> getCurrencies() async {
    String url='https://api.coinmarketcap.com/v1/ticker/?limit=50';
    http.Response response=await http.get(url);
    return json.decode(response.body);

  }

