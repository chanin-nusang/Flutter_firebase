import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("แบบฟอร์มบันทึกคะแนน"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ชื่อ",
                style: TextStyle(fontSize: 20),
              ),
              TextFormField(),
              SizedBox(
                height: 15,
              ),
              Text(
                "นามสกุล",
                style: TextStyle(fontSize: 20),
              ),
              TextFormField(),
              SizedBox(
                height: 15,
              ),
              Text(
                "อีเมล",
                style: TextStyle(fontSize: 20),
              ),
              TextFormField(),
              SizedBox(
                height: 15,
              ),
              Text(
                "คะแนน",
                style: TextStyle(fontSize: 20),
              ),
              TextFormField(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    child: Text("บันทึกข้อมูล", style: TextStyle(fontSize: 20)),
                    onPressed: () {}),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
