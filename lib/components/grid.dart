import 'package:aplikacija/pages/subc_details_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/services.dart';
import 'package:aplikacija/localization/demo_localization.dart';
import 'dart:io';

class Grid extends StatefulWidget {
  final gridList;
  final listLength;

  Grid({
  this.gridList,
  this.listLength});

  @override
  _GridState createState() => _GridState();
}

class _GridState extends State<Grid> {

  @override
  Widget build(BuildContext context) {
    //loadJson();
   // print("main");

    // return GridView.builder(
    //   padding: EdgeInsets.only(top: 7.0, right: 5.0),
    //     itemCount: widget.listLength,
    //     gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
    //     itemBuilder: (BuildContext context, int index) {
    //       return Subcategory(
    //           subc_color: widget.gridList[index]['color'] as String,
    //           subc_name: widget.gridList[index]['name'] as String
    //       );
    //     });
    return CustomScrollView(
        primary: false,
        slivers: <Widget>[
          SliverPadding(
          padding: EdgeInsets.only(top: 7.0, right: 5.0),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
            delegate: SliverChildBuilderDelegate((BuildContext context, int index){
                return Subcategory(
                subc_color: widget.gridList[index]['color'] as String,
                subc_name: widget.gridList[index]['name'] as String
                );
                },
            childCount: widget.listLength,
        )))]);

  }
}



class Subcategory extends StatelessWidget {
  final subc_name;
  final subc_color;

  Subcategory({
    this.subc_color,
    this.subc_name,
  });

  static String _jsonString;
  static Map _decoded;

  Future<String> _loadJson(subCategory) async {
    return await rootBundle.loadString('lib/subcategoriesDetails/$subCategory.json');
  }

  Future loadJson(subCategory) async {
    _jsonString = await _loadJson(subCategory);
    print("load");
    _parseJson(_jsonString);
  }
  void _parseJson(String jsonString) {
    _decoded = jsonDecode(jsonString);
    print(_decoded);
  }

  factory Subcategory.fromJson(Map<String, dynamic> json) {
    return new Subcategory(
      subc_color: json['color'] as String,
      subc_name: json['name'] as String,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: (){
      loadJson(subc_name);
      Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new SubcategoryDetails(subcategory: subc_name, textBody: _decoded,)));
    },
        child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(int.parse(subc_color.substring(1, 7), radix: 16) + 0xFF000000)),
          child: Align(
            alignment: Alignment.center, // Align however you like (i.e .centerRight, centerLeft)
            child: Container(
              padding: EdgeInsets.only(left: 10.0, right:10.0),
              child: Text(subc_name, style: TextStyle(color: Color(0xff002c3e), fontSize: 12,),textAlign: TextAlign.center,),
            )
          ),
        ));
  }
}
