


// ignore_for_file: unnecessary_import, depend_on_referenced_packages, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, non_constant_identifier_names, unused_field, prefer_final_fields, unnecessary_null_comparison, prefer_interpolation_to_compose_strings, unnecessary_this, avoid_print, avoid_single_cascade_in_expression_statements, prefer_const_constructors, unnecessary_new, no_leading_underscores_for_local_identifiers, avoid_unnecessary_containers, unused_local_variable

import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:new_admission_app/models/main_model.dart';
import 'package:new_admission_app/services/api_service.dart';
import '../components/ui_assets.dart';
import '../drawer/nav-drawer.dart';

class StudentsPhasesState extends StatefulWidget {
  StudentsPhasesState();
  @override
  State<StatefulWidget> createState() {
    return StudentsPhases();
  }
}

class StudentsPhases extends State<StudentsPhasesState> {

  APIService apiServices = APIService();
  var urlz = APIService.url ;
  bool _vis_value = false;
  late String stud_min_number ;



  TextEditingController _StudMinNumberController_dump = TextEditingController();

  TextEditingController _StudFullNameCONT_dump = TextEditingController();
  TextEditingController _StudSchoolCONT_dump = TextEditingController();
  TextEditingController _StudFacCONT_dump = TextEditingController();
  TextEditingController _StudMajCONT_dump = TextEditingController();
  TextEditingController _StudBatchCONT_dump = TextEditingController();

  final _addFormKey = GlobalKey<FormState>();

  String _user_type_sp = "";
  String _user_ID_sp = "";

  @override
  void initState() {
    super.initState();

    _vis_value  = false ;
    apiServices.getUserTypePreference().then(updateUserType);
    apiServices.getUserIDPreference().then(updateUserID);

    apiServices.checkInternetConnnection().then((intenet) async {
      if (intenet != null && intenet) {
        Get_STUD_List();
      }else{
        Alert_Dialog(context, "No Connection", "Make sure you have internet connection and try again !");
      }
    });
  }

  void updateUserType(String userTypeSp) {
    setState(() {
      this._user_type_sp = userTypeSp;
      print('User Type From SP : ' + _user_type_sp.toString());
    });
  }

  void updateUserID(String userIDSp) {
    setState(() {
      this._user_ID_sp = userIDSp;
      print('User ID From SP : ' + _user_ID_sp.toString());
    });

    User_Type(_user_type_sp);
  }


  Future<List<StudData>> Get_STUD_List() async {
    String finalUrl  = urlz+'?GetStudents' ;
    final response = await get(Uri.parse(finalUrl));

    if (response.statusCode == 200) {
      List studData = json.decode(utf8.decode(response.bodyBytes));
      return studData.map((studData) => StudData.fromJson(studData)).toList();
    } else {
      throw Exception('Error while getting the data , Check connections and try again !');
    }
  }

   String User_Type(String user_type){

    print('USER TYPE : '+ user_type) ;

    return user_type ;

    }
  Future<void> get_Stud_Info() async {

    String stud_min_number_dump_text , stud_name_dump_text ,stud_school_dump_text,stud_fac_dump_text ,stud_maj_dump_text  ,stud_bacth_dump_text;

    if(_StudMinNumberController_dump.text.toString() !=''){

      stud_min_number = _StudMinNumberController_dump.text.toString() ;

      final list = await apiServices.getStudentInfoAfterFill(stud_min_number,_user_ID_sp.toString(),_user_type_sp.toString());

      print( 'Main User Info :: User ID :${_user_ID_sp.toString()} , User Type : ${_user_type_sp.toString()}  ');

      print('${list[0].stud_min_number} \n ${list[0].info_stud_name_en} \n${list[0].faculty_desc} \n');

      stud_min_number_dump_text = list[0].stud_min_number  ;
      stud_name_dump_text = list[0].info_stud_name_en  ;
      stud_fac_dump_text = list[0].faculty_desc  ;
      stud_maj_dump_text = list[0].major_desc  ;
      stud_bacth_dump_text = list[0].stud_batch  ;

      setState(() {

        _StudFullNameCONT_dump..text = stud_name_dump_text.toString() ;

        _StudFacCONT_dump..text = stud_fac_dump_text.toString() ;
        _StudMajCONT_dump..text = stud_maj_dump_text.toString() ;
        _StudBatchCONT_dump..text = stud_bacth_dump_text.toString() ;

      });
    }

  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          drawer: NavDrawer(user_type: _user_type_sp.toString()),
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
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const  SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Icon(Icons.supervised_user_circle, color: Color(0xFF59363b)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('Student Confirmation',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.brown)),
                  ),
                  Icon(Icons.wb_sunny, color: Colors.transparent),
                ],
              ),


              Form(
                key: _addFormKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 1, horizontal: 20),
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child : SingleChildScrollView(
                        child: TextField(
                          controller: _StudMinNumberController_dump,
                          decoration: InputDecoration(
                              labelText: 'Enter Student MIN Number',
                              hintText: "Enter Student MIN Number",
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.brown
                                          .withOpacity(0.2))),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.brown))
                          ),
                        ), ),
                    ),
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                TextButton(
                                  style: TextButton.styleFrom(backgroundColor: Color(0xFF59363b),fixedSize: Size.fromWidth(120)),
                                  child: Text('Search',style: TextStyle(color: Colors.white)),
                                  onPressed: () {
                                    // if(_StudMinNumberController.text.toString() !=''){
                                    setState(() {
                                      _vis_value = true ;
                                      stud_min_number = _StudMinNumberController_dump.text.toString() ;

                                      if(_StudMinNumberController_dump.text.toString() != '') {

                                        get_Stud_Info();

                                        Future.delayed(const Duration(milliseconds: 500), () {

                                          setState(() {

                                            Single_Student_Details(
                                                context,
                                                _StudMinNumberController_dump
                                                    .text.toString(),
                                                _StudFullNameCONT_dump
                                                    .text.toString(),

                                                _StudFacCONT_dump.text
                                                    .toString(),
                                                _StudMajCONT_dump.text
                                                    .toString(),
                                                _StudBatchCONT_dump.text
                                                    .toString(),_user_ID_sp.toString(),_user_type_sp.toString());
                                          });

                                        });

           }else{
                                        Alert_Dialog(context, "Oops", "ENTER Student MIN Number");
                                      }

                                    });
                                    // }
                                  },
                                ),

                              ],
                            ),

                          ],
                        )
                    ),
                  ],),
              ),
            ],
          )
      ),
    );
  }
}


TextEditingController _StudMinNumberController = TextEditingController();
TextEditingController _StudNameController = TextEditingController();
TextEditingController _StudFacultyController = TextEditingController();
TextEditingController _StudMajorController = TextEditingController();
TextEditingController _StudBatchController = TextEditingController();

//ClinicCON//
TextEditingController _CommentsController = TextEditingController();

TextEditingController _admissionFeesController = TextEditingController();

final _addFormKey2 = GlobalKey<FormState>();
final  APIService apiServices = new APIService();

Future<void> Single_Student_Details(BuildContext context,String studMinNumber,String studName,
    String studFaculty,String studMajor,String studBatch , String user_id,String user_type) async {


  String confirm_type_text = "";



      if(user_type.toString() == '1'){
        confirm_type_text = "Clinic Confirmation" ;
      }
      if(user_type.toString() == '2'){
        confirm_type_text = "Dean Confirmation" ;
      }
      if(user_type.toString() == '3'){
        confirm_type_text = "Admission Confirmation" ;
      }
      if(user_type.toString() == '4'){
        confirm_type_text = "Registrar Confirmation" ;
      }
  if(user_type.toString() == '5'){
    confirm_type_text = "STUD Affairs Confirm" ;
    }

  String _Confirm_dropdownValue = confirm_type_text ;

  return showDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        title: Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          color: Color(0xFF59363b),
          child:  Text('Min NUmber : '+ studMinNumber.toString() , textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white)),
        ),

        titlePadding: const EdgeInsets.all(5),

        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Form(
                      key: _addFormKey2,
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: TextField(
                              enabled: false,
                              controller: _StudMinNumberController
                                ..text = studMinNumber.toString(),
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
                          Container(
                            child: TextField(
                              enabled: false,
                              controller: _StudNameController..text = studName.toString(),
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
                          Container(
                            child: TextField(
                              enabled: false,
                              controller: _StudFacultyController
                                ..text = studFaculty.toString(),
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
                          Container(
                            child: TextField(
                              enabled: false,
                              controller: _StudMajorController
                                ..text = studMajor.toString(),
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
                          Container(
                              child: TextField(
                                enabled: false,
                                controller: _StudBatchController
                                  ..text = studBatch.toString(),
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
                              )
                          ),
                          const Divider(color: Color(0xFF59363b),) ,
                          const SizedBox(width: 10),
                          DropdownButtonFormField(
                            decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey, width: 0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey, width: 0),
                              ),
                              filled: true,
                            ),
                            value: _Confirm_dropdownValue,
                            onChanged: (String? newValue) {
                             // setState(() {
                                _Confirm_dropdownValue = newValue!;
                             //
                            },
                            items: <String>[confirm_type_text,'Yes', 'No'].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(fontSize: 20),
                                ),
                              );
                            }).toList(),
                          ),

                          Container(
                              child: TextField(
                                keyboardType: TextInputType.multiline,
                                maxLines: 3,
                                controller: _CommentsController,
                                decoration: InputDecoration(
                                    labelText: 'Your comments HERE',
                                    hintText: "Your comments",
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.orange
                                                .withOpacity(0.2))),
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.orange))
                                ),
                              )
                          ),

            if(user_type.toString() == "3")...[

                      Container(
                          child: TextField(
                            keyboardType: TextInputType.numberWithOptions(),
                            controller: _admissionFeesController,
                            decoration: InputDecoration(
                                labelText: 'Admission Fees',
                                hintText: "Admission Fees",
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.orange
                                            .withOpacity(0.2))),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.orange))
                            ),
                          )
                      )
            ],

                          const SizedBox(width: 10),

                        ],)
                  ),
                ]
                ,),
            ],),
        ),actions: <Widget>[

        Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextButton(
                      style: TextButton.styleFrom(backgroundColor: Color(0xFF59363b)),
                      onPressed: () {
                        Navigator.of(context).pop() ;
                      },
                      child: Text('Cancel',style: TextStyle(color:Colors.white)),
                    ),
                    const SizedBox(width: 5),
                    TextButton(
                      style: TextButton.styleFrom(backgroundColor: Colors.green),
                      child: Text('Submit',style: TextStyle(color: Colors.white)),
                      onPressed: () {
      String admission_fess = "0";

                        if(_admissionFeesController.text.toString() !=''){
                          admission_fess = _admissionFeesController.text.toString() ;
                        }

       if(_Confirm_dropdownValue != confirm_type_text && _CommentsController.text.toString() != ''){
         apiServices.Stud_Confim(context,studMinNumber.toString(),_Confirm_dropdownValue.toString(),_CommentsController.text.toString(),admission_fess.toString(),user_type.toString(),user_id.toString(),_addFormKey2) ;

         _CommentsController.text = "";
         _admissionFeesController.text = "";

                          }else{
                          }
                        }
                    ),
                  ],
                ),
              ],
            )
        )
      ],);
    },);
}