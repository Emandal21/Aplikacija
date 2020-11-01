import 'package:aplikacija/pages/subcategories_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aplikacija/localization/demo_localization.dart';

class LeftPart extends StatelessWidget {
  final dbCategories;
  LeftPart({this.dbCategories});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(

        children: <Widget>[
          Category(
            image_location: new Icon(
                Icons.home, size: 19.0, color: Colors.white),
                image_caption: DemoLocalization.of(context).getTranslatedValue('cat_stanovanje'), //value od ovoga se nalazi u lang/bs.json
            //image_caption: dbCategories[0],
          ),
          Category(
            image_location: new Icon(
                  Icons.euro_symbol, size: 19.0, color: Colors.white),
            image_caption: DemoLocalization.of(context).getTranslatedValue('cat_finansije'),
          ),
          Category(
            image_location: new Icon(
                Icons.work, size: 19.0, color: Colors.white),
            image_caption: DemoLocalization.of(context).getTranslatedValue('cat_posao'),
          ),
          Category(
            image_location: new Icon(
                Icons.child_friendly, size: 19.0, color: Colors.white),
            image_caption: DemoLocalization.of(context).getTranslatedValue('cat_obitelj'),
          ),
          Category(
            image_location: new Icon(
                Icons.book, size: 19.0, color: Colors.white),
            image_caption: DemoLocalization.of(context).getTranslatedValue('cat_studiranje'),
          ),
          Category(
            image_location: new Icon(
                Icons.directions_car, size: 19.0, color: Colors.white),
            image_caption: DemoLocalization.of(context).getTranslatedValue('cat_vozila'),
          ),
          Category(
            image_location: new Icon(
                Icons.account_balance, size: 19.0, color: Colors.white),
            image_caption: DemoLocalization.of(context).getTranslatedValue('cat_osiguranje'),
          ),
          Category(
            image_location: new Icon(
                Icons.local_bar, size: 19.0, color: Colors.white),
            image_caption: DemoLocalization.of(context).getTranslatedValue('cat_drustvo'),
          ),
          Category(
            image_location: new Icon(
                Icons.people, size: 19.0, color: Colors.white),
            image_caption: DemoLocalization.of(context).getTranslatedValue('cat_ljudi'),
          ),
          Category(
            image_location: new Icon(
                Icons.library_books, size: 19.0, color: Colors.white),
            image_caption: DemoLocalization.of(context).getTranslatedValue('cat_uredi'),
          ),
          Category(
            image_location: new Icon(
                Icons.language, size: 19.0, color: Colors.white),
            image_caption: DemoLocalization.of(context).getTranslatedValue('cat_jezici'),
          ),
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  final Icon image_location;
  final String image_caption;

  Category({
    this.image_location,
    this.image_caption
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        child: InkWell(onTap: (){
          Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new SubcategoriesGrid(category: image_caption)));
        },


            child: Container(
              padding: EdgeInsets.only(top: 8.0),
              child: ListTile(
                  title: new CircleAvatar( // da bi se ikonice prikazivale u krugovima
                    backgroundColor: Color(0xff002c3e),
                    child: image_location,
                    radius: 19.0,
                  ),
                  subtitle: Container(
                    child: Text(image_caption, style: TextStyle(fontSize: 12.0, color:Color(0xff333558)), textAlign: TextAlign.center,),
                  )
              ),
            )
        ));
  }
}