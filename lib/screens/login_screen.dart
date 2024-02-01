// ignore_for_file: depend_on_referenced_packages, use_key_in_widget_constructors, library_private_types_in_public_api, unnecessary_new, non_constant_identifier_names, prefer_interpolation_to_compose_strings, prefer_const_constructors, sort_child_properties_last, unnecessary_this, avoid_print, unnecessary_null_comparison

import 'dart:async';

import 'package:new_admission_app/screens/student_login.dart';
import 'package:new_admission_app/screens/students_phases.dart';
import 'package:flutter/material.dart';
import 'package:new_admission_app/screens/home_screen.dart';
import 'package:new_admission_app/services/progressHUD.dart';
import 'package:new_admission_app/services/api_service.dart';
import 'package:new_admission_app/components/ui_assets.dart';
import 'package:shimmer/shimmer.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreen createState() => _LoginScreen();
}

const kPrimaryColor = Color(0xFF1B383A);

class _LoginScreen extends State<LoginScreen> {
  late TextEditingController user_name, user_pass;
  bool hidePassword = true;
  bool isApiCallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  APIService apiServices = new APIService();
  bool processing = false;
  Timer? timer;
  late String _user_type_sp;

  @override
  void initState() {
    super.initState();
    user_name = TextEditingController();
    user_pass = TextEditingController();
  }

  void updateUserType(String userTypeSp) {
    setState(() {
      this._user_type_sp = userTypeSp;
      print('User Type From SP : ' + _user_type_sp.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiSetup(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF59363b)),
    );
  }

  Widget _uiSetup(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/img/background.png"),
              fit: BoxFit.cover)),
      child: Scaffold(
        //0xFF59363b
        key: scaffoldKey,
        backgroundColor: Color(0xFF59363b),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 50),
              Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 50),
                    margin: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    child: Form(
                      key: globalFormKey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 200,
                            width: 200,
                            child: Image.asset("assets/img/logo.png"),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 30.0),
                            child: Shimmer.fromColors(
                              baseColor: Colors.white,
                              highlightColor: Colors.white,
                              child: const Text(
                                "Admission App",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'Neuton'),
                              ),
                            ),
                          ),
                          const SizedBox(height: 50),
                          TextFormField(
                            controller: user_name,
                            keyboardType: TextInputType.text,
                            //onSaved: (input) => loginRequestModel.email = input,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Username';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Username",
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white.withOpacity(0.2))),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                            ),
                          ),
                          const SizedBox(height: 30),
                          TextFormField(
                            controller: user_pass,
                            style: const TextStyle(color: Colors.black),
                            keyboardType: TextInputType.text,
                            //loginRequestModel.password = input,
                            validator: (value) {
                              if (value!.isEmpty || value.length < 3) {
                                return 'Please enter your Password !';
                              }
                              return null;
                            },
                            obscureText: hidePassword,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Password",
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white.withOpacity(0.2))),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                },
                                color: Color(0xFFe13227).withOpacity(0.4),
                                icon: Icon(hidePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFFe13227),
                                        fixedSize: Size.fromWidth(120),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 20),
                                      ),
                                      onPressed: () async {
                                        if (globalFormKey.currentState!
                                            .validate()) {
                                          setState(() {
                                            isApiCallProcess = true;
                                          });
                                          apiServices
                                              .checkInternetConnnection()
                                              .then((intenet) async {
                                            if (intenet != null && intenet) {
                                              if (await apiServices.userLoginIn(
                                                      context,
                                                      user_name.text.toString(),
                                                      user_pass.text.toString(),
                                                      scaffoldKey) ==
                                                  "exist") {
                                                setState(() {
                                                  isApiCallProcess = false;
                                                  apiServices
                                                      .getUserTypePreference()
                                                      .then(updateUserType);
                                                  Future.delayed(
                                                      const Duration(
                                                          milliseconds: 500),
                                                      () {
                                                    setState(() {
                                                      _navigateToHomeScreen(
                                                          context);
                                                    });
                                                  });
                                                });
                                              } else {
                                                setState(() {
                                                  isApiCallProcess = false;
                                                  Alert_Dialog(context, "Oops",
                                                      "Wrong Username/Password.Make sure to enter the correct username and password ! ");
                                                });
                                              }
                                            } else {
                                              // No-Internet Case
                                              setState(() {
                                                isApiCallProcess = false;
                                                Alert_Dialog(
                                                    context,
                                                    "No Connection",
                                                    "Make sure you have internet connection and try again !");
                                              });
                                            }
                                          });
                                        }
                                      },
                                      child: Text("Login"),
                                    ),
                                    SizedBox(width: 5),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFFe13227),
                                        fixedSize: Size.fromWidth(120),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 20),
                                      ),
                                      onPressed: () async {
                                        // Navigator.of(context).push(
                                        //   context, MaterialPageRoute(builder: (context) => StudentLoginScreen()), (
                                        //     route) => false,);
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return StudentLoginScreen();
                                            },
                                          ),
                                        );
                                      },
                                      child: Text("Student"),
                                    ),
                                    SizedBox(width: 5),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _navigateToHomeScreen(BuildContext context) {
    if (_user_type_sp == "0") {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (route) => false,
      );
    }
    if (_user_type_sp == "1" ||
        _user_type_sp == "2" ||
        _user_type_sp == "3" ||
        _user_type_sp == "4" ||
        _user_type_sp == "5") {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => StudentsPhasesState()),
        (route) => false,
      );
    }
  }
}
