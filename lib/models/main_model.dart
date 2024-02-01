// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:ffi';

class StudData {

  final String csv_id ;
  final String stud_fac , stud_maj ,del;
  final String stud_min_number,stud_full_name,stud_high_scool,stud_batch,added_date , faculty_desc , major_desc , stud_type;


  StudData({
    required this.csv_id,
    required this.stud_min_number,
    required this.stud_full_name,
    required this.stud_high_scool,
    required this.stud_fac,
    required this.stud_maj,
    required this.stud_batch,
    required this.added_date,
    required this.del,
    required this.faculty_desc,
    required this.major_desc,
    required this.stud_type

  });

  factory StudData.fromJson(Map<String, dynamic> jsonData) {
    return StudData(
      csv_id: jsonData['csv_id']  ,
      stud_min_number: jsonData['stud_min_number'],
      stud_full_name: jsonData['stud_full_name'],
      stud_high_scool: jsonData['stud_high_scool'],
      stud_fac: jsonData['stud_fac'] ,
      stud_maj: jsonData['stud_maj'] ,
      stud_batch: jsonData['stud_batch'],
      added_date: jsonData['added_date'],
      del: jsonData['del'] ,
      faculty_desc: jsonData['faculty_desc'],
      major_desc: jsonData['major_desc'] ,
      stud_type: jsonData['user_type'] ,
    );
  }
}

class StudMainData {


  final String stud_fac , stud_maj ,del;
  final String stud_min_number,stud_full_name,stud_high_scool,stud_batch,added_date , faculty_desc , major_desc;
  final String info_stud_name_en,info_stud_phone,info_stud_parents_phone,info_stud_email,info_stud_precent,info_stud_accdemic ;
  final String info_stud_id_number ,info_stud_dob , info_stud_address , info_stud_status , info_date;


  StudMainData({

    required this.stud_min_number,
    required this.stud_full_name,
    required this.stud_high_scool,
    required this.stud_fac,
    required this.stud_maj,
    required this.stud_batch,
    required this.added_date,
    required this.del,
    required this.faculty_desc,
    required this.major_desc ,

    required this.info_stud_name_en,
    required this.info_stud_phone,
    required this.info_stud_parents_phone ,
    required this.info_stud_email,
    required this.info_stud_precent,
    required this.info_stud_accdemic ,

    required this.info_stud_id_number,
    required this.info_stud_dob,
    required this.info_stud_address ,
    required this.info_stud_status,
    required this.info_date,


});

  factory StudMainData.fromJson(Map<String, dynamic> jsonData) {
    return StudMainData(

      stud_min_number: jsonData['stud_min_number'],
      stud_full_name: jsonData['stud_full_name'],
      stud_high_scool: jsonData['stud_high_scool'],
      stud_fac: jsonData['stud_fac'] ,
      stud_maj: jsonData['stud_maj'] ,
      stud_batch: jsonData['stud_batch'],
      added_date: jsonData['added_date'],
      del: jsonData['del'] ,
      faculty_desc: jsonData['faculty_desc'],
      major_desc: jsonData['major_desc'] ,

      info_stud_name_en: jsonData['info_stud_name_en'],
      info_stud_phone: jsonData['info_stud_phone'],
      info_stud_parents_phone: jsonData['info_stud_parents_phone'] ,
      info_stud_email: jsonData['info_stud_email'],
      info_stud_precent: jsonData['info_stud_precent'] ,

      info_stud_accdemic: jsonData['info_stud_accdemic'],
      info_stud_id_number: jsonData['info_stud_id_number'] ,
      info_stud_dob: jsonData['info_stud_dob'],
      info_stud_address: jsonData['info_stud_address'] ,
      info_stud_status: jsonData['info_stud_status'] ,
      info_date: jsonData['info_date']  ,

    );
  }
}

class StudentConfirm {

  final String conf_id , info_stud_name_en  ;
  final String stud_min_number , student_affairs_status ;
  final String clinic_status,dean_status,admission_status,reg_status,conf_date ;


  StudentConfirm({

    required this.conf_id,
    required this.info_stud_name_en,
    required this.stud_min_number,
    required this.student_affairs_status,
    required this.clinic_status,
    required this.dean_status,
    required this.admission_status,
    required this.reg_status,
    required this.conf_date,


  });

  factory StudentConfirm.fromJson(Map<String, dynamic> jsonData) {
    return StudentConfirm(
      conf_id: jsonData['conf_id']  ,
      info_stud_name_en: jsonData['info_stud_name_en']  ,
      stud_min_number: jsonData['stud_min_number'],
      student_affairs_status: jsonData['student_affairs_status'],
      clinic_status: jsonData['clinic_status'],
      dean_status: jsonData['dean_status'] ,
      admission_status: jsonData['admission_status'] ,
      reg_status: jsonData['reg_status'],
      conf_date: jsonData['conf_date'],

    );
  }
}



