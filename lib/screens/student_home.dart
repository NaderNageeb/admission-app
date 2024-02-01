// ignore_for_file: depend_on_referenced_packages, use_key_in_widget_constructors, library_private_types_in_public_api, non_constant_identifier_names, prefer_final_fields, avoid_print, avoid_single_cascade_in_expression_statements, prefer_interpolation_to_compose_strings, unnecessary_this, prefer_const_constructors, avoid_unnecessary_containers, unnecessary_null_comparison, unnecessary_new, unused_element, unused_local_variable, sized_box_for_whitespace

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../components/ui_assets.dart';
import '../drawer/nav-drawer.dart';
import '../services/api_service.dart';


class StudentHomePage extends StatefulWidget {
  @override
  _StudentHomePage createState() => _StudentHomePage();
}


class _StudentHomePage extends State<StudentHomePage> {

  String _stud_min_number_sp = "" ;
  String _stud_name_sp = "" ;
  String _stud_school_sp = "" ;
  String _stud_fac_sp = "" ;
  String _stud_maj_sp = "" ;
  String _stud_batch_sp = "" ;
  String _stud_type_sp = "" ;
  String _user_ID_sp = "0" ;

  APIService apiServices = APIService();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  late TextEditingController min_number_CON,stud_name_CON,stud_school_CON,stud_fac_CON,stud_maj_CON,stud_batch_CON;
  late TextEditingController info_stud_name_en_CON,info_stud_phone_CON,info_stud_parents_phone_CON,info_stud_email_CON,info_stud_precent_CON,info_stud_accdemic_CON;
  late TextEditingController info_stud_id_number_CON , info_stud_dob_CON , info_stud_address_CON ,info_stud_status_CON , info_date_CON ;

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  late String stud_min_number_dump_text , stud_name_dump_text ,stud_school_dump_text,stud_fac_dump_text ,stud_maj_dump_text  ,stud_bacth_dump_text;

  late String info_stud_name_en = "",info_stud_phone= "",info_stud_parents_phone= "",info_stud_email= "" ,info_stud_precent = "" ,info_stud_accdemic = "";
  late String info_stud_id_number = "" , info_stud_dob = "",info_stud_address = "",info_stud_status = "",info_date = "";


  @override
  void initState() {

    super.initState();

    min_number_CON = TextEditingController();
    stud_name_CON = TextEditingController();
    stud_school_CON = TextEditingController();
    stud_fac_CON = TextEditingController();
    stud_maj_CON = TextEditingController();
    stud_batch_CON = TextEditingController();

    info_stud_name_en_CON = TextEditingController();
    info_stud_phone_CON = TextEditingController();
    info_stud_parents_phone_CON = TextEditingController();
    info_stud_email_CON = TextEditingController();
    info_stud_precent_CON = TextEditingController();
    info_stud_accdemic_CON = TextEditingController();

    info_stud_id_number_CON =  TextEditingController();
    info_stud_dob_CON =  TextEditingController();
    info_stud_address_CON =  TextEditingController();
    info_stud_status_CON =  TextEditingController();
    info_date_CON =  TextEditingController();


    apiServices.getStudMinPreference().then(updateStudMinNumber);
    apiServices.getStudNamePreference().then(updateStudName);
    apiServices.getStudSchoolPreference().then(updateStudSchool);
    apiServices.getStudFacPreference().then(updateStudFac);
    apiServices.getStudMajPreference().then(updateStudMaj);
    apiServices.getStudBatchPreference().then(updateStudBatch);
    apiServices.getStudTypePreference().then(updateStudType);

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        get_Stud_Info();
      });

    });
  }

  Future<void> get_Stud_Info() async {

      final list = await apiServices.getStudentInfoAfterFill(_stud_min_number_sp.toString(),_user_ID_sp.toString(),_stud_type_sp.toString());


    print( 'Student List : ${list[0].stud_min_number} \n ${list[0].info_stud_name_en} \n${list[0].faculty_desc} \n');
    print( '\n Student Details : ${list[0].info_stud_name_en} \n ${list[0].info_stud_phone} \n${list[0].info_stud_parents_phone} \n');

      stud_min_number_dump_text = list[0].stud_min_number  ;
      stud_name_dump_text = list[0].stud_full_name  ;
      stud_fac_dump_text = list[0].faculty_desc  ;
      stud_maj_dump_text = list[0].major_desc  ;
      stud_bacth_dump_text = list[0].stud_batch  ;
      stud_school_dump_text = list[0].stud_high_scool  ;

    info_stud_name_en = list[0].info_stud_name_en  ;
    info_stud_phone = list[0].info_stud_phone  ;
    info_stud_parents_phone = list[0].info_stud_parents_phone  ;
    info_stud_email = list[0].info_stud_email  ;
    info_stud_precent = list[0].info_stud_precent  ;
    info_stud_accdemic = list[0].info_stud_accdemic  ;
    info_stud_id_number = list[0].info_stud_id_number  ;
    info_stud_dob = list[0].info_stud_dob  ;
    info_stud_address = list[0].info_stud_address  ;
    info_stud_status = list[0].info_stud_status  ;
    info_date = list[0].info_date  ;

      //Filled Data//

      setState(() {
        stud_name_CON..text = stud_name_dump_text.toString() ;

        stud_fac_CON..text = stud_fac_dump_text.toString() ;
        stud_maj_CON..text = stud_maj_dump_text.toString() ;
        stud_batch_CON..text = stud_bacth_dump_text.toString() ;
        stud_school_CON..text = stud_school_dump_text.toString();


            //if info_stud_name_en not Null , assign the values to Cons//

        if(info_stud_name_en !='') {

          info_stud_name_en_CON..text = info_stud_name_en.toString();
          info_stud_phone_CON..text = info_stud_phone.toString();
          info_stud_parents_phone_CON..text = info_stud_parents_phone.toString();
          info_stud_email_CON..text = info_stud_email.toString();
          info_stud_precent_CON..text = info_stud_precent.toString();
          info_stud_accdemic_CON..text = info_stud_accdemic.toString();
          info_stud_id_number_CON..text = info_stud_id_number.toString();
          info_stud_dob_CON..text = info_stud_dob.toString();
          info_stud_address_CON..text = info_stud_address.toString();

          info_stud_status_CON..text = info_stud_status.toString();
          info_date_CON..text = info_date.toString();

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
                    Icon(Icons.add_task, color: Color(0xFF59363b)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('Student Main Info',
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
                                  ..text = _stud_name_sp.toString(),
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
                            Container(
                              child: TextField(
                                enabled: false,
                                controller: stud_school_CON
                                  ..text = _stud_school_sp.toString(),
                                decoration: InputDecoration(
                                    labelText: 'School',
                                    hintText: "School",
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

                            const SizedBox(height: 5),


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
                                          fixedSize: Size.fromWidth(160),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 1, horizontal: 20),
                                        ),
                                        onPressed: () async {
                                          if (globalFormKey.currentState!.validate()) {
                                            setState(() {
                                            });
                                            apiServices.checkInternetConnnection().then((intenet) async {
                                              if (intenet != null && intenet) {

                                                if(min_number_CON.text.toString() != '') {

                                                    Single_Student_Details(
                                                        context,
                                                        min_number_CON
                                                            .text.toString(),
                                                        stud_name_CON
                                                            .text.toString(),
                                                        stud_school_CON
                                                            .text.toString(),
                                                        stud_fac_CON.text
                                                            .toString(),
                                                        stud_maj_CON.text
                                                            .toString(),
                                                        stud_batch_CON.text
                                                            .toString() , info_stud_name_en.toString(),info_stud_phone.toString() , info_stud_parents_phone.toString() ,
                                                        info_stud_email.toString() , info_stud_precent.toString() ,info_stud_accdemic.toString(),info_stud_id_number.toString() , info_stud_dob.toString() ,
                                                        info_stud_address.toString() , info_stud_status.toString() , info_date.toString()

                                                    );
                                                }else{
                                                  Alert_Dialog(context, "Oops", "ENTER MIN Number");
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
                                            );
                                          }
                                        },
                                        child: Text("Update Basic Info"),
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

Future<void> Single_Student_Details(BuildContext context,String studMinNumber,String studName,
    String studSchool,String studFaculty,String studMajor,String studBatch ,String info_stud_name_en ,String info_stud_phone ,String info_stud_parents_phone
   , String info_stud_email ,String info_stud_precent,String info_stud_accdemic , String info_stud_id_number,String info_stud_dob,String info_stud_address ,String info_stud_status ,
    String info_date
    ) async {

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
                                controller: _info_stud_nameENController..text = info_stud_name_en.toString() ,
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
                                controller: _info_stud_phoneController..text = info_stud_phone.toString() ,
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
                                controller: info_stud_parents_phoneController..text = info_stud_parents_phone.toString() ,
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
                                controller: _info_stud_precentController..text = info_stud_precent.toString(),
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
                                controller: _info_stud_id_numberController..text =info_stud_id_number.toString(),
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






