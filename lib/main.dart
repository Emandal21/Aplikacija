import 'package:aplikacija/components/drawer_menu.dart';
import 'package:aplikacija/localization/demo_localization.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:aplikacija/components/left_part.dart';
import 'package:aplikacija/components/admob_advertising.dart';
import 'package:admob_flutter/admob_flutter.dart';

import 'components/search.dart';

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

class _HomePageState extends State<HomePage> with WidgetsBindingObserver{
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> dbCategories = [];
  AdmobInterstitial interstAd; //reklama koja s epojavljuje kada se vrati aplikacija iz backgrounda

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) { //provjeravamo da li se aplikacija vratila iz backgrounda
    if (state == AppLifecycleState.resumed) {
      if (interstAd.isLoaded != null) {
        interstAd.show();
      }
    }
  }

  final ama = AdMobAdvert(); //instance of adMob Advert

    @override
  void initState() {
   // print('loadeeeed');
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Admob.initialize();//povezivanje na bazu
    interstAd = AdmobInterstitial(
      adUnitId: InterstitialAd.testAdUnitId,
    );
    interstAd.load();
    FirebaseFirestore.instance.collection("Kategorije").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        // print('petlja');
        // print(result['Content'] + result['Title']);
        dbCategories.add(result.toString());
        for (Map res in result.data().values) {
          // dbCategories.add(Category(res['color'], res['name'])); //color i name su kljucevi iz baze
          print(dbCategories.length);
        }
      });
    });
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
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
                child: LeftPart(dbCategories: dbCategories,),
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

