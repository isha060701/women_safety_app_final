import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:women_safety_app/Dashboard.dart';
import 'package:women_safety_app/Emergency_Numbers.dart';

import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:geolocator/geolocator.dart';

class Alert extends StatefulWidget {
  static const String id = 'alert';

  @override
  _AlertState createState() => _AlertState();
}

class _AlertState extends State<Alert> {
  int flag = 0;
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  User loggedInUser;
  final player = AudioPlayer();

  String sirenAudioPath = 'sound/siren.mp4';

  String name;
  String name_emergency;
  String email_emergency;
  String phone_emergency;
  String phone;
  bool isPlaying;
  double lat, lon;

  @override
  void initState() {
    super.initState();
    isPlaying = false;
    getCurrentUser();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
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

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('An error has occured'),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'))
          ],
        ),
      );
      return;
    }
  }

  void getInfo() async {
    final users = await _firestore.collection('users').get();
    for (var user in users.docs) {
      final e = user.data()['email'];
      if (e == loggedInUser.email) {
        name = user.data()['name'];
        phone = user.data()['phone'];
        name_emergency = user.data()['e_name'];
        email_emergency = user.data()['e_email'];
        phone_emergency = user.data()['e_phone'];
      }
    }
  }

  send_mail() async {
    final MailOptions mailOptions = MailOptions(
      body:
          "I am in danger, please help me! Latitude value: $lat and longitude value: $lon",
      subject: 'Urgent',
      recipients: [email_emergency],
      isHTML: true,
    );

    final MailerResponse response = await FlutterMailer.send(mailOptions);
  }

  void _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
    print(_result);
    await send_mail();
  }

  playLocal() {
    AudioCache audioCache = AudioCache(prefix: 'sound/', fixedPlayer: player);
    setState(() {
      isPlaying = true;
    });
    audioCache.play('siren.mp4');
    // player.play('sound/siren.mp4', isLocal: true);
  }

  stopAudio() {
    setState(() {
      isPlaying = false;
    });
    if (player != null) {
      player.stop(); //audio stop
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                int count = 3;
                Navigator.of(context).popUntil((_) => count-- <= 0);
              }),
        ],
        title: Text('Options'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            _myScreenOptions(),
            // _playButton(),
          ],
        ),
      ),
    );
  }

  _myScreenOptions() {
    return Column(
      children: <Widget>[
        buildRow([
          buildOption(
              Color(0x6294C0), Icons.person, "Alert Emergency Contact", 1),
          buildOption(Color(0xDCE14F), Icons.alarm_on, "Play Siren", 2),
        ]),
        buildRow([
          buildOption(Color(0x32a852), Icons.location_searching,
              "Search Nearby safe locations", 3),
          buildOption(
              Color(0xffffff), Icons.local_police, "Call for emergency", 4),
        ])
      ],
    );
  }

  Widget buildOption(Color bgColor, IconData iconData, String title, int f) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: bgColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  getInfo();
                  if (f == 1) {
                    _determinePosition().then((value) {
                      print(value.latitude);
                      print(value.longitude);
                      lat = value.latitude;
                      lon = value.longitude;
                      print(lat);
                      print(lon);
                    }); // This will print lat and lng values you can store it wherever you want
                    //send_mail();
                    //Position position = _determinePosition() as Position;
                    String message =
                        "I am in danger, please help me! Latitude value: $lat and longitude value: $lon";
                    List<String> recipents = [phone_emergency];

                    _sendSMS(message, recipents);
                  }
                  if (f == 2) {
                    !isPlaying ? playLocal() : stopAudio();
                    // if (flag == 0) {
                    //   //player.play(sirenAudioPath);
                    //   playLocal();
                    // }
                    // if (flag == 1) {
                    //   //player.fixedPlayer.stop();
                    //   stopAudio();
                    // }
                  }
                  if (f == 3) {
                    Navigator.pushNamed(context, Home.id);
                  }
                  if (f == 4) {
                    Navigator.pushNamed(context, Emergency.id);
                  }
                },
                icon: Icon(
                  iconData,
                  color: Colors.black,
                ),
                iconSize: 80.0,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              )
            ],
          ),
        ),
      ),
    );
  }

  buildRow(List<Widget> buttons) {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: buttons,
      ),
    );
  }
}
