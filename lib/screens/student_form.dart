
// ignore_for_file: depend_on_referenced_packages, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, non_constant_identifier_names, unnecessary_null_comparison, prefer_interpolation_to_compose_strings, unnecessary_this, avoid_print, prefer_const_constructors, avoid_unnecessary_containers, duplicate_ignore, prefer_adjacent_string_concatenation, unnecessary_new, unused_element, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart';
import 'package:new_admission_app/models/main_model.dart';
import 'package:new_admission_app/services/api_service.dart';
import '../components/ui_assets.dart';
import '../drawer/nav-drawer.dart';


class StudentFormState extends StatefulWidget {
  StudentFormState();
  @override
  State<StatefulWidget> createState() {
    return StudentForm();
  }
}

class StudentForm extends State<StudentFormState> {

  APIService apiServices = APIService();
  var urlz = APIService.url ;
  String _user_type_sp = "";

  @override
  void initState() {
    super.initState();

    apiServices.checkInternetConnnection().then((intenet) async {
      if (intenet != null && intenet) {
        Get_STUD_List();
      }else{
        Alert_Dialog(context, "No Connection", "Make sure you have internet connection and try again !");
      }
    });
    apiServices.getUserTypePreference().then(updateUserType);
  }

  void updateUserType(String userTypeSp){
    setState(() {
      this._user_type_sp = userTypeSp ;
      print('User Type From SP : '+ _user_type_sp.toString());
    });
  }

  Future<List<StudMainData>> Get_STUD_List() async {
    String finalUrl  = urlz+'?GetStudentsFill' ;
    final response = await get(Uri.parse(finalUrl));

    if (response.statusCode == 200) {
      List stud_data = json.decode(utf8.decode(response.bodyBytes));
      return stud_data.map((stud_data) => StudMainData.fromJson(stud_data)).toList();
    } else {
      throw Exception('Error while getting the data , Check connections and try again !');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            drawer: NavDrawer(user_type: _user_type_sp.toString()),
          appBar: AppBar(
              // ignore: prefer_const_constructors
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
                        child: Text('View Students Filled Forms ',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: Colors.brown)),
                      ),
                      Icon(Icons.wb_sunny, color: Colors.transparent),
                    ],
                  ),
                  const  SizedBox(height: 10),
                  Expanded(
                    child: FutureBuilder<List<StudMainData>>(
                      future: Get_STUD_List(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return  Center(
                              child: Center(
                                  child:  Container (
        child: const Text('No Students Data !',style: TextStyle(fontSize: 18,color: Colors.brown)),
                                  )
                              ));
                        }else{
                          return Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            color:  Colors.white,
                            child: ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index)
                                {
                                  StudMainData Get_Studnets_Lists = snapshot.data![index];

                                  return Slidable(
                                    //child:  Screenshot(
                                    //controller: screenshotController,
                                    child: Container(
                                      color: Colors.white,
                                      child: ListTile(
                                        leading: const CircleAvatar(
                                          backgroundColor: Colors.brown,
                                          foregroundColor: Colors.white,
                                          child: Icon(Icons.list_alt_outlined),
                                        ),
                                        title: Text('Min # : ${Get_Studnets_Lists.stud_min_number}',style: const TextStyle( color:Colors.black87,fontSize: 16) ),
                                        subtitle: Text('Name  : ${Get_Studnets_Lists.stud_full_name} '
                                            +'\n'+'School : ${Get_Studnets_Lists.stud_high_scool}' ,
                                            style: const TextStyle( color:Colors.black87,fontSize: 20)
                                        ),
                                        onTap: () {
Student_Details(context , Get_Studnets_Lists.stud_min_number, Get_Studnets_Lists.stud_full_name,
  Get_Studnets_Lists.stud_high_scool,Get_Studnets_Lists.faculty_desc,Get_Studnets_Lists.major_desc , Get_Studnets_Lists.stud_batch ,
  Get_Studnets_Lists.info_stud_name_en,Get_Studnets_Lists.info_stud_phone,Get_Studnets_Lists.info_stud_parents_phone , Get_Studnets_Lists.info_stud_email ,

  Get_Studnets_Lists.info_stud_precent,Get_Studnets_Lists.info_stud_accdemic,Get_Studnets_Lists.info_stud_id_number , Get_Studnets_Lists.info_stud_dob ,
  Get_Studnets_Lists.info_stud_address,Get_Studnets_Lists.info_stud_status,Get_Studnets_Lists.info_date 
  
) ;

                                        },
                                      ),
                                    ),
                                  );
                                }
                            ) ,
                          );
                        }
                      },
                    ),
                  ),
                ],
              )
          ),
    );
  }
}


final _addFormKey = GlobalKey<FormState>();
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

Future<void> Student_Details(BuildContext context,String stud_min_number,String stud_name,
    String stud_school,String stud_faculty,String stud_major,String stud_batch, 
    String info_stud_name_en, String info_stud_phone, String info_stud_parents_phone, 
    String info_stud_email, String info_stud_precent, String info_stud_accdemic, String info_stud_id_number, 
    String info_stud_dob, String info_stud_address, String info_stud_status, String info_date) async {


  return showDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) {
      return AlertDialog(

        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0)
        ),
        title: Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          color: Color(0xFF59363b),
          child:  Text('Min NUmber : '+ stud_min_number.toString() , textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white)),
        ),

        titlePadding: const EdgeInsets.all(0),

        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Form(
                      key: _addFormKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: TextField(
                              enabled: false,
                              controller: _StudMinNumberController
                                ..text = stud_min_number.toString(),
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
                              controller: _StudNameController
                                ..text = stud_name.toString(),
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
                                ..text = stud_school.toString(),
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
                                ..text = stud_faculty.toString(),
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
                                ..text = stud_major.toString(),
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
                                  ..text = stud_batch.toString(),
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

                          /*
    String info_stud_name_en, String info_stud_phone, String info_stud_parents_phone,
    String info_stud_email, String info_stud_precent, String info_stud_accdemic, String info_stud_id_number,
    String info_stud_dob, String info_stud_address, String info_stud_status, String info_date)
                           */

                          Container(
                              child: TextField(
                                controller: _info_stud_nameENController..text = info_stud_name_en.toString(),
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
                                controller: _info_stud_phoneController..text = info_stud_phone.toString(),
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
                                controller: info_stud_parents_phoneController..text = info_stud_parents_phone.toString()  ,
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
                                controller: _info_stud_emailController..text = info_stud_email.toString() ,
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
                                controller: _info_stud_precentController..text = info_stud_precent.toString()+"%",
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
                                controller: _info_stud_accdemicController..text = info_stud_accdemic.toString(),
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
                                controller: _info_stud_id_numberController..text = info_stud_id_number.toString(),
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
                              child: TextField(
                                controller: _info_stud_dobController..text = info_stud_dob.toString(),
                                decoration: InputDecoration(
                                    labelText: 'DoB',
                                    hintText: "DoB",
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
                                controller: _info_stud_addressController..text = info_stud_address.toString(),
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
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: <Widget>[
                //     TextButton(
                //       style: TextButton.styleFrom(backgroundColor: Color(0xFF59363b)),
                //       onPressed: () {
                //         Navigator.of(context).pop() ;
                //       },
                //       child: Text('Cancel',style: TextStyle(color:Colors.white)),
                //     ),
                //     const SizedBox(width: 5),
                //     TextButton(
                //       style: TextButton.styleFrom(backgroundColor: Colors.green),
                //       child: Text('Update',style: TextStyle(color: Colors.white)),
                //       onPressed: () {
                //
                //       },
                //     ),
                //   ],
                // ),
              ],
            )
        )
      ],);
    },);
}

