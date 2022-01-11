import 'package:flutter/material.dart';
import 'package:women_safety_app/rounded_button.dart';
import 'package:women_safety_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'emergency.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:email_validator/email_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  bool showSpinner = false;
  bool _isValid1 = true;
  bool _isValid2 = true;
  bool _isValid3 = true;
  bool _isValid4 = true;
  bool _isValid5 = true;
  String email;
  String password;
  String name;
  String name_emergency;
  String email_emergency;
  String phone_emergency;
  String phone;
  Color c = const Color(0xFFccffff);
  int f1 = 0;
  int f2 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: c,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                  setState(() {
                    _isValid1 = EmailValidator.validate(email);
                    f1 = _isValid1 ? 1 : 0;
                  });
                },
                decoration:
                kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
              ),
              Text(
                _isValid1 ? ' ' : ' Email is not valid.',
                style: TextStyle(color: Colors.red),
              ),
              SizedBox(
                height: 5.0,
              ),
              TextField(
                keyboardType: TextInputType.name,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  name = value;
                },
                decoration:
                kTextFieldDecoration.copyWith(hintText: 'Enter your name'),
              ),
              SizedBox(
                height: 17.0,
              ),
              TextField(
                keyboardType: TextInputType.phone,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  phone = value;
                  setState(() {
                    if (phone.length != 10)
                      _isValid3 = false;
                    else
                      _isValid3 = true;
                  });
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your phone number'),
              ),
              Text(
                _isValid3 ? ' ' : ' Phone number should be 10 digits.',
                style: TextStyle(color: Colors.red),
              ),
              SizedBox(
                height: 5.0,
              ),
              TextField(
                keyboardType: TextInputType.name,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  name_emergency = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your name of your emergency contact'),
              ),
              SizedBox(
                height: 17.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email_emergency = value;
                  setState(() {
                    _isValid2 = EmailValidator.validate(email_emergency);
                    f2 = _isValid2 ? 1 : 0;
                  });
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter the email of your emergency contact'),
              ),
              Text(
                _isValid2 ? ' ' : ' Email is not valid.',
                style: TextStyle(color: Colors.red),
              ),
              SizedBox(
                height: 5.0,
              ),
              TextField(
                keyboardType: TextInputType.phone,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  phone_emergency = value;
                  setState(() {
                    if (phone_emergency.length != 10)
                      _isValid4 = false;
                    else
                      _isValid4 = true;
                  });
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText:
                    'Enter the phone number of your emergency contact'),
              ),
              Text(
                _isValid4 ? ' ' : ' Phone number should be 10 digits.',
                style: TextStyle(color: Colors.red),
              ),
              SizedBox(
                height: 5.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                  setState(() {
                    if (password.length < 6)
                      _isValid5 = false;
                    else
                      _isValid5 = true;
                  });
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              Text(
                _isValid5 ? ' ' : ' Password should be atleast 6 digits.',
                style: TextStyle(color: Colors.red),
              ),
              SizedBox(
                height: 20.0,
              ),
              RoundedButton(
                title: 'Register',
                colour: Colors.blueAccent,
                onPressed: () async {
                  if (email == null || email.isEmpty) {
                    //f1 = 1;
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Error'),
                        content: Text('Please enter your email'),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('OK'))
                        ],
                      ),
                    );
                    return 0;
                  }
                  if (name == null || name.isEmpty) {
                    //f1 = 1;
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Error'),
                        content: Text('Please enter your name'),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('OK'))
                        ],
                      ),
                    );
                    return 0;
                  }
                  if (phone == null || phone.isEmpty) {
                    //f1 = 1;
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Error'),
                        content: Text('Please enter your phone number'),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('OK'))
                        ],
                      ),
                    );
                    return 0;
                  }
                  if (name_emergency == null || name_emergency.isEmpty) {
                    //f1 = 1;
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Error'),
                        content: Text(
                            'Please enter the name of your emergency contact'),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('OK'))
                        ],
                      ),
                    );
                    return 0;
                  }
                  if (email_emergency == null || email_emergency.isEmpty) {
                    //f1 = 1;
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Error'),
                        content: Text(
                            'Please enter the email of your emergency contact'),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('OK'))
                        ],
                      ),
                    );
                    return 0;
                  }
                  if (phone_emergency == null || phone_emergency.isEmpty) {
                    //f1 = 1;
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Error'),
                        content: Text(
                            'Please enter the phone number of your emergency contact'),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('OK'))
                        ],
                      ),
                    );
                    return 0;
                  }
                  if (password == null || password.isEmpty) {
                    //f2 = 1;
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Error'),
                        content: Text('Please enter your password'),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('OK'))
                        ],
                      ),
                    );
                    return 0;
                  }
                  if (f1 == 0 || f2 == 0) return 0;
                  if (!_isValid3 || !_isValid4 || !_isValid5) return 0;

                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (newUser != null) {
                      _firestore.collection('users').add({
                        'email': email,
                        'phone': phone,
                        'name': name,
                        'e_name': name_emergency,
                        'e_email': email_emergency,
                        'e_phone': phone_emergency,
                      });
                      Navigator.pushNamed(context, DashboardPage.id);
                    }

                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Error'),
                        content: Text('Registration not successful'),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('OK'))
                        ],
                      ),
                    );
                    return 0;
                  }


                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}