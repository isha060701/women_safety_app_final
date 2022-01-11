import 'package:flutter/material.dart';
//import 'package:geolocator/geolocator.dart';
//import 'package:safety_app/services/authservice.dart';
//import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:women_safety_app/alert.dart';
import 'package:women_safety_app/tips.dart';

//import 'package:flutter/services.dart';
//import 'package:sms/sms.dart';
//import './contacts.dart';
//import '../models/contactModel.dart';
//import '../services/storage.dart';

class DashboardPage extends StatefulWidget {
  static const String id = 'emergency_screen';
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/back.jpg'), fit: BoxFit.cover)),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          colors: [
                            Colors.black.withOpacity(.9),
                            Colors.black.withOpacity(.4)
                          ])),
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 50),
                          SafeArea(
                            child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, Alert.id);
                                },
                                child: Container(
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage('images/button.jpg'),
                                          fit: BoxFit.cover),
                                      border:
                                      Border.all(color: Colors.white, width: 5),
                                      borderRadius: BorderRadius.circular(200),
                                      color: Colors.red),
                                  child: Center(
                                    child: Container(
                                      child: Text("SOS",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 50,
                                          )),
                                    ),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/back.jpg'), fit: BoxFit.cover)),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          colors: [
                            Colors.black.withOpacity(.9),
                            Colors.black.withOpacity(.4)
                          ])),
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 50),
                          SafeArea(
                            child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, SelfDefenceTips.id);
                                },
                                child: Container(
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage('images/button.jpg'),
                                          fit: BoxFit.cover),
                                      border:
                                      Border.all(color: Colors.white, width: 5),
                                      borderRadius: BorderRadius.circular(200),
                                      color: Colors.red),
                                  child: Center(
                                    child: Container(
                                      child: Text(
                                        "Learn safety techniques",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}