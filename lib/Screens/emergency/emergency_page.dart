import 'dart:io';

import 'package:fearless/Screens/home/home_page.dart';
import 'package:fearless/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class Emergency extends StatefulWidget {

  @override
  State<Emergency> createState() => _EmergencyState();
}

class _EmergencyState extends State<Emergency> with SingleTickerProviderStateMixin {
  double? latitude;

  double? longitude;

  String? address;

  Color? backGroundColor;

  AnimationController? _controller;
  Animation<Color>? animation;

  int ringtone = 0;

  final colors = <TweenSequenceItem<Color>>[
    TweenSequenceItem(
      weight: 1.0,
      tween: Tween(begin: Colors.red, end: Colors.white),
    ),
  ];
  final normal = <TweenSequenceItem<Color>>[
    TweenSequenceItem(
      weight: 1.0,
      tween: Tween(begin: Colors.white, end: Colors.white),
    ),
  ];

  _backGroundChange(){
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    animation = TweenSequence<Color>(colors).animate(_controller!)..addListener(() {
      setState(() {});
    });
  }
  _backGroundChangeToNormal(){
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    animation = TweenSequence<Color>(normal).animate(_controller!)..addListener(() {
      setState(() {});
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;


    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {

      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> getAddressFromLatLang(Position position) async{
    List<Placemark?> placemark = await placemarkFromCoordinates(latitude!, longitude!);
    Placemark? place = placemark[0];
    setState(() {
      address =
      '${place!.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode},${place.country}';
    });
  }

  _asyncMethod() async {
    try{
      final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Position position = await _determinePosition();
        latitude = position.latitude;
        longitude = position.longitude;
        Future.delayed(const Duration(milliseconds: 500), () {
          getAddressFromLatLang(position);
        });
      }
    }on SocketException catch (_) {
      Fluttertoast.showToast(
          msg: 'No Internet Connection, Please check your Internet',
        timeInSecForIosWeb: 1
      );
    }


  }

  @override
  void initState() {
    _asyncMethod();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation == null ? Colors.white : animation!.value,
      appBar: AppBar(
        titleSpacing: 0,
        title: Text('Emergency', style: TextStyle(
          color: Colors.white
        ),),
        backgroundColor: kPrimaryColor,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text('Tap to Call', style: TextStyle(
                  fontSize: 40, color:  animation == null ? Colors.red : Colors.black, fontWeight: FontWeight.bold
              ),),
              SizedBox(height: 20,),
              InkWell(
                onTap: () async {
                  // Get.to(HomePage());
                  // final Uri launchUri = Uri(
                  //   scheme: 'tel',
                  //   path: '999',
                  // );
                  // launchUrl(launchUri);
                  var url = '999';
                  launchUrl(Uri(path: url, scheme: 'tel'));
                  // await _launchURL('999');
                },
                child: Text('999', style: TextStyle(
                    fontSize: 100, color: animation == null ? Colors.red : Colors.black, fontWeight: FontWeight.bold
                ),),
              ),
              // TextButton(
              //   onPressed: () {
              //
              //   },
              //   child:
              // ),
              SizedBox(height: 70,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    ringtone == 0 ?
                    Expanded(
                      child: InkWell(
                        splashFactory: InkRipple.splashFactory,
                        onTap: (){
                          setState(() {
                            ringtone = 1;
                          });

                          FlutterRingtonePlayer.play(
                            fromAsset: 'assets/danger.wav',
                            // android: AndroidSounds.ringtone,
                            ios: IosSounds.alarm,
                            looping: true,
                            volume: 1.0,
                              asAlarm: true
                          );
                          // _backGroundChange();
                        },
                        child: Card(
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: kPrimaryColor
                            ),
                           child: Center(
                             child: Text('Alarm',style: TextStyle(
                               color: Colors.white, fontSize: 20
                             ),),
                           )
                          ),
                        ),
                      ),
                    ) : Expanded(
                      child: InkWell(
                        splashFactory: InkRipple.splashFactory,
                        onTap: (){
                          setState(() {
                            ringtone = 0;
                          });

                          FlutterRingtonePlayer.stop();
                          // _backGroundChangeToNormal();
                        },
                        child: Card(
                          child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: kPrimaryColor
                              ),
                              child: Center(
                                child: Text('Alarm off',style: TextStyle(
                                    color: Colors.white, fontSize: 20
                                ),),
                              )
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      child: InkWell(
                        splashFactory: InkRipple.splashFactory,
                        onTap: () async{

                          // latitude = position.latitude;
                          // longitude = position.longitude;

                          // print(position.latitude);
                          // print(position.longitude);
                          // print(address);
                          Share.share(
                              address!,
                              subject: 'Help Me'
                          );

                        },
                        child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: kPrimaryColor
                            ),
                            child: Center(
                              child: Text('Location Send',style: TextStyle(
                                  color: Colors.white, fontSize: 20
                              ),),
                            )
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Text('Current Location:',textAlign: TextAlign.center, style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold
              ),),
              SizedBox(height: 20,),
              Text('${address == null ? '' : address}',textAlign: TextAlign.center,style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color:  animation == null ? Colors.red : Colors.black
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
