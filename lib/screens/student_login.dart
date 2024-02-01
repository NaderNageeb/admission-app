// ignore_for_file: unused_import, depend_on_referenced_packages, library_private_types_in_public_api, use_key_in_widget_constructors, unnecessary_new, non_constant_identifier_names, prefer_interpolation_to_compose_strings, unnecessary_this, sort_child_properties_last, prefer_const_constructors, avoid_print, unnecessary_null_comparison, use_build_context_synchronously

import 'package:new_admission_app/screens/student_home.dart';
import 'package:new_admission_app/screens/students_phases.dart';
import 'package:flutter/material.dart';
import 'package:new_admission_app/screens/home_screen.dart';
import 'package:new_admission_app/services/progressHUD.dart';
import 'package:new_admission_app/services/api_service.dart';
import 'package:new_admission_app/components/ui_assets.dart';
import 'package:shimmer/shimmer.dart';


class StudentLoginScreen extends StatefulWidget {
  @override
  _StudentLoginScreen createState() => _StudentLoginScreen();
}

const kPrimaryColor = Color(0xFF1B383A);


class _StudentLoginScreen extends State<StudentLoginScreen> {

  late TextEditingController user_name, user_pass;
  bool hidePassword = true;
  bool isApiCallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  APIService apiServices = new APIService();
  bool processing = false;

  String _user_type_sp = "";


  @override
  void initState() {
    super.initState();
    user_name = TextEditingController();
    user_pass = TextEditingController();

    apiServices.getUserTypePreference().then(updateUserType);
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
              image: AssetImage("assets/img/background.png"), fit: BoxFit.cover)
      ),
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
                            height: 200, width: 200,
                            child: Image.asset("assets/img/logo.png"),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 30.0),
                            child: Shimmer.fromColors(
                              baseColor: Colors.white,
                              highlightColor: Colors.white,
                              child: const Text(
                                "Students Admission App",
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
                                return 'Please enter your Min Number';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Enter Min Number",
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white
                                          .withOpacity(0.2))),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white)),
                            ),
                          ),
                          const SizedBox(height: 30),


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
                                          apiServices.checkInternetConnnection()
                                              .then((intenet) async {
                                            if (intenet != null && intenet) {
                                              if (await apiServices.StudentsLoginIn(context, user_name.text.toString(), scaffoldKey) == "exist") {
                                                setState(() {
                                                  isApiCallProcess = false;
                                                  _navigateToHomeScreen(context) ;
                                                });
                                              } else if(await apiServices.StudentsLoginIn(context, user_name.text.toString(), scaffoldKey) == "DateError") {
                                                setState(() {
                                                  isApiCallProcess = false;
                                                  Alert_Dialog(context, "Admission Date",
                                                      "Admission Closed for now !");
                                                });
                                              }else if(await apiServices.StudentsLoginIn(context, user_name.text.toString(), scaffoldKey) == "Wrong") {
                                                setState(() {
                                                  isApiCallProcess = false;
                                                  Alert_Dialog(context, "Ops",
                                                      "Wrong or not exist Min Number !");
                                                });
                                              }
                                            } else {
                                              // No-Internet Case
                                              setState(() {
                                                isApiCallProcess = false;
                                                Alert_Dialog(
                                                    context, "No Connection",
                                                    "Make sure you have internet connection and try again !");
                                              });
                                            }
                                          });
                                        }
                                      },
                                      child: Text("Login"),
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

   // if (_user_type_sp.toString() == "01") {
      Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => StudentHomePage()), (
          route) => false,);
    //}
  }
}
