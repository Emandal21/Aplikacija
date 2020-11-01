import 'package:admob_flutter/admob_flutter.dart';
import 'package:aplikacija/components/left_part.dart';
import 'package:aplikacija/components/search.dart';
import 'package:aplikacija/pages/subc_details_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:aplikacija/localization/demo_localization.dart';
import 'package:aplikacija/components/drawer_menu.dart';


class SubcategoriesGrid extends StatefulWidget {

  final category;

  SubcategoriesGrid({
    this.category,
  });

  @override
  _SubcategoriesGridState createState() => _SubcategoriesGridState();
}

class _SubcategoriesGridState extends State<SubcategoriesGrid> with WidgetsBindingObserver{
  GlobalKey<ScaffoldState> _scaffoldKey2 = GlobalKey<ScaffoldState>();

  // reklame kad se aplikaicja vrati iz backgrounda
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
                                child: Center(child: Text(widget.category, textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white, fontSize: 30) ),),
                                decoration: BoxDecoration(borderRadius:BorderRadius.circular(20), color: Color(0xff002c3e))
                              )),
                          Expanded(
                              child: StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance.collection(widget.category).snapshots(),
                                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> querySnapshot) {
                                    if (querySnapshot.hasError)
                                      return Text("Greska u bazi");
                                    if (querySnapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    }
                                    else {
                                      final dbDataList = querySnapshot.data.docs;
                                      return new CustomScrollView(
                                          primary: false,
                                          slivers: <Widget>[
                                            SliverPadding(
                                                padding: EdgeInsets.only(
                                                    top: 7.0, right: 5.0),
                                                sliver: SliverGrid(
                                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 3,
                                                        crossAxisSpacing: 10,
                                                        mainAxisSpacing: 10),
                                                    delegate: SliverChildBuilderDelegate((
                                                        BuildContext context,
                                                        int index) {
                                                      return Subcategory(
                                                          subc_color: dbDataList[index]['color'] as String,
                                                          subc_name: dbDataList[index]['name'] as String,
                                                          subc_body: dbDataList[index]['body'] as String
                                                      );
                                                    },
                                                      childCount: dbDataList.length,
                                                    )))
                                          ]
                                      );
                                    }
                                  })
                          )
                        ]
              ))
            )]),

    );
  }
}

class Subcategory extends StatelessWidget {
  final subc_name;
  final subc_color;
  final subc_body;

  Subcategory({
    this.subc_color,
    this.subc_name,
    this.subc_body,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: (){
      Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new SubcategoryDetails(subcategory: subc_name, textBody: subc_body,)));
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