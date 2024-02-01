
// ignore_for_file: unnecessary_import, depend_on_referenced_packages, library_private_types_in_public_api, unnecessary_new, non_constant_identifier_names, prefer_interpolation_to_compose_strings, unnecessary_this, avoid_print, prefer_const_constructors, avoid_unnecessary_containers, unnecessary_null_comparison, prefer_adjacent_string_concatenation

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import '../components/ui_assets.dart';
import '../drawer/nav-drawer.dart';
import '../services/api_service.dart';
import 'package:dio/dio.dart';


class UploadStudents extends StatefulWidget {
  const UploadStudents({super.key});

  @override
  _UploadStudents createState() => _UploadStudents();
}

class _UploadStudents extends State<UploadStudents> {


  APIService apiServices = APIService();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

      String? filePath;
      File? selectedfile ;
      late Response response;
      String? progress ;
      Dio dio = new Dio();
      String? fileName ;
      String _user_type_sp = "";

  var url = APIService.url ;

  @override
  void initState() {

    super.initState();
    apiServices.getUserTypePreference().then(updateUserType);
  }

  void updateUserType(String userTypeSp){
    setState(() {
      this._user_type_sp = userTypeSp ;
      print('User Type From SP : '+ _user_type_sp.toString());
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        drawer:NavDrawer(user_type: _user_type_sp.toString()),
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
        body: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(40),
            child:Column(children: <Widget>[

              Container(
                margin: EdgeInsets.all(10),
                //show file name here
                child:progress == null?
                Text("Progress: 0%"):
                Text(basename("Progress: $progress"),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),),
              ),
              Container(
                margin: EdgeInsets.all(10),
                //show file name here
                child:selectedfile == null?
                Text("Choose CSV File"):
                Text(basename(selectedfile!.path)),
              ),
              Container(
                  child:ElevatedButton.icon(
                    onPressed: (){
                      _pickFile();
                    },
                    icon: Icon(Icons.folder_open),
                    label: Text("Pick CSV FILE"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:Color(0xFF59363b),
                        fixedSize: Size.fromWidth(160),
                        padding: const EdgeInsets.symmetric(
                            vertical: 1, horizontal: 20),
                      )
                  )
              ),
              selectedfile == null?
              Container():
              Container(
                  child:ElevatedButton.icon(
                    onPressed: (){
                      uploadFile(context,fileName.toString());
                    },
                    icon: Icon(Icons.folder_open),
                    label: Text("Upload CSV"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:Color(0xFF59363b),
                        fixedSize: Size.fromWidth(155),
                        padding: const EdgeInsets.symmetric(
                            vertical: 1, horizontal: 20),
                      )
                  )
              ),
            ],)
        )
    );
  }

  void _pickFile() async {

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    setState((){
      if (result != null) {
        //if there is selected file
        selectedfile = File(result.files.single.path.toString());
         fileName = basename(selectedfile!.path.toString());
      }
    });
  }


  uploadFile(context,String filenamedump) async {

    String upload_url = url+"?upload_file";

    FormData formdata = FormData.fromMap({
      "file": await MultipartFile.fromFile(
          selectedfile!.path,
          filename: basename(selectedfile!.path)
      ),
    });
    
    print('DATA : ' + formdata.toString()) ;
    response = await dio.post(upload_url,
      data: formdata,
      onSendProgress: (int sent, int total) {
        String percentage = (sent/total*100).toStringAsFixed(2);
        setState(() {
          progress = "$sent" + " Bytes of " "$total Bytes - " +  percentage + " % uploaded";
          //update the progress
        });
      },);

    print('CSV RESPONSE '+response.toString()) ;

    if(response.statusCode == 200){

      if(filenamedump != null){
        apiServices.insertCSV(context,filenamedump.toString());
      }
      print(response.toString());
      //print response from server
    }else{
      print("Error during connection to server.");
      setState(() {
        Alert_Dialog(
            context, "Oops", "Cannot Upload CSV File !");
      });
    }
  }

}

