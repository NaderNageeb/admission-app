// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, non_constant_identifier_names, unnecessary_this, prefer_interpolation_to_compose_strings, prefer_const_constructors, avoid_print, unnecessary_null_comparison

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/ui_assets.dart';
import '../drawer/nav-drawer.dart';
import '../services/api_service.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}


class _HomePage extends State<HomePage> {

  String _user_type_sp = "" ;

  APIService apiServices = APIService();



  final scaffoldKey = GlobalKey<ScaffoldState>();


  late TextEditingController user_name,user_pass,user_full_name,user_type,user_faculty;

  String _user_type_dropdownValue = 'Select User Type';
  String _user_faculty_dropdownValue = 'Select User Faculty';

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  @override
  void initState() {

    super.initState();

    user_name = TextEditingController();
    user_full_name = TextEditingController();

    user_full_name = TextEditingController();
    user_type = TextEditingController();

    apiServices.getUserTypePreference().then(updateUserType);


  }


  void updateUserType(String userTypeSp){
    setState(() {
      this._user_type_sp = userTypeSp ;
      print('User Type From SP : '+ _user_type_sp.toString());
    });
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure ?'),
        content: const Text('Do you want to EXIT the App'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child:  Text('No'),
          ),
          TextButton(
            onPressed: (){
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            } ,
            child:  Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }



  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: _onWillPop,
      child:  Container(
          constraints: const BoxConstraints.expand(),

        child: Scaffold(
          drawer: NavDrawer(user_type: _user_type_sp.toString()),
          backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xFF59363b),
            title: const Text('Fu-Admission App',style: TextStyle(fontSize: 16,color: Colors.white)),
            centerTitle: false,
            actions: <Widget>[
              Padding(padding: const EdgeInsets.all(10.0),
                child: Container()
                ,)
            ]
        ),

        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Icon(Icons.add_task, color: Color(0xFF59363b)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('Add Users',
                        style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.brown)),
                  ),
                  Icon(Icons.wb_sunny, color: Colors.transparent),
                ],
              ),
              Stack(
                children: <Widget>[

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                    margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),

                    child: Form(
                      key: globalFormKey,
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 30),
                          TextFormField(
                            controller: user_name,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter Username ';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade200,
                              filled: true,
                              hintText: "Username",
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white
                                          .withOpacity(0.2))),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:  Colors.brown)),
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextFormField(
                            controller: user_full_name,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter Username ';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade200,
                              filled: true,
                              hintText: "User Full Name",
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white
                                          .withOpacity(0.2))),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:  Colors.brown)),
                            ),
                          ),
                          const SizedBox(height: 10),
                          DropdownButtonFormField(
                            decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey, width: 1),
                              ),
                              filled: true,
                            ),
                            value: _user_type_dropdownValue,
                            onChanged: (String? newValue) {
                              setState(() {
                                _user_type_dropdownValue = newValue!;
                              });
                            },
          items: <String>['Select User Type','Admin', 'Students Affairs','Clinic', 'Faculty Dean', 'Admission Staff','University Registrar'].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(fontSize: 20),
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 10),
                          DropdownButtonFormField(
                            decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey, width: 1),
                              ),
                              filled: true,
                            ),

                            value: _user_faculty_dropdownValue,

                            onChanged: (String? newValue) {
                              setState(() {
                                _user_faculty_dropdownValue = newValue!;
                                // if(_user_faculty_dropdownValue == 'Select User Faculty'){
                                //
                                // }
                              });
                            },
                            items: <String>['Select User Faculty','All', 'ENG', 'IT', 'SCI','ARCH','TCOM','GIS','BA'].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(fontSize: 20),
                                ),
                              );
                            }).toList(),
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
                                        backgroundColor: Color(0xFF59363b),
                                        fixedSize: Size.fromWidth(120),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 1, horizontal: 20),
                                      ),
                                      onPressed: () async {
                                        if (globalFormKey.currentState!.validate()) {
                                          setState(() {

                                          });
                                          apiServices.checkInternetConnnection().then((intenet) async {
                                            if (intenet != null && intenet) {
                                              if (_user_type_dropdownValue
                                                  .toString() !=
                                                  'Select User Type' &&
                                                  _user_faculty_dropdownValue !=
                                                      'Select User Faculty' && user_name.text.toString() != '' && user_full_name.text.toString() != '') {
                                                if (await apiServices
                                                    .addNewUser_API(context,
                                                    user_name.text.toString(),
                                                    user_full_name.text.toString(),
                                                    _user_type_dropdownValue.toString(),
                                                    _user_faculty_dropdownValue.toString(),
                                                    scaffoldKey) == "exist") {
                                                  setState(() {
                                                    Alert_Dialog(
                                                        context, "Oops","Username Already Exist !");
                                                  });
                                                } else {
                                                  setState(() {
                                                  });
                                                }
                                              } else {
                                                // No-Internet Case
                                                setState(() {
                                                  Alert_Dialog(
                                                      context, "No Connection",
                                                      "Make sure you have internet connection and try again !");
                                                });
                                              }
                                            }
                                          });
                                        }
                                      },
                                      child: Text("Add Users"),
                                    ),
                                    SizedBox(width: 5),

                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 1.0),
                                  child: Text('Note : User Password is Username',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: Colors.brown
                                      )
                                  ),
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
      ),
    );
  }
}






