import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:aplikacija/localization/demo_localization.dart';
import 'dart:async';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final String url='https://www.brutto-netto-rechner.info/';

  Future<String> getData() async{
    var response = await http.get(
      //Encode url
      Uri.encodeFull(url),

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffe1e1e1),
    appBar: new AppBar(
    backgroundColor: Colors.greenAccent,
    title: Text(DemoLocalization.of(context).getTranslatedValue('homePageTitle')),
    actions: <Widget>[
    new IconButton(icon: Icon(Icons.search, color: Colors.white,), onPressed: (){})
    ]
    ),
      body: Text(''),
    );
  }
}
