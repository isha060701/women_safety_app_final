import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Tip {
  String title;
  String imgUrl;
  String description;
  bool isExpanded;

  Tip({this.title, this.imgUrl, this.description, this.isExpanded: false});
}

List<Tip> getTips() {
  List<Tip> _tips = <Tip>[];
  Tip tip = new Tip();

  tip.title = "Push back & yell loudly";
  tip.imgUrl = "images/tip1.PNG";
  tip.description =
      "This the first thing you need to do as soon you realize that you are being stalked. If you sense trouble, act promptly. If attacked, push your assaulter aside and shout as loudly as you can. It might not dissuade them, but it will definitely make you seem like a difficult target. Also, it will rouse the attention of people around you and get help to you faster. ";
  _tips.add(tip);
  tip = new Tip();

  tip.title = "Use the heel of your palm to strike at the nose";
  tip.imgUrl = "images/tip2.PNG";
  tip.description =
      "When you're cornered in a deserted area, a swift blow to the nose will help you escape. If your attacker is charging towards you, hit their nose with the heel of your palm using all the strength you've got. This will cause immense pain and will temporarily disorient them, allowing you time to call for help or escape.";
  _tips.add(tip);
  tip = new Tip();

  tip.title = "Use everyday objects as weapons";
  tip.imgUrl = "images/tip3.PNG";
  tip.description =
      "You can fashion weapons out of anything around you. Like any other weapons, a set of keys wedged between your fingers like brass knuckles can deliver a crippling blow. If you are attacked at home, run to the kitchen and grab anything like a rolling pin, heavy ladle or a knife. Just remember to be quick!";
  _tips.add(tip);
  tip = new Tip();

  tip.title = " Get out of a wrist-hold";
  tip.imgUrl = "images/tip4.PNG";
  tip.description =
      "If your attacker has you in a wrist-hold, here's an easy way to break free. Instead of struggling, squat down, lean forward and then bend your elbows all the way towards their arm, till they can no longer hold on. Or simply rotate your wrist to the point where their finger and thumb meet and yank your wrist free. Their grip will be the weakest at that point and a sharp tug will help you escape quickly.";
  _tips.add(tip);
  tip = new Tip();

  tip.title = "Keep a bag of essentials in your car";
  tip.imgUrl = "images/tip5.PNG";
  tip.description =
      "A car survival kit can be your best friend when you're driving long distances. Keep items like first aid kit, jumper cables, flashlight, a fully-charged power bank, matchbox, a thick rope etc. in your kit and you'll always be prepared to face any situation on the road.";
  _tips.add(tip);
  tip = new Tip();

  tip.title = "Hit them with your elbows";
  tip.imgUrl = "images/tip6.PNG";
  tip.description =
      "If the attacker is trying to pin your arms down, this can be a useful strike to incapacitate them with. So yank your arms free of their grapple and hit their head with your elbows as hard as you can. With enough force to the temple, you elbows can potentially cause severe bruising and unconsciousness, crippling your attacker for several minutes.";
  _tips.add(tip);
  tip = new Tip();

  tip.title = "Use pepper Spray";
  tip.imgUrl = "images/tip7.PNG";
  tip.description =
      "Nothing works more effectively than pepper spray to the face. Some formulations are powerful enough to cause tearing, irritation and even temporary blindness when sprayed directly into the eyes. This trick works best when your attacker is charging towards you. Keep a can of pepper spray in your purse and in the glove compartment of your car for emergencies.";
  _tips.add(tip);
  tip = new Tip();

  tip.title = "Phone for help when your car breaks down";
  tip.imgUrl = "images/tip8.PNG";
  tip.description =
      "A car breaking down in the middle of nowhere is the textbook example of a difficult situation, but with a little bit of common sense you can easily find a safe way out of the problem. When your car breaks down and you cannot figure it out on your own, simply get back inside, leave your headlights on, lock the doors, stay in & phone for help. Do not step out of the car till proper help has arrived. ";
  _tips.add(tip);
  tip = new Tip();

  return _tips;
}

const kPrimaryColor = Colors.lightBlueAccent;

const kTextColor = Color(0xFF000000);

const kTextStyle = TextStyle(
  color: kTextColor,
  fontSize: 16,
);

const kBoldText = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);

class Constants {
  static SharedPreferences prefs;
}

class SelfDefenceTips extends StatefulWidget {
  static const String id = "SelfDefenceTips";
  @override
  _SelfDefenceTipsState createState() => _SelfDefenceTipsState();
}

class _SelfDefenceTipsState extends State<SelfDefenceTips> {
  List<Tip> _tips;
  final _auth = FirebaseAuth.instance;

  ExpansionPanel _createTip(Tip tip) {
    return new ExpansionPanel(
        headerBuilder: (context, bool isExpanded) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, top: 8.0, left: 8.0, bottom: 8.0),
                  child: Image.asset(
                    tip.imgUrl,
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height / 10.5,
                    width: MediaQuery.of(context).size.width / 3.5,
                  ),
                ),
                Flexible(
                    child: Text(
                  tip.title,
                  style: kBoldText,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ))
              ],
            ),
          );
        },
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
          ),
          child: Column(
            children: [
              Image.asset(
                tip.imgUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              Text(tip.description,
                  textAlign: TextAlign.justify, style: kTextStyle),
            ],
          ),
        ),
        isExpanded: tip.isExpanded);
  }

  @override
  void initState() {
    _tips = getTips();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  _auth.signOut();
                  //Navigator.pop(context);
                  // Navigator.of(context)
                  //   ..pop()
                  //   ..pop();
                  int count = 3;
                  Navigator.of(context).popUntil((_) => count-- <= 0);
                }),
          ],
          title: Text("Self Defence Tips"),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 8),
          children: [
            ExpansionPanelList(
              expandedHeaderPadding: EdgeInsets.zero,
              elevation: 0,
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  _tips[index].isExpanded = !_tips[index].isExpanded;
                });
              },
              children: _tips.map(_createTip).toList(),
            ),
          ],
        ));
  }
}
