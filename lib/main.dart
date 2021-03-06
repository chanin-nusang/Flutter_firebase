import 'package:flutter/material.dart';
import 'package:flutter_firebase/screen/display_screen.dart';
import 'package:flutter_firebase/screen/form_screen.dart';
import 'package:flutter_firebase/screen/home_screen.dart';
import 'package:flutter_firebase/screen/welcome_screen.dart';

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
        ),
        home: HomeScreen());
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: TabBarView(
          children: [WelcomeScreen(), FormScreen(), DisplayScreen()],
        ),
        backgroundColor: Colors.blue,
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(text: "หน้าแรก"),
            Tab(text: "บันทึกคะแนน"),
            Tab(
              text: "รายชื่อนักเรียน",
            ),
          ],
        ),
      ),
    );
  }
}
