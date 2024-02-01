// ignore_for_file: depend_on_referenced_packages, unused_import, library_private_types_in_public_api, use_key_in_widget_constructors, non_constant_identifier_names, prefer_const_constructors, avoid_unnecessary_containers

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
    //Clear_Pref();
  }

Future<void> Clear_Pref() async {

}

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () => wayToGo());
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        body:  SingleChildScrollView(
          child:Container(
            alignment: Alignment.center,
            child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //vertically align center
                children:<Widget>[
                  SizedBox(
                    height:200,width:200,
                  ),
                  SizedBox(
                    height:200,width:200,
                    child:Image.asset("assets/img/logo.png"),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30.0),
                    child: Shimmer.fromColors(
                      baseColor: Colors.brown,
                      highlightColor: Colors.brown,
                      child: Container(
                        child: const Text(
                          "Future University Admission App",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontFamily: 'Neuton'),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin:const EdgeInsets.only(top:15),
                    child:const Text("Version: 1.0", style:TextStyle(
                      color:Colors.grey,
                      fontSize: 14,
                    )),
                  ),
                  Container(
                    //padding: EdgeInsets.symmetric(vertical: 300.0, horizontal: 5.0),
                    margin: const EdgeInsets.only(top: 200.0),
                    child: const Text(
                      "",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  )
                ]
            ),
          ),
        )
    );
  }

  void wayToGo() {

    _navigatTtoMainInfo();

  }

  void _navigatTtoMainInfo() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ));
    });
  }


}
