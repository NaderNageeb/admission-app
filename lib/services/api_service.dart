// ignore_for_file: depend_on_referenced_packages, prefer_interpolation_to_compose_strings, unnecessary_brace_in_string_interps, non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print, prefer_const_constructors, null_argument_to_non_null_type, deprecated_member_use

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:new_admission_app/components/ui_assets.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/main_model.dart';

class APIService {
  //10.0.2.2
  //Connection MSG//
  String conn_title = " Connection Time Out ";
  String conn_string =
      " Can't connect to server make sure you have a good connection and try again ! ";

// emulator id
  //  static var url = "http://10.0.2.2:8000/admission_app/index.php";

  static var url = "http://10.0.2.2/admission_app/index.php";

  // static var url = "http://192.168.43.63/admission_app/index.php";

  //Geny IP 10.0.3.2

//Check Connections//
  Future<bool> checkInternetConnnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

////////////////Login////Login////////////////
  Future<String> userLoginIn(
      context, String username, String password, scaffoldKey) async {
    var loginUrl = url + "?login";

    late String loginStatus;
    var dump_res;
    var jsonValue;
    var res;
    var user_id;
    var user_type;
    var user_pass;

    var data = {
      "username": username.toString(),
      "pass": password.toString(),
    };

    res = await http.post(Uri.parse(loginUrl), body: data).timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        Alert_Dialog(context, conn_title, conn_string);
        loginStatus = "conn_fail";
        return Future.value(res);
      },
    );

    print(res.toString());

    print('Login Res :' + res.body.toString());

    dump_res = jsonDecode(res.body)['result'];

    if (dump_res.toString() != 'NULL') {
      jsonValue = dump_res[0];
      user_id = jsonValue['user_id'].toString();
      user_type = jsonValue['user_type'].toString();
      user_pass = jsonValue['user_pass'].toString();

      // if(await ClearPreference()){

      if (await savedUserPreference(
          user_id.toString(), username.toString(), user_type.toString())) {
        print(
            'User ID  : ${user_id} , User Pass : $user_pass , User Type : $user_type');

        loginStatus = 'exist';
      }

      // }
    } else {
      loginStatus = 'wrong';
      print('RESULT IS NULL !');
    }

    print('User Name ' + username.toString());
    print('User Pass ' + password.toString());

    print('loginStatus ' + loginStatus.toString());

    return loginStatus;
  }

  ////////////////Login////Login////////////////
  Future<String> StudentsLoginIn(
      context, String min_number, scaffoldKey) async {
    var loginUrl = url + "?Studentlogin";

    late String loginStatus;
    var dump_res;
    var jsonValue;
    var res;

    var stud_name;
    var stud_school;
    var stud_fac;
    var stud_maj;
    var stud_batch;
    var stud_type;

    var data = {
      "min_number": min_number.toString(),
    };

    res = await http.post(Uri.parse(loginUrl), body: data).timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        Alert_Dialog(context, conn_title, conn_string);
        loginStatus = "conn_fail";
        return Future.value(res);
      },
    );

    print(res.toString());

    print('Student Login Res :' + res.body.toString());

    dump_res = jsonDecode(res.body)['result'];

    if (dump_res.toString() != 'NULL' && dump_res.toString() != 'DateError') {
      jsonValue = dump_res[0];

      stud_name = jsonValue['stud_full_name'].toString();
      stud_school = jsonValue['stud_high_scool'].toString();
      stud_fac = jsonValue['faculty_desc'].toString();
      stud_maj = jsonValue['major_desc'].toString();
      stud_batch = jsonValue['stud_batch'].toString();
      stud_type = jsonValue['user_type'].toString();

      if (await savedStudentPreference(
          min_number.toString(),
          stud_name.toString(),
          stud_school.toString(),
          stud_fac.toString(),
          stud_maj.toString(),
          stud_batch.toString(),
          stud_type.toString())) {
        print(
            'Min Number   : ${min_number} , Stud Name : $stud_name , Stud Type : $stud_type');
      }

      loginStatus = 'exist';
    }
    if (dump_res.toString() == 'DateError') {
      loginStatus = 'DateError';
      print('RESULT IS DateError !');
    }
    if (dump_res.toString() == 'NULL') {
      loginStatus = 'Wrong';
      print('Wrong STUD MIN Numebr !');
    }

    print('loginStatus ' + loginStatus.toString());
    return loginStatus;
  }

  Future<String> UpdateAdmssionDates(
    context,
    String start_date,
    String end_date,
  ) async {
    var Url = url + "?UpdateAdmssionDates";
    String finalStatus = '';
    var dump_res;
    var res;

    var data = {
      "start_date": start_date.toString(),
      "end_date": end_date.toString(),
    };

    res = await http.post(Uri.parse(Url), body: data).timeout(
      Duration(seconds: 60),
      onTimeout: () {
        Alert_Dialog(context, conn_title, conn_string);
        finalStatus = 'conn_fail';
        return Future.value(res);
      },
    );

    print(data.toString());

    dump_res = jsonDecode(res.body)['admission_res'];

    print('Response ' + dump_res.toString());

    if (dump_res.toString() == 'Updated') {
      finalStatus = 'Updated';

      Info_Dialog(
          context, "Added", "Admission Start - End date Successfully Added !");
    }

    if (dump_res.toString() == 'Error') {
      finalStatus = 'Error';
      Alert_Dialog(
          context, "Oops", "Error While Adding Admissions Start - End date !");
    }

    print('Status ' + finalStatus.toString());
    return finalStatus;
  }

  //addNewUSer_API//
  Future<String> addNewUser_API(
      context,
      String user_name,
      String user_full_name,
      String user_type,
      String user_faculty,
      scaffoldKey) async {
    var AdDUserUrl = url + "?addNewUser";
    String finalStatus = '';
    var dump_res;
    var res;

    var data = {
      "user_name": user_name.toString(),
      "user_full_name": user_full_name.toString(),
      "user_type": user_type.toString(),
      "user_faculty": user_faculty.toString(),
    };

    res = await http.post(Uri.parse(AdDUserUrl), body: data).timeout(
      Duration(seconds: 60),
      onTimeout: () {
        Alert_Dialog(context, conn_title, conn_string);
        finalStatus = 'conn_fail';
        return Future.value(res);
      },
    );

    print(data.toString());

    dump_res = jsonDecode(res.body)['user_result'];

    print('Response ' + dump_res.toString());

    if (dump_res.toString() == 'Exist') {
      finalStatus = 'Exist';
      print('User IS Exist !');
      Alert_Dialog(context, "Exist",
          "User " + user_full_name.toString() + " Already Exist !");
    }

    if (dump_res.toString() == 'Inserted') {
      finalStatus = 'Inserted';
      print('User IS Inserted !');
      Info_Dialog(context, "Added",
          "User " + user_full_name.toString() + " Successfully Added !");
    }

    if (dump_res.toString() == 'Error') {
      finalStatus = 'Error';
      print('User IS NOT Added !');
      Alert_Dialog(context, "Oops",
          "User " + user_full_name.toString() + " NOT Added !");
    }

    print('Status ' + finalStatus.toString());
    return finalStatus;
  }

  //Get Student Data //
  Future<List<StudData>> getStudentInfo(String stud_id) async {
    String urlz = url + '?GetStudInfo&stud_id=' + stud_id.toString();
    final response = await get(Uri.parse(urlz));

    if (response.statusCode == 200) {
      List stud_data = json.decode(response.body);
      return stud_data
          .map((stud_data) => StudData.fromJson(stud_data))
          .toList();
    } else {
      throw Exception(
          'Error while getting  List , Check connections and try again !');
    }
  }

  //Get Student Data //
  Future<List<StudMainData>> getStudentInfoAfterFill(
      String stud_id, String user_id, String user_type) async {
    String urlz = url +
        '?GetStudInfoAfterFill&stud_id=' +
        stud_id.toString() +
        '&user_id=' +
        user_id.toString() +
        '&user_type=' +
        user_type.toString();
    final response = await get(Uri.parse(urlz));

    if (response.statusCode == 200) {
      List stud_data = json.decode(response.body);
      return stud_data
          .map((stud_data) => StudMainData.fromJson(stud_data))
          .toList();
    } else {
      throw Exception(
          'Error while getting Student Data , Check connections and try again !');
    }
  }

  //Get Student Progres //
  Future<List<StudentConfirm>> getStudenProgress(String stud_id) async {
    String urlz = url + '?StudentProgress&stud_id=' + stud_id.toString();
    final response = await get(Uri.parse(urlz));

    if (response.statusCode == 200) {
      List stud_data = json.decode(response.body);
      return stud_data
          .map((stud_data) => StudentConfirm.fromJson(stud_data))
          .toList();
    } else {
      throw Exception(
          'Error while getting Student Progress Data , Check connections and try again !');
    }
  }

  Future<String> insertCSV(context, String file_name) async {
    var RequestTripURl = url + "?open_csv";
    String finalStatus = '';
    var dump_res;
    var res;
    var data = {
      "file_name": file_name.toString(),
    };

    res = await http.post(Uri.parse(RequestTripURl), body: data).timeout(
      Duration(seconds: 60),
      onTimeout: () {
        Alert_Dialog(context, conn_title, conn_string);
        finalStatus = 'conn_fail';
        return Future.value(null);
      },
    );

    dump_res = jsonDecode(res.body)['csv_file_result'];

    print(' Res :' + res.toString());

    if (dump_res.toString() == 'Inserted') {
      finalStatus = 'Inserted';

      Info_Dialog(context, "CSV Inserted", "Students List has been inserted !");
    }

    if (dump_res.toString() == 'Error') {
      finalStatus = 'Error';
      Alert_Dialog(
          context, "Oops", "Students List not inserted, Or already Exist !");
    }
    print('Status ' + finalStatus.toString());
    return finalStatus;
  }

  Future<String> Update_Stud_Info(
      context,
      String stud_min_number,
      String info_stud_name_en,
      String info_stud_phone,
      String info_stud_parents_phone,
      String info_stud_email,
      String info_stud_precent,
      String info_stud_accdemic,
      String info_stud_id_number,
      String info_stud_dob,
      String info_stud_address) async {
    var RequestTripURl = url + "?update_stud";
    String finalStatus = '';
    var dump_res;
    var res;
    var data = {
      "stud_min_number": stud_min_number.toString(),
      "info_stud_name_en": info_stud_name_en.toString(),
      "info_stud_phone": info_stud_phone.toString(),
      "info_stud_parents_phone": info_stud_parents_phone.toString(),
      "info_stud_email": info_stud_email.toString(),
      "info_stud_precent": info_stud_precent.toString(),
      "info_stud_accdemic": info_stud_accdemic.toString(),
      "info_stud_id_number": info_stud_id_number.toString(),
      "info_stud_dob": info_stud_dob.toString(),
      "info_stud_address": info_stud_address.toString(),
    };

    res = await http.post(Uri.parse(RequestTripURl), body: data).timeout(
      Duration(seconds: 60),
      onTimeout: () {
        Alert_Dialog(context, conn_title, conn_string);
        finalStatus = 'conn_fail';
        return Future.value(null);
      },
    );

    dump_res = jsonDecode(res.body)['stud_info'];

    print(' Res :' + res.toString());

    if (dump_res.toString() == 'Updated') {
      finalStatus = 'Inserted';

      Info_Dialog(context, "Data Updated", "Students Data has been Updated !");
    }

    if (dump_res.toString() == 'Exist') {
      finalStatus = 'Exist';
      Alert_Dialog(context, "Oops", "Students Data already Exist !");
    }

    print('Status ' + finalStatus.toString());
    return finalStatus;
  }

//Stud_Confirmation//
  Future<String> Stud_Confim(
      context,
      String stud_min,
      String conf_status,
      String conf_comment,
      String admission_fees,
      String user_type,
      String user_id,
      scaffoldKey) async {
    var ConfUrl = url + "?Confirmation";
    String finalStatus = '';
    var dump_res;
    var res;

    var data = {
      "stud_min": stud_min.toString(),
      "conf_status": conf_status.toString(),
      "conf_comment": conf_comment.toString(),
      "admission_fees": admission_fees.toString(),
      "user_type": user_type.toString(),
      "user_id": user_id.toString(),
    };

    res = await http.post(Uri.parse(ConfUrl), body: data).timeout(
      Duration(seconds: 60),
      onTimeout: () {
        Alert_Dialog(context, conn_title, conn_string);
        finalStatus = 'conn_fail';
        return Future.value(res);
      },
    );

    print(data.toString());

    dump_res = jsonDecode(res.body)['conf_result'];

    print('Response ' + dump_res.toString());

    if (dump_res.toString() == 'Exist') {
      finalStatus = 'Exist';
      print('STUD IS Exist !');
      Alert_Dialog(
          context,
          "Exist",
          "Student With Number " +
              stud_min.toString() +
              " Already Confirmed !");
    }

    if (dump_res.toString() == 'Confirmed') {
      finalStatus = 'Confirmed';
      print('STUD IS Confirmed !');
      Info_Dialog(
          context,
          "Confirmed",
          "Student With Number " +
              stud_min.toString() +
              " Successfully Confirmed !");
    }

    if (dump_res.toString() == 'Error') {
      finalStatus = 'Error';
      print(finalStatus.toString());
      Alert_Dialog(context, "Oops", "Error while Confirmation !");
    }

    print('Confirmation Status ' + finalStatus.toString());
    return finalStatus;
  }

  Future<bool> ClearPreference() async {
    bool myPrefValue = false;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (await prefs.clear()) {
      myPrefValue = true;
    } else {
      myPrefValue = true;
    }

    return myPrefValue;
  }

  Future<bool> savedUserPreference(
      String user_id, String user_name, String user_type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (await prefs.clear() == true) {
      prefs.setString("user_id_sp", user_id);
      prefs.setString("user_name_sp", user_name);
      prefs.setString("user_type_sp", user_type);
    }

    return prefs.commit();
  }

  Future<String> getUserTypePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user_type_sp = prefs.getString("user_type_sp").toString();
    return user_type_sp;
  }

  Future<String> getUserIDPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user_id_sp = prefs.getString("user_id_sp").toString();
    return user_id_sp;
  }

  Future<bool> savedStudentPreference(
      String min_number,
      String stud_name,
      String sud_school,
      String stud_fac,
      String stud_maj,
      stud_batch,
      String stud_type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.clear();

    prefs.setString("min_number", min_number);
    prefs.setString("stud_name", stud_name);
    prefs.setString("sud_school", sud_school);
    prefs.setString("stud_fac", stud_fac);
    prefs.setString("stud_maj", stud_maj);
    prefs.setString("stud_batch", stud_batch);
    prefs.setString("stud_type", stud_type);
    return prefs.commit();
  }

  Future<String> getStudMinPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String min_number = prefs.getString("min_number").toString();
    return min_number;
  }

  Future<String> getStudNamePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stud_name = prefs.getString("stud_name").toString();
    return stud_name;
  }

  Future<String> getStudSchoolPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String sud_school = prefs.getString("sud_school").toString();
    return sud_school;
  }

  Future<String> getStudFacPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stud_fac = prefs.getString("stud_fac").toString();
    return stud_fac;
  }

  Future<String> getStudMajPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stud_maj = prefs.getString("stud_maj").toString();
    return stud_maj;
  }

  Future<String> getStudBatchPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stud_batch = prefs.getString("stud_batch").toString();
    return stud_batch;
  }

  Future<String> getStudTypePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stud_type = prefs.getString("stud_type").toString();
    return stud_type;
  }
}
