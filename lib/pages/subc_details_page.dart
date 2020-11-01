import 'package:admob_flutter/admob_flutter.dart';
import 'package:aplikacija/components/left_part.dart';
import 'package:aplikacija/components/search.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:aplikacija/localization/demo_localization.dart';
import 'package:aplikacija/components/drawer_menu.dart';


class SubcategoryDetails extends StatefulWidget {

  final subcategory;
  final textBody;
  final int backPressCount;

  SubcategoryDetails({
    this.subcategory,
    this.textBody,
    this.backPressCount,
  });

  @override
  _SubcategoryDetailsState createState() => _SubcategoryDetailsState();
}

class  _SubcategoryDetailsState extends State< SubcategoryDetails> with WidgetsBindingObserver{
  GlobalKey<ScaffoldState> _scaffoldKey1 = GlobalKey<ScaffoldState>();

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
    return new WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
          key:_scaffoldKey1,
          backgroundColor: Color(0xfff7f8f3),
          appBar: new AppBar(
              backgroundColor: Color(0xff002c3e),
              title: Text(DemoLocalization.of(context).getTranslatedValue('homePageTitle')),
              centerTitle: true,
              leading: IconButton(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/10),
                icon: Icon(Icons.menu),
                onPressed: () {
                  _scaffoldKey1.currentState.openDrawer();
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
                                      child: Center(child: Text(widget.subcategory, textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.white, fontSize: 30) ),),
                                      decoration: BoxDecoration(borderRadius:BorderRadius.circular(20), color: Color(0xff002c3e))
                                  )),
                              Expanded(
                                  child: SingleChildScrollView(
                                    padding: EdgeInsets.only(top: 5.0, right: 7.0, left: 7.0, bottom: 5.0),
                                    child: Text(widget.textBody),
                                  )
                              )
                            ]
                        ))
                )]),

        ));
  }
  Future<bool> _onBackPressed () {
      if(widget.backPressCount < 3){

      }
  }
}
