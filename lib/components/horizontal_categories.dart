import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Category(
            image_location: new Icon(Icons.home, size: 30.0, color: Colors.white),
            image_caption: 'Stanovanje',
          ),
          Category(
            image_location: new Icon(Icons.euro_symbol, size: 30.0, color: Colors.white),
            image_caption: 'Finansije i Porez',
          ),
          Category(
            image_location: new Icon(Icons.work, size: 30.0, color: Colors.white),
            image_caption: 'Posao',
          ),
          Category(
            image_location: new Icon(Icons.child_friendly, size: 30.0, color: Colors.white),
            image_caption: 'Obitelj',
          ),
          Category(
            image_location: new Icon(Icons.book, size: 30.0, color: Colors.white),
            image_caption: 'Studiranje',
          ),
          Category(
            image_location: new Icon(Icons.directions_car, size: 30.0, color: Colors.white),
            image_caption: 'Motorna vozila',
          ),
          Category(
            image_location: new Icon(Icons.account_balance, size: 30.0, color: Colors.white),
            image_caption: 'Osiguranje',
          ),
          Category(
            image_location: new Icon(Icons.local_bar, size: 30.0, color: Colors.white),
            image_caption: 'Društveni život',
          ),
          Category(
            image_location: new Icon(Icons.people, size: 30.0, color: Colors.white),
            image_caption: 'Nasi Ljudi',
          ),
          Category(
            image_location: new Icon(Icons.library_books, size: 30.0, color: Colors.white),
            image_caption: 'Uredi za građane i strance',
          ),
          Category(
            image_location: new Icon(Icons.language, size: 30.0, color: Colors.white),
            image_caption: 'Jezici',
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
    return Padding(padding: const EdgeInsets.all(2.0),
    child: InkWell(onTap: (){},
    child: Container(
      width: 110.0,
      child: ListTile(
        title: new CircleAvatar( // da bi se ikonice prikazivale u krugovima
          backgroundColor: Colors.greenAccent,
          child: image_location,
          radius: 30.0,
        ),
        subtitle: Container(
          alignment: Alignment.topCenter,
          child: Text(image_caption, textAlign: TextAlign.center),
        )
      ),
    )
    ));
  }
}
