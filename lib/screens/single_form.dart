
// ignore_for_file: use_key_in_widget_constructors, unused_import, depend_on_referenced_packages, prefer_const_constructors_in_immutables, non_constant_identifier_names, prefer_final_fields, prefer_interpolation_to_compose_strings, unnecessary_this, avoid_print, unused_local_variable, prefer_adjacent_string_concatenation, avoid_single_cascade_in_expression_statements, unrelated_type_equality_checks, prefer_const_constructors, use_build_context_synchronously, unnecessary_new, unused_element, avoid_unnecessary_containers, sized_box_for_whitespace

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart';
import 'package:new_admission_app/models/main_model.dart';
import 'package:new_admission_app/services/api_service.dart';
import 'package:intl/intl.dart';
import '../components/ui_assets.dart';
import '../drawer/nav-drawer.dart';


class SingleFormState extends StatefulWidget {
  SingleFormState();
  @override
  State<StatefulWidget> createState() {
    return SingleForm();
  }
}

class SingleForm extends State<SingleFormState> {

  APIService apiServices = APIService();
  var urlz = APIService.url ;
  bool _vis_value = false;
  late String stud_min_number ;
  String _user_type_sp = "";

  TextEditingController _StudMinNumberController_dump = TextEditingController();

  TextEditingController _StudFullNameCONT_dump = TextEditingController();
  TextEditingController _StudSchoolCONT_dump = TextEditingController();
  TextEditingController _StudFacCONT_dump = TextEditingController();
  TextEditingController _StudMajCONT_dump = TextEditingController();
  TextEditingController _StudBatchCONT_dump = TextEditingController();


  final _addFormKey = GlobalKey<FormState>();



  @override
  void initState() {
    super.initState();

    _vis_value  = false ;

    print('init here '+_vis_value.toString()) ;


    apiServices.getUserTypePreference().then(updateUserType);
  }

  void updateUserType(String userTypeSp) {
    setState(() {
      this._user_type_sp = userTypeSp;
      print('User Type From SP : ' + _user_type_sp.toString());
    });
  }


  Future<bool> get_Stud_Info() async {

    bool listValue = false ;

     String stud_min_number_dump_text , stud_name_dump_text ,stud_school_dump_text,stud_fac_dump_text ,stud_maj_dump_text  ,stud_bacth_dump_text;

    if(_StudMinNumberController_dump.text.toString() !=''){

      stud_min_number = _StudMinNumberController_dump.text.toString() ;

      final list = await apiServices.getStudentInfo(stud_min_number);

      print('My LIST : '+'${list[0].stud_min_number} \n ${list[0].stud_full_name} \n${list[0].stud_high_scool} \n');

      stud_min_number_dump_text = list[0].stud_min_number  ;
      stud_name_dump_text = list[0].stud_full_name  ;
      stud_school_dump_text = list[0].stud_high_scool  ;
      stud_fac_dump_text = list[0].faculty_desc  ;
      stud_maj_dump_text = list[0].major_desc  ;
      stud_bacth_dump_text = list[0].stud_batch  ;


      if(list == 0){
        listValue = false ;
      }else{
        listValue = true ;
      }


      setState(() {

        _StudFullNameCONT_dump..text = stud_name_dump_text.toString() ;
        _StudSchoolCONT_dump..text = stud_school_dump_text.toString() ;
        _StudFacCONT_dump..text = stud_fac_dump_text.toString() ;
        _StudMajCONT_dump..text = stud_maj_dump_text.toString() ;
        _StudBatchCONT_dump..text = stud_bacth_dump_text.toString() ;

      });






    }

    return  listValue ;

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
                    child: Text('Signel Student',
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
                      labelText: 'Enter MIN Number',
                      hintText: "Enter MIN Number",
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
                                                setState(() async {
                                                  _vis_value = true ;
                                                  stud_min_number = _StudMinNumberController_dump.text.toString() ;

                                                  if(_StudMinNumberController_dump.text.toString() != '') {
                                                   if( await get_Stud_Info() ){

                                                     Single_Student_Details(
                                                         context,
                                                         _StudMinNumberController_dump
                                                             .text.toString(),
                                                         _StudFullNameCONT_dump
                                                             .text.toString(),
                                                         _StudSchoolCONT_dump
                                                             .text.toString(),
                                                         _StudFacCONT_dump.text
                                                             .toString(),
                                                         _StudMajCONT_dump.text
                                                             .toString(),
                                                         _StudBatchCONT_dump.text
                                                             .toString());

                                                   }else{
                                                     Alert_Dialog(context,"No Student","No Student with this MIN number !");
                                                   }


                                                  }else{
                                                    Alert_Dialog(context, "Oops", "ENTER MIN Number");
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





final _addFormKey2 = GlobalKey<FormState>();
final  APIService apiServices = new APIService();

TextEditingController _StudMinNumberController = TextEditingController();
TextEditingController _StudNameController = TextEditingController();
TextEditingController _StudSchoolController = TextEditingController();
TextEditingController _StudFacultyController = TextEditingController();
TextEditingController _StudMajorController = TextEditingController();
TextEditingController _StudBatchController = TextEditingController();

TextEditingController _info_stud_nameENController = TextEditingController();
TextEditingController _info_stud_phoneController = TextEditingController();
TextEditingController info_stud_parents_phoneController = TextEditingController();
TextEditingController _info_stud_emailController = TextEditingController();

TextEditingController _info_stud_precentController = TextEditingController();
TextEditingController _info_stud_accdemicController = TextEditingController();
TextEditingController _info_stud_id_numberController = TextEditingController();
TextEditingController _info_stud_dobController = TextEditingController();

TextEditingController _info_stud_addressController = TextEditingController();
TextEditingController _info_stud_statusController = TextEditingController();


/*
info_stud_name_en ;
info_stud_phone ;
info_stud_parents_phone ;
info_stud_email ;
info_stud_precent ;
info_stud_accdemic ;
info_stud_id_number ;
info_stud_dob ;
info_stud_address ;
info_stud_status ;
*/

Future<void> Single_Student_Details(BuildContext context,String studMinNumber,String studName,
    String studSchool,String studFaculty,String studMajor,String studBatch) async {

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
                              controller: _StudSchoolController
                                ..text = studSchool.toString(),
                              decoration: InputDecoration(
                                  labelText: 'Stud School',
                                  hintText: "Stud School",
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

                          Container(
                              child: TextField(
                                controller: _info_stud_nameENController ,
                                decoration: InputDecoration(
                                    labelText: 'Stud Full Name EN',
                                    hintText: "Stud Full Name EN",
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
                          Container(
                              child: TextField(
                                controller: _info_stud_phoneController ,
                                decoration: InputDecoration(
                                    labelText: 'Stud Phone',
                                    hintText: "Stud Phone",
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
                          Container(
                              child: TextField(
                                controller: info_stud_parents_phoneController  ,
                                decoration: InputDecoration(
                                    labelText: 'Stud Parents Phone',
                                    hintText: "Stud Parents Phone",
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
                          Container(
                              child: TextField(
                                controller: _info_stud_emailController ,
                                decoration: InputDecoration(
                                    labelText: 'Stud Email',
                                    hintText: "Stud Email",
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
                          Container(
                              child: TextField(
                                controller: _info_stud_precentController,
                                decoration: InputDecoration(
                                    labelText: 'High School Percent %',
                                    hintText: "High School Percent %",
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
                          Container(
                              child: TextField(
                                controller: _info_stud_accdemicController,
                                decoration: InputDecoration(
                                    labelText: 'Stud Academy Type',
                                    hintText: "Stud Academy Type",
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
                          Container(
                              child: TextField(
                                controller: _info_stud_id_numberController,
                                decoration: InputDecoration(
                                    labelText: 'Stud ID Number',
                                    hintText: "Stud ID Number",
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
            Container(
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _info_stud_dobController, //editing controller of this TextField
                    decoration: InputDecoration(

                        labelText: "Enter DoB" //label text of field
                    ),
                    readOnly: true,  //set it true, so that user will not able to edit text
                    onTap: () async {
                      final now = DateTime.now();
                      DateTime? pickedDate = await showDatePicker(
                          context: context, initialDate: DateTime.now(),
                          firstDate: DateTime(1900), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101)
                      );

                      if(pickedDate != null ){
                        print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate = DateFormat('yyyy/MM/dd').format(pickedDate);

                        print(formattedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                          _info_stud_dobController.text = formattedDate; //set output date to TextField value.

                      }else{
                        print("Date is not selected");
                      }
                    },
                  ),
                ],
              ),
            ),
                          Container(
                              child: TextField(
                                controller: _info_stud_addressController,
                                decoration: InputDecoration(
                                    labelText: 'Stud Address',
                                    hintText: "Stud Address",
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
                      child: Text('Update',style: TextStyle(color: Colors.white)),
                      onPressed: () {



  if(_StudMinNumberController.text.toString() !='' && _StudNameController.text.toString() !='' && _StudSchoolController.text.toString() !='' && _StudFacultyController.text.toString() !=''
  && _StudMajorController.text.toString() !='' && _StudBatchController.text.toString() !='' && _info_stud_nameENController.text.toString() !='' &&_info_stud_phoneController.text.toString() !='' &&
      info_stud_parents_phoneController.text.toString() !='' && _info_stud_emailController.text.toString() !='' && _info_stud_precentController.text.toString() !=''  && _info_stud_accdemicController.text.toString() !=''
  && _info_stud_id_numberController.text.toString() !='' && _info_stud_dobController.text.toString() !='' && _info_stud_addressController.text.toString() !=''){



    apiServices.Update_Stud_Info(context , _StudMinNumberController.text.toString() , _info_stud_nameENController.text.toString() , _info_stud_phoneController.text.toString() ,
        info_stud_parents_phoneController.text.toString() , _info_stud_emailController.text.toString() , _info_stud_precentController.text.toString() , _info_stud_accdemicController.text.toString() ,
        _info_stud_id_numberController.text.toString() , _info_stud_dobController.text.toString() , _info_stud_addressController.text.toString()) ;


    _info_stud_nameENController.text = "" ;
    _info_stud_phoneController.text = "" ;
    info_stud_parents_phoneController.text = "" ;
    _info_stud_emailController.text = "" ;
    _info_stud_precentController.text = "" ;
    _info_stud_accdemicController.text = "" ;
    _info_stud_id_numberController.text = "" ;
    _info_stud_dobController.text = "" ;
    _info_stud_addressController.text = "" ;

  }else{
    Alert_Dialog(context,"Error","all filed are required !");
  }



                      },
                    ),
                  ],
                ),
              ],
            )
        )
      ],);
    },);
}

