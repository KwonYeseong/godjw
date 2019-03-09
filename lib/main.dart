import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:godjw/login.dart';
import 'package:godjw/splash.route.dart';
import 'package:godjw/tabs.dart';
import 'package:godjw/user.model.dart';
import 'package:godjw/utils/user.utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        cursorColor: Colors.black,
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/tabs': (BuildContext context) => TabsPage(),
        '/login': (BuildContext context) => LoginPage()
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  Future navigationPage() async {
    FirebaseUser fUser = await FirebaseAuth.instance.currentUser();
    if (fUser != null) {
      try {
        User user = User.fromDs(await Firestore.instance
            .collection('Users')
            .document(fUser.uid)
            .get());
        UserUtil.setUser(user);
        Navigator.pushReplacement(context, SplashRoute(builder: (_) {
          return TabsPage();
        }));
      } catch (error) {
        FirebaseAuth.instance.signOut();
        Navigator.pushReplacement(context, SplashRoute(builder: (_) {
          return LoginPage();
        }));
      }
    } else {
      Navigator.pushReplacement(context, SplashRoute(builder: (_) {
        return LoginPage();
      }));
    }
  }

  void checkCurrentUser() async {
    FirebaseUser fUser = await FirebaseAuth.instance.currentUser();
    if (fUser != null) {
      try {
        User user = User.fromDs(await Firestore.instance
            .collection('Users')
            .document(fUser.uid)
            .get());
        UserUtil.setUser(user);
      } catch (error) {
        FirebaseAuth.instance.signOut();
      }
    }
    Navigator.of(context).pushReplacementNamed('/decision');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          color: Color(0xff5977B8),
          image: DecorationImage(
              image: AssetImage(
                "assets/aircraft.gif",
              ),
              fit: BoxFit.cover)),
    ));
  }
}
