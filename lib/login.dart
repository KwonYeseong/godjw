import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:godjw/tabs.dart';
import 'package:godjw/user.model.dart';
import 'package:godjw/utils/user.utils.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Container(
          margin: EdgeInsets.only(top: 130),
      child: Center(
        child: Column(

          children: <Widget>[
            Image.asset('assets/loginCharacter.png'),
            RaisedButton(
                color: Colors.blueAccent,
              child: Text("               Log In                " ,
              style: TextStyle(color: Colors.white,fontSize: 24)),
              onPressed: () async {
                User user = await glLogin();
                // 로그인 과정에서 문제가 있는 경우
                if (user == null) return;

                DocumentReference usersRef =
                    Firestore.instance.collection('Users').document(user.uid);
                usersRef.get().then((docSnapshot) async {
                  if (docSnapshot.exists) {
                    // 가입된 유저
                    user.regDttm = docSnapshot.data['regDttm'];
                    UserUtil.setUser(user);
                  } else {
                    // 가입 x 유저
                    UserUtil.setUser(await _joinUser(user));
                  }
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (_) {
                    return TabsPage();
                  }), ModalRoute.withName('/tabs'));
                });
              },
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
            ),
          ],
        ),
      ),
    ));
  }

  Future<User> glLogin() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = await _auth.signInWithCredential(credential);
    print("signed in " + user.displayName);
    return new User(user.uid, user.photoUrl, user.displayName, "");
  }

  Future<User> _joinUser(User user) {
    int regDttm = Timestamp.now().microsecondsSinceEpoch;

    return Firestore.instance.collection('Users').document(user.uid).setData({
      'uid': user.uid,
      'name': user.name,
      'profileUrl': user.profileUrl,
      'regDttm': regDttm.toString()
    }).then((void v) async {
      user.regDttm = regDttm.toString();
      return user;
    }).catchError(() {
      // DB에 신규 유저 등록에 문제가 있는 경우
      return null;
    });
  }
}
