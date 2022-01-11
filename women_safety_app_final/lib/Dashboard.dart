import 'dart:math';

import 'package:flutter/material.dart';
import 'package:women_safety_app/LiveSafe.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);
  static const String id = 'dash';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int quoteIndex = 0;
  @override
  void initState() {
    super.initState();
    getRandomInt(false);
  }

  getRandomInt(fromClick) {
    Random rnd = Random();

    quoteIndex = rnd.nextInt(4);
    if (mounted && fromClick) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 16.0, bottom: 10, top: 10),
                    child: Text(
                      "EXPLORE NEARBY EMERGENCY PLACES",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  LiveSafe(),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}