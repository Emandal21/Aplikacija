import 'dart:core';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:aplikacija/components/left_part.dart';
import 'package:aplikacija/components/search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aplikacija/localization/demo_localization.dart';
import 'package:aplikacija/components/drawer_menu.dart';


class DBListPage extends StatefulWidget {

  @override
  _DBListPageState createState() => _DBListPageState();
}

class _DBListPageState extends State<DBListPage> with WidgetsBindingObserver{
  GlobalKey<ScaffoldState> _scaffoldKey3 = GlobalKey<ScaffoldState>();
  AdmobInterstitial interstAd;
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) { //provjeravamo da li se aplikacija vratila iz backgrounda
    if (state == AppLifecycleState.resumed) {
      if (interstAd.isLoaded != null) {
        interstAd.show();
      }
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    Admob.initialize();//povezivanje na bazu
    interstAd = AdmobInterstitial(
      adUnitId: InterstitialAd.testAdUnitId,
    );
    interstAd.load();
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:_scaffoldKey3,
      backgroundColor: Color(0xfff7f8f3),
      appBar: new AppBar(
          backgroundColor: Color(0xff002c3e),
          title: Text(DemoLocalization.of(context).getTranslatedValue('homePageTitle')),
          centerTitle: true,
          leading: IconButton(
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/10),
            icon: Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey3.currentState.openDrawer();
            },
          ),
          actions: <Widget>[
            new IconButton(icon: Icon(Icons.search, color: Colors.white,), onPressed: (){
              showSearch(context: context, delegate: DataSearch());
            })
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
                                  child: Center(child: Text("Baza test", textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white, fontSize: 30) ),),
                                  decoration: BoxDecoration(borderRadius:BorderRadius.circular(20), color: Color(0xff002c3e))
                              )),
                          Expanded(
                                  child: StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance.collection("Oglasi").snapshots(), //povezivanje na kolekciju iz baze
                                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> querySnapshot){
                                      if(querySnapshot.hasError)
                                        return Text("Greska u bazi");
                                      if(querySnapshot.connectionState == ConnectionState.waiting) {
                                        return CircularProgressIndicator();
                                      }
                                      else {
                                        final dbDataList = querySnapshot.data.docs;
                                        return ListView.builder(
                                          itemCount: dbDataList.length,
                                          itemBuilder: (context, i) {
                                            return new ExpansionTile(
                                              title: new Text(dbDataList[i]["Title"], style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),
                                              children: <Widget>[
                                                new Text((dbDataList[i]["Content"]), style: new TextStyle(fontSize: 18.0,),),
                                              ],
                                            );
                                            },);
                                      }
                                    }
                                  )
                              // child: widget.dbData.length == 0 ?  new Text('Nema podataka u bazi'): //u slucaju da je baza prazna
                              // ListView.builder(
                              //   itemCount: widget.dbData.length,
                              //   itemBuilder: (context, i) {
                              //     return new ExpansionTile(
                              //       title: new Text(widget.dbData[i].title, style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),
                              //       children: <Widget>[
                              //         new Text((widget.dbData[i].content), style: new TextStyle(fontSize: 18.0,),),
                              //       ],
                              //     );
                              //   },
                              // ),
                          )
                        ]
                    ))
            )]),

    );
  }
}

class Oglas {
  String title;
  String content;
  //konstruktor
  Oglas(this.title, this.content);
}
