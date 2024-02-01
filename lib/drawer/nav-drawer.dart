// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

import 'package:new_admission_app/screens/single_form.dart';
import 'package:new_admission_app/screens/student_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../screens/home_screen.dart';
import '../screens/manage_admission.dart';
import '../screens/student_form.dart';
import '../screens/student_progress.dart';
import '../screens/students_phases.dart';
import '../screens/upload_students.dart';
import '../screens/view_students.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPref;

class NavDrawer extends StatelessWidget {
  final String user_type;
  const NavDrawer({required this.user_type});

  @override
  Widget build(BuildContext context) {
    print('user_type : ' + user_type);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
                color: Color(0xFF59363b),
                image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: AssetImage('assets/img/logo.png'),
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(width: 5),
                  ],
                ),
              ],
            ),
          ),

          if (user_type.toString() == "0") ...[
            ListTile(
              leading: Icon(Icons.add_task_sharp),
              title: Text('Add Users'),
              onTap: () => {_navigateToScreens(context, "Add_Users")},
            ),
            ListTile(
              leading: Icon(Icons.upload_file_sharp),
              title: Text('Upload Students'),
              onTap: () => {_navigateToScreens(context, "Upload_Stud")},
            ),
            ListTile(
              leading: Icon(Icons.date_range),
              title: Text('Open - Close Admission'),
              onTap: () =>
                  {_navigateToScreens(context, "Open_Close_Admission")},
            ),
            ListTile(
              leading: Icon(Icons.verified_user),
              title: Text('View Students'),
              onTap: () => {_navigateToScreens(context, "View_Stud")},
            ),
            ListTile(
              leading: Icon(Icons.badge_outlined),
              title: Text('Students Filled Form'),
              onTap: () => {_navigateToScreens(context, "Stud_Form")},
            ),
            ListTile(
              leading: Icon(Icons.format_align_center_outlined),
              title: Text('Single Form'),
              onTap: () => {_navigateToScreens(context, "Single_Form")},
            ),
          ], //end of Admin Nav

          // if(user_type.toString() == "1")...[
          //
          //       ListTile(
          //         leading: Icon(Icons.stacked_bar_chart),
          //         title: Text('Students Confirmation'),
          //         onTap: () => {
          //           _navigateToScreens(context , "Stud_Confirmation")
          //         },
          //       )
          // ] ,
          if (user_type.toString() == "1" ||
              user_type.toString() == "2" ||
              user_type.toString() == "3" ||
              user_type.toString() == "4" ||
              user_type.toString() == "5") ...[
            ListTile(
              leading: Icon(Icons.stacked_bar_chart),
              title: Text('Students Confirmation'),
              onTap: () => {_navigateToScreens(context, "Stud_Confirmation")},
            )
          ],

          if (user_type.toString() == "01") ...[
            ListTile(
              leading: Icon(Icons.stacked_bar_chart),
              title: Text('Student Main Info'),
              onTap: () => {_navigateToScreens(context, "Student_Main_Info")},
            ),
            ListTile(
              leading: Icon(Icons.padding_rounded),
              title: Text('Admission Progress'),
              onTap: () => {_navigateToScreens(context, "Student_Progress")},
            )
          ],
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('EXIT'),
            onTap: () async => {
              // sharedPref.clear(),
              Future.delayed(
                const Duration(milliseconds: 1000),
                () {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
              ),
            },
          ),
        ],
      ),
    );
  }

  _navigateToScreens(BuildContext context, String page_name) {
    if (page_name == 'Add_Users') {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (route) => false,
      );
    }
    if (page_name == "Upload_Stud") {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const UploadStudents()),
        (route) => false,
      );
    }
    if (page_name == "Open_Close_Admission") {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => ManageAdmission()),
        (route) => false,
      );
    }
    if (page_name == "View_Stud") {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => ViewStudentsState()),
        (route) => false,
      );
    }
    if (page_name == "Stud_Form") {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => StudentFormState()),
        (route) => false,
      );
    }

    if (page_name == "Single_Form") {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SingleFormState()),
        (route) => false,
      );
    }

    if (page_name == "Stud_Confirmation") {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => StudentsPhasesState()),
        (route) => false,
      );
    }

    if (page_name == "Student_Main_Info") {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => StudentHomePage()),
        (route) => false,
      );
    }

    if (page_name == "Student_Progress") {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => StudentProgress()),
        (route) => false,
      );
    }
  }
}
