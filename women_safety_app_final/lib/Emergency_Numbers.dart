import 'package:flutter/material.dart';
import 'package:women_safety_app/Emergencies/AmbulanceEmergency.dart';
import 'package:women_safety_app/Emergencies/ArmyEmergency.dart';
import 'package:women_safety_app/Emergencies/FirebrigadeEmergency.dart';
import 'package:women_safety_app/Emergencies/PoliceEmergency.dart';

class Emergency extends StatelessWidget {
  const Emergency({Key key}) : super(key: key);

  static const String id = 'EmergencyNumbers';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      height: 180,
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: [
          PoliceEmergency(),
          SizedBox(
            height: 40.0,
          ),
          AmbulanceEmergency(),
          SizedBox(
            height: 40.0,
          ),
          FireEmergency(),
          SizedBox(
            height: 40.0,
          ),
          ArmyEmergency()
        ],
      ),
    );
  }
}