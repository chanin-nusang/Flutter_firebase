import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/model/profile.dart';
import 'package:flutter_firebase/screen/home_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Error"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                title: Text("สร้างบัญชีผู้ใช้"),
              ),
              body: Container(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Form(
                      key: formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "อีเมล",
                              style: TextStyle(fontSize: 20),
                            ),
                            TextFormField(
                              validator: MultiValidator([
                                RequiredValidator(errorText: "กรุณาป้อนอีเมล"),
                                EmailValidator(
                                    errorText: "รูปแบบอีเมลไม่ถูกต้อง")
                              ]),
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (String email) {
                                profile.email = email;
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "รหัสผ่าน",
                              style: TextStyle(fontSize: 20),
                            ),
                            TextFormField(
                                validator: RequiredValidator(
                                    errorText: "กรุณาป้อนรหัสผ่าน"),
                                obscureText: true,
                                onSaved: (String password) {
                                  profile.password = password;
                                }),
                            SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    if (formKey.currentState.validate()) {
                                      formKey.currentState.save();
                                      try {
                                        await FirebaseAuth.instance
                                            .createUserWithEmailAndPassword(
                                                email: profile.email,
                                                password: profile.password)
                                            .then((value) {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "สร้างบัญชีผู้ใช้เรียบร้อยแล้ว กรุณาเข้าสู่ระบบด้วยอีเมลและรหัสผ่านดังกล่าว",
                                              gravity: ToastGravity.TOP);
                                          formKey.currentState.reset();
                                          Navigator.pop(context);
                                        });
                                      } on FirebaseAuthException catch (e) {
                                        String message;
                                        if (e.code == 'email-already-in-use') {
                                          message =
                                              "อีเมลนี้มีการลงทะเบียนไว้แล้ว กรุณาใช้อีเมลอื่นแทน";
                                        } else if (e.code == 'weak-password') {
                                          message =
                                              "รหัสผ่านต้องมีความยาวตั้งแต่ 6 ตัวอักษรขึ้นไป";
                                        } else {
                                          message = e.message;
                                        }
                                        Fluttertoast.showToast(
                                            msg: message,
                                            gravity: ToastGravity.CENTER);
                                        // print(e.code);
                                        // print(e.message);
                                      }
                                    }
                                  },
                                  child: Text("ลงทะเบียน",
                                      style: TextStyle(fontSize: 20))),
                            )
                          ],
                        ),
                      )),
                ),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: Text("สร้างบัญชีผู้ใช้"),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
