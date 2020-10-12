import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';


class AdPart extends StatefulWidget {
  @override
  _AdPartState createState() => _AdPartState();
}

class _AdPartState extends State<AdPart> {

  static final MobileAdTargetingInfo targetInfo = new MobileAdTargetingInfo(
    testDevices:<String> [], // it will take emulator as test device
    keywords: <String> ['app', 'aplikacija', 'amuled'],
  ); //information about our advertisement

  BannerAd _bannerAd;

  BannerAd createBannerAd(){
    return new BannerAd(
        adUnitId: BannerAd.testAdUnitId,
        size: AdSize.fullBanner,
        targetingInfo: targetInfo,
        listener: (MobileAdEvent event){
          print('Banner event: $event');
        }
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    _bannerAd = createBannerAd() ..load() ..show();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
