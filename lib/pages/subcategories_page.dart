import 'package:aplikacija/components/grid.dart';
import 'package:aplikacija/components/left_part.dart';
import 'package:flutter/material.dart';
import 'package:aplikacija/localization/demo_localization.dart';
import 'package:aplikacija/components/drawer_menu.dart';


class SubcategoriesGrid extends StatefulWidget {

  final category;
  final gridList;
  final listLength;

  SubcategoriesGrid({
    this.category,
    this.gridList,
    this.listLength
  });

  @override
  _SubcategoriesGridState createState() => _SubcategoriesGridState();
}

class _SubcategoriesGridState extends State<SubcategoriesGrid> {
  GlobalKey<ScaffoldState> _scaffoldKey2 = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:_scaffoldKey2,
      backgroundColor: Color(0xfff7f8f3),
      appBar: new AppBar(
          backgroundColor: Color(0xff002c3e),
          title: Text(DemoLocalization.of(context).getTranslatedValue('homePageTitle')),
          centerTitle: true,
          leading: IconButton(
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/10),
            icon: Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey2.currentState.openDrawer();
            },
          ),
          actions: <Widget>[
            new IconButton(icon: Icon(Icons.search, color: Colors.white,), onPressed: (){})
          ]

      ),

      // menu na izvlacenje
      drawer: AppDrawer(),

      body: Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: LeftPart(),
            ) ,
            VerticalDivider(
              color: Color(0xffb4a796),
              thickness: 2.0,
            ),
            Expanded(
              flex: 8,
              child: Container(
                        child: Column(
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(top:5, right:5, bottom:5),
                               child:  Container(
                                height: MediaQuery.of(context).size.height / 4,
                                width: MediaQuery.of(context).size.width,
                                child: Center(child: Text(widget.category, textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white, fontSize: 30) ),),
                                decoration: BoxDecoration(borderRadius:BorderRadius.circular(20), color: Color(0xff002c3e))
                              )),
                          Expanded(
                              child: Grid(gridList: widget.gridList, listLength: widget.listLength,)
                          )
                        ]
              ))
            )]),

    );
  }
}
