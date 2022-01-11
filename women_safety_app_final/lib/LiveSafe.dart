import 'package:flutter/material.dart';
import 'package:women_safety_app/LiveSafeSpots/BusStationCard.dart';
import 'package:women_safety_app/LiveSafeSpots/HospitalCard.dart';
import 'package:women_safety_app/LiveSafeSpots/PharmacyCard.dart';
import 'package:women_safety_app/LiveSafeSpots/PoliceStationCard.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LiveSafe extends StatelessWidget {
  const LiveSafe({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 700,
        width: MediaQuery.of(context).size.width,
        child: ListView(
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            children: [
              SizedBox(
                height: 70.0,
              ),
              PoliceStationCard(openMapFunc: openMap),
              SizedBox(
                height: 40.0,
              ),
              HospitalCard(openMapFunc: openMap),
              SizedBox(
                height: 40.0,
              ),
              PharmacyCard(openMapFunc: openMap),
              SizedBox(
                height: 40.0,
              ),
              BusStationCard(openMapFunc: openMap)
            ]),
      ),
    );
  }

  static Future<void> openMap(String location) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$location';

    try {
      await launch(googleUrl);
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
          msg: "Something went wrong! Call emergency numbers.");
    }
  }
}
