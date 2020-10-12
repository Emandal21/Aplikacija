import 'dart:io';
import 'package:firebase_admob/firebase_admob.dart';

class AdMobAdvert {
  String getAdMobAppId(){
    if(Platform.isIOS) {
      return 'ca-app-pub-7485800864788632~4893345866';
    } else if(Platform.isAndroid){
    return 'ca-app-pub-7485800864788632~8878684724';
    }
    return null;
  }

  String getBannerAdId(){
    if(Platform.isIOS) {
      return 'ca-app-pub-7485800864788632/1683555131';
    } else if(Platform.isAndroid){
      return 'ca-app-pub-7485800864788632/1351548493';
    }
    return null;
  }

}