import 'package:flutter/material.dart';
import 'package:women_safety_app/Dashboard.dart';
import 'package:women_safety_app/Emergency_Numbers.dart';
import 'package:women_safety_app/welcome_screen.dart';
import 'package:women_safety_app/login.dart';
import 'package:women_safety_app/registration.dart';
import 'package:women_safety_app/emergency.dart';
import 'package:women_safety_app/alert.dart';
import 'package:women_safety_app/tips.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'firebase_options.dart';

//void main() => runApp(women_safety_app());
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(women_safety_app());
}

class women_safety_app extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        //About.id: (context) => About(),
        Home.id: (context) => Home(),
        Emergency.id: (context) => Emergency(),
        DashboardPage.id: (context) => DashboardPage(),
        Alert.id: (context) => Alert(),
        SelfDefenceTips.id: (context) => SelfDefenceTips(),
        //Record.id: (context) => Record(),
      },
    );
  }
}
