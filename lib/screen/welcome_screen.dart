import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/screen/home_screen.dart';

class WelcomeScreen extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("หน้าแรก"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                auth.currentUser.email,
                style: TextStyle(fontSize: 25),
              ),
              ElevatedButton(
                  onPressed: () {
                    auth.signOut().then((value) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return HomeScreen();
                      }));
                    });
                  },
                  child: Text("ออกจากระบบ"))
            ],
          ),
        ));
  }
}
