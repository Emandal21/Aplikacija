import 'package:aplikacija/components/drawer_menu.dart';
import 'package:aplikacija/localization/demo_localization.dart';
import 'package:aplikacija/pages/baza.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:aplikacija/components/left_part.dart';
import 'package:aplikacija/components/ad_part.dart';
import 'package:aplikacija/components/admob_advertising.dart';
import 'package:admob_flutter/admob_flutter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      // lokalizacija
      supportedLocales: [
        Locale( 'bs' , 'BA' ),
        Locale( 'de' , 'DE' ),
      ],
      localizationsDelegates: [
        DemoLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocaleLanguage in supportedLocales) {
          if (supportedLocaleLanguage.languageCode == locale.languageCode &&
              supportedLocaleLanguage.countryCode == locale.countryCode) {
            return supportedLocaleLanguage;
          }
        }
        return supportedLocales.first;
      }, // kraj lokalizacije
      home: HomePage(),
    )
  );
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final ama = AdMobAdvert(); //instance of adMob Advert

    @override
  void initState() {
   // print('loadeeeed');
    super.initState();
    Admob.initialize();//povezivanje na bazu
  }


    @override
    Widget build(BuildContext context) {

      return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color(0xfff7f8f3),
        appBar: new AppBar(
          backgroundColor: Color(0xff002c3e),
          title: Text(DemoLocalization.of(context).getTranslatedValue('homePageTitle')),
            centerTitle: true,
            leading: IconButton(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/10),
              icon: Icon(Icons.menu),
              onPressed: () {
                _scaffoldKey.currentState.openDrawer();
              },
            ),
            actions: <Widget>[
            new IconButton(icon: Icon(Icons.search, color: Colors.white,),
                onPressed: (){
                  showSearch(context: context, delegate: appSearch());
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
            //child: AdPart(),
            child: AdmobBanner(
              adUnitId: BannerAd.testAdUnitId,
              adSize: AdmobBannerSize.MEDIUM_RECTANGLE,
            )
        ),
        ]),
      );


    }
  }

  class appSearch extends SearchDelegate<String>{
  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(
      icon: Icon(Icons.clear),
      onPressed: (){
        query = '';
      },
    ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: (){
        close(context, null);
    }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
  
  }
