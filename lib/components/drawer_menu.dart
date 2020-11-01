import 'package:aplikacija/main.dart';
import 'package:aplikacija/pages/baza.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:aplikacija/localization/demo_localization.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class AppDrawer extends StatelessWidget {
 // List<Oglas> dbData;
 // final firestoreInstance = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    Widget _createHeader() {
      return Container(padding: EdgeInsets.only(top: 50, left: 8, right: 8, bottom: 8),
          color: Color(0xff002c3e),
          child:Row(children: <Widget>[
            SizedBox(width: 8,),
          RichText(text: TextSpan(children: [
          TextSpan(text: DemoLocalization.of(context).getTranslatedValue('homePageTitle'), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20.0)),
      ]),),
      ],),
      );
    }

    // retrievanje podataka iz baze
    // void loadDbData() {
    //   firestoreInstance.collection("Oglasi").get().then((querySnapshot) => {
    //     querySnapshot.docs.forEach((result) {
    //       print('petlja');
    //       print(result['Content'] + result['Title']);
    //       dbData.add(Oglas(result['Title'], result['Content'])); //title i content su kljucevi iz baze
    //       print(dbData.length);
    //     })
    //   });
    // }


    _launchURL() async {
      const url = 'https://www.brutto-netto-rechner.info/';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Drawer(
      child: ListView(
        children: <Widget>[
          _createHeader(),
          InkWell(onTap: (){
            Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new HomePage()));
          },
              child: Container(
                width: 110.0,
                child: ListTile(
                    leading: Icon(Icons.home, color: Color(0xff002c3e)),
                    title: Container(
                      child: Text("Početna"),
                    )
                ),
              )
          ),
        InkWell(onTap: (){
          _launchURL();
        },
            child: Container(
              width: 110.0,
              child: ListTile(
                  leading: Icon(Icons.compare_arrows, color: Color(0xff002c3e)),
                  title: Container(
                    child: Text("Bruto-Neto kalkulator"),
                  )
              ),
            )
        ),
          InkWell(onTap: (){
           // loadDbData();
            Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new DBListPage()));
          },
              child: Container(
                width: 110.0,
                child: ListTile(
                    leading: Icon(Icons.list, color: Color(0xff002c3e)),
                    title: Container(
                      child: Text("Baza"),
                    )
                ),
              )
          ),
        ],
      ),
    );
  }
}