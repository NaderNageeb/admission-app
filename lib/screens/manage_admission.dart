// ignore_for_file: depend_on_referenced_packages, unused_import, use_key_in_widget_constructors, library_private_types_in_public_api, non_constant_identifier_names, prefer_interpolation_to_compose_strings, unnecessary_this, avoid_print, prefer_const_constructors, unnecessary_null_comparison

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../components/ui_assets.dart';
import '../drawer/nav-drawer.dart';
import '../services/api_service.dart';


class ManageAdmission extends StatefulWidget {
  @override
  _ManageAdmission createState() => _ManageAdmission();
}


class _ManageAdmission extends State<ManageAdmission> {

  String _user_type_sp = "" ;

  APIService apiServices = APIService();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  TextEditingController start_dateCON = TextEditingController();
  TextEditingController end_dateCON = TextEditingController();

  @override
  void initState() {

    super.initState();

    start_dateCON.text = "";
    end_dateCON.text = "";

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
                  Icon(Icons.date_range, color: Color(0xFF59363b)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('Start , End Admission Date ',
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
                          TextField(
                            controller: start_dateCON, //editing controller of this TextField
                            decoration: const InputDecoration(
                                icon: Icon(Icons.calendar_today), //icon of text field
                                labelText: "Enter Admission Start Date" //label text of field
                            ),
                            readOnly: true,  //set it true, so that user will not able to edit text
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context, initialDate: DateTime.now(),
                                  firstDate: DateTime.now(), //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2101)
                              );

                              if(pickedDate != null ){
                                print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                                String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                //you can implement different kind of Date Format here according to your requirement

                                setState(() {
                                  start_dateCON.text = formattedDate; //set output date to TextField value.
                                });
                              }else{
                                print("Admission Start Date is not selected");
                              }
                            },
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: end_dateCON, //editing controller of this TextField
                            decoration: const InputDecoration(
                                icon: Icon(Icons.calendar_today), //icon of text field
                                labelText: "Enter Admission End Date" //label text of field
                            ),
                            readOnly: true,  //set it true, so that user will not able to edit text
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context, initialDate: DateTime.now(),
                                  firstDate: DateTime.now(), //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2101)
                              );

                              if(pickedDate != null ){
                                print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                                String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                //you can implement different kind of Date Format here according to your requirement

                                setState(() {
                                  end_dateCON.text = formattedDate; //set output date to TextField value.
                                });
                              }else{
                                print("Admission End Date is not selected");
                              }
                            },
                          ),
                          const SizedBox(height: 20),
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
                                        fixedSize: Size.fromWidth(170),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 1, horizontal: 20),
                                      ),
                                      onPressed: () async {
                                        if (globalFormKey.currentState!.validate()) {
                                          setState(() {

                                          });
                                          apiServices.checkInternetConnnection().then((intenet) async {
                                            if (intenet != null && intenet) {
                                              apiServices.UpdateAdmssionDates(context,start_dateCON.text.toString(),end_dateCON.text.toString());
                                            }
                                          });
                                        }
                                      },
                                      child: Text("Add Admission Date"),
                                    ),
                                    SizedBox(width: 5),

                                  ],
                                ),

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






