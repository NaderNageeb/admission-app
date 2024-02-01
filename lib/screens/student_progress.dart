// ignore_for_file: depend_on_referenced_packages, unused_import, non_constant_identifier_names, library_private_types_in_public_api, use_key_in_widget_constructors, avoid_print, avoid_single_cascade_in_expression_statements, prefer_interpolation_to_compose_strings, unnecessary_this, prefer_const_constructors, avoid_unnecessary_containers

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../components/ui_assets.dart';
import '../drawer/nav-drawer.dart';
import '../services/api_service.dart';


class StudentProgress extends StatefulWidget {
  @override
  _StudentProgress createState() => _StudentProgress();
}


class _StudentProgress extends State<StudentProgress> {



  String _stud_min_number_sp = "" ;
  String _stud_name_sp = "" ;
  String _stud_school_sp = "" ;
  String _stud_fac_sp = "" ;
  String _stud_maj_sp = "" ;
  String _stud_batch_sp = "" ;
  String _stud_type_sp = "" ;

  APIService apiServices = APIService();

  final scaffoldKey = GlobalKey<ScaffoldState>();


  late TextEditingController min_number_CON,stud_name_CON,stud_school_CON,stud_fac_CON,stud_maj_CON,stud_batch_CON;



  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  late String  stud_min_number_text = "" ,student_affairs_status_text = "",info_stud_name_en_text = "" ,
      clinic_status_text = "", dean_status_text = "",admission_status_text= "" ,reg_status_text = "" ;


  @override
  void initState() {

    super.initState();

    min_number_CON = TextEditingController();
    stud_name_CON = TextEditingController();
    stud_school_CON = TextEditingController();
    stud_fac_CON = TextEditingController();
    stud_maj_CON = TextEditingController();
    stud_batch_CON = TextEditingController();



    apiServices.getStudMinPreference().then(updateStudMinNumber);
    apiServices.getStudNamePreference().then(updateStudName);
    apiServices.getStudSchoolPreference().then(updateStudSchool);
    apiServices.getStudFacPreference().then(updateStudFac);
    apiServices.getStudMajPreference().then(updateStudMaj);
    apiServices.getStudBatchPreference().then(updateStudBatch);
    apiServices.getStudTypePreference().then(updateStudType);


    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        get_Stud_Progress();
      });

    });
  }

  Future<void> get_Stud_Progress() async {

    final list = await apiServices.getStudenProgress(_stud_min_number_sp.toString());

    print( 'Student Admission Progress : ${list[0].stud_min_number} \n ${list[0].student_affairs_status} \n${list[0].clinic_status} \n');


    stud_min_number_text = list[0].stud_min_number  ;
    student_affairs_status_text = list[0].student_affairs_status  ;
    clinic_status_text = list[0].clinic_status  ;
    dean_status_text = list[0].dean_status  ;
    admission_status_text = list[0].admission_status  ;
    reg_status_text = list[0].reg_status  ;
    info_stud_name_en_text =  list[0].info_stud_name_en  ;


    //Filled Data//

    setState(() {

      stud_name_CON..text = info_stud_name_en_text.toString() ;

      stud_fac_CON..text = _stud_fac_sp.toString() ;
      stud_maj_CON..text = _stud_maj_sp.toString() ;
      stud_batch_CON..text = _stud_batch_sp.toString() ;



      if(student_affairs_status_text =='No'){
        student_affairs_status_text = 'Not Confirmed';
      }else if(student_affairs_status_text=='Yes'){
        student_affairs_status_text = 'Confirmed';
      }

      if(clinic_status_text =='No'){
        clinic_status_text = 'Not Confirmed';
      }else if(clinic_status_text=='Yes'){
        clinic_status_text = 'Confirmed';
      }

      if(dean_status_text =='No'){
        dean_status_text = 'Not Confirmed';
      }else if(dean_status_text=='Yes'){
        dean_status_text = 'Confirmed';
      }

      if(admission_status_text =='No'){
        admission_status_text = 'Not Confirmed';
      }else if(admission_status_text=='Yes'){
        admission_status_text = 'Confirmed';
      }

      if(reg_status_text =='No'){
        reg_status_text = 'Not Confirmed';
      }else if(reg_status_text=='Yes'){
        reg_status_text = 'Confirmed';
      }

    });

  }

  void updateStudMinNumber(String StudMinSp){
    setState(() {
      this._stud_min_number_sp = StudMinSp ;
      print('Stud Min Number From SP : '+ _stud_min_number_sp.toString());
    });
  }


  void updateStudName(String StudNameSp){
    setState(() {
      this._stud_name_sp = StudNameSp ;
      print('Stud Name From SP : '+ _stud_name_sp.toString());
    });
  }



  void updateStudSchool(String StudSchoolSp){
    setState(() {
      this._stud_school_sp = StudSchoolSp ;
      print('Stud School From SP : '+ _stud_school_sp.toString());
    });
  }


  void updateStudFac(String StudFacSp){
    setState(() {
      this._stud_fac_sp = StudFacSp ;
      print('Stud Fac From SP : '+ _stud_fac_sp.toString());
    });
  }

  void updateStudMaj(String StudMajSp){
    setState(() {
      this._stud_maj_sp = StudMajSp ;
      print('Stud Maj From SP : '+ _stud_maj_sp.toString());
    });
  }

  void updateStudBatch(String StudBatchSp){
    setState(() {
      this._stud_batch_sp = StudBatchSp ;
      print('Stud Batch From SP : '+ _stud_batch_sp.toString());
    });
  }


  void updateStudType(String StudTypeSp){
    setState(() {
      this._stud_type_sp = StudTypeSp ;
      print('Stud Type From SP : '+ _stud_type_sp.toString());
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
          drawer: NavDrawer(user_type: _stud_type_sp.toString()),
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
                    Icon(Icons.task_alt, color: Color(0xFF59363b)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('Student Admission Progress',
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
                            const SizedBox(height: 10),
                            Container(
                              child: TextField(
                                enabled: false,
                                controller: min_number_CON
                                  ..text = _stud_min_number_sp.toString(),
                                decoration: InputDecoration(
                                    labelText: 'Stud Min Number',
                                    hintText: "Stud Min Number",
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.orange
                                                .withOpacity(0.2))),
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.orange))
                                ),
                              ),
                            ),
                            const SizedBox(height: 1),
                            Container(
                              child: TextField(
                                enabled: false,
                                controller: stud_name_CON
                                  ..text = info_stud_name_en_text.toString(),
                                decoration: InputDecoration(
                                    labelText: 'Stud Name',
                                    hintText: "Stud Name",
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.orange
                                                .withOpacity(0.2))),
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.orange))
                                ),
                              ),
                            ),
                            const SizedBox(height: 1),
                            // Container(
                            //   child: TextField(
                            //     enabled: false,
                            //     controller: stud_school_CON
                            //       ..text = _stud_school_sp.toString(),
                            //     decoration: InputDecoration(
                            //         labelText: 'School',
                            //         hintText: "School",
                            //         enabledBorder: UnderlineInputBorder(
                            //             borderSide: BorderSide(
                            //                 color: Colors.orange
                            //                     .withOpacity(0.2))),
                            //         focusedBorder: const UnderlineInputBorder(
                            //             borderSide: BorderSide(
                            //                 color: Colors.orange))
                            //     ),
                            //   ),
                            // ),
                            const SizedBox(height: 1),
                            Container(
                              child: TextField(
                                enabled: false,
                                controller: stud_fac_CON
                                  ..text = _stud_fac_sp.toString(),
                                decoration: InputDecoration(
                                    labelText: 'Faculty',
                                    hintText: "Faculty",
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.orange
                                                .withOpacity(0.2))),
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.orange))
                                ),
                              ),
                            ),
                            const SizedBox(height: 1),
                            Container(
                              child: TextField(
                                enabled: false,
                                controller: stud_maj_CON
                                  ..text = _stud_maj_sp.toString(),
                                decoration: InputDecoration(
                                    labelText: 'Major',
                                    hintText: "Major",
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.orange
                                                .withOpacity(0.2))),
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.orange))
                                ),
                              ),
                            ),
                            const SizedBox(height: 1),
                            Container(
                              child: TextField(
                                enabled: false,
                                controller: stud_batch_CON
                                  ..text = _stud_batch_sp.toString(),
                                decoration: InputDecoration(
                                    labelText: 'Batch',
                                    hintText: "Batch",
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.orange
                                                .withOpacity(0.2))),
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.orange))
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0,0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                Card (
                                  margin: EdgeInsets.all(10),
                                  color: Colors.green[100],
                                  shadowColor: Colors.blueGrey,
                                  elevation: 20,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children:  <Widget>[
                                      ListTile(
                                        leading: const Icon (
                                            Icons.album,
                                            color: Colors.brown,
                                            size: 50
                                        ),
                                        title: const Text(
                                          "Students Affairs",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        subtitle: Text('Status : $student_affairs_status_text',style: TextStyle(fontSize: 17,color: Colors.black)),
                                      ),
                                    ],
                                  ),
                                ),
                                  Card (
                                    margin: EdgeInsets.all(10),
                                    color: Colors.green[100],
                                    shadowColor: Colors.blueGrey,
                                    elevation: 20,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children:  <Widget>[
                                        ListTile(
                                          leading: const Icon (
                                              Icons.medical_information,
                                              color: Colors.brown,
                                              size: 50
                                          ),
                                          title: const Text(
                                            "Clinic",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          subtitle: Text('Status : $clinic_status_text',style: TextStyle(fontSize: 17,color: Colors.black)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Card (
                                    margin: EdgeInsets.all(10),
                                    color: Colors.green[100],
                                    shadowColor: Colors.blueGrey,
                                    elevation: 20,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children:  <Widget>[
                                        ListTile(
                                          leading: const Icon (
                                              Icons.verified_user,
                                              color: Colors.brown,
                                              size: 50
                                          ),
                                          title: const Text(
                                            "Faculty Dean",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          subtitle: Text('Status : $dean_status_text',style: TextStyle(fontSize: 17,color: Colors.black)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Card (
                                    margin: EdgeInsets.all(10),
                                    color: Colors.green[100],
                                    shadowColor: Colors.blueGrey,
                                    elevation: 20,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children:  <Widget>[
                                        ListTile(
                                          leading: const Icon (
                                              Icons.account_box_outlined ,
                                              color: Colors.brown,
                                              size: 50
                                          ),
                                          title: const Text(
                                            "Admission Office",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          subtitle: Text('Status : $admission_status_text',style: TextStyle(fontSize: 17,color: Colors.black)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Card (
                                    margin: EdgeInsets.all(10),
                                    color: Colors.green[100],
                                    shadowColor: Colors.blueGrey,
                                    elevation: 20,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children:     <Widget>[
                                        ListTile(
                                          leading: const Icon (
                                              Icons.account_balance_sharp ,
                                              color: Colors.brown,
                                              size: 50
                                          ),
                                          title: const Text(
                                            "University Registrar",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          subtitle: Text('Status : $reg_status_text',style: TextStyle(fontSize: 17,color: Colors.black)),
                                        ),
                                      ],
                                    ),
                                  )
                                  , SizedBox(height: 20),
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









