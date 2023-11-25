import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stugetow/models/mainPage/AnimatedPageRouteSlideRegister.dart';
import 'package:stugetow/models/mainPage/Loading.dart';
import 'package:stugetow/services/auth.dart';
import 'package:stugetow/views/Authentication/Register/registerSecondPageUser.dart';
import 'package:stugetow/views/Authentication/Register/registerThirdPageUser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterEducation extends StatefulWidget {
  RegisterEducation({Key? key}) : super(key: key);

  @override
  _RegisterEducationState createState() => _RegisterEducationState();
}

class _RegisterEducationState extends State<RegisterEducation> {
  bool _loading = false;
  var _currentSelectedValueSchool;
  String? _currentSelectedValueFaculty;
  String? _currentSelectedValueCourse;
  String? _currentSelectedValueLevel;
  String? _currentSelectedValueWork;

  var schools = [
    "University of the Witwatersrand",
    "University of Johannesburg",
    "University of Limpopo",
    "University of Pretoria",
    "University of Capetown",
    "University of Kwazulu Natal",
    "University of Stelenbosch",
    "University of North West",
    "University of Free State",
    "Ekurhuleni West Campus",
    "Thswane University of Technology"
  ];
  var faculties = [
    "Science",
    "Art",
    "Engineering",
    "Law",
    "Medicine",
    "Humanity",
    "Teaching",
    "Business"
  ];
  var courses = [
    "Bsc General Science",
    "Mathematical Science",
    "Mining Engineering",
    "LLB Law",
    "Psychology",
    "Computer Science",
    "Civil Engineering",
    "Teaching",
    "Geology",
    "Biological Science",
    "Acturial Science",
    "Medicine",
    "Film and Television",
    "Music and Production",
    "Business Management"
  ];

  var level = [
    "1st year",
    "2nd year",
    "3rd year",
    "4th year",
    "Honours",
    "Masters level",
    "PHD level",
  ];

  var work = [
    "Open for available jobs",
    "Not open for available jobs",
    "Already occupied",
  ];

  final _formKey = GlobalKey<FormState>();
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return _loading? Loading():Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.only(bottom: MediaQuery
            .of(context)
            .viewInsets
            .bottom),
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 30.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Text(
                        'Education',
                        style: TextStyle(
                          fontSize: 40,
                          fontFamily: "serif",
                          decoration: TextDecoration.underline,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ),
                    Container(
                      height: 150,
                      child: Image(image: AssetImage('assets/images/logo/reg_edu_bg.png')),
                    ),
                    Container(
                      height: 500,
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 0.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(bottom: 4),
                              alignment: Alignment.topLeft,
                              child: Text(
                                'School name',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child: DropdownButtonFormField<String>(
                                validator: (value) {
                                  if (value == null) {
                                    return 'This field is required';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  border: OutlineInputBorder(),
                                  enabledBorder: (_currentSelectedValueSchool!=null)?
                                  OutlineInputBorder(borderSide: BorderSide(color: Colors.green)):null,
                                ),
                                hint: Text("Please Select school"),
                                value: _currentSelectedValueSchool,
                                isDense: true,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _currentSelectedValueSchool = newValue;
                                  });
                                },
                                items: schools.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(bottom: 4),
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Faculty',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child: DropdownButtonFormField<String>(
                                validator: (value) {
                                  if (value == null) {
                                    return 'This field is required';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  border: OutlineInputBorder(),
                                  enabledBorder: (_currentSelectedValueFaculty!=null)?
                                  OutlineInputBorder(borderSide: BorderSide(color: Colors.green)):null,
                                ),
                                hint: Text("Please Select faculty"),
                                value: _currentSelectedValueFaculty,
                                isDense: true,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _currentSelectedValueFaculty = newValue;
                                  });
                                },
                                items: faculties.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(bottom: 4),
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Course',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child: DropdownButtonFormField<String>(
                                validator: (value) {
                                  if (value == null) {
                                    return 'This field is required';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  border: OutlineInputBorder(),
                                  enabledBorder: (_currentSelectedValueCourse!=null)?
                                  OutlineInputBorder(borderSide: BorderSide(color: Colors.green)):null,
                                ),
                                hint: Text("Please Select Course"),
                                value: _currentSelectedValueCourse,
                                isDense: true,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _currentSelectedValueCourse = newValue;
                                  });
                                },
                                items: courses.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value, style: TextStyle(fontSize: 18)),
                                  );
                                }).toList(),
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(bottom: 4),
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Year of study',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child: DropdownButtonFormField<String>(
                                validator: (value) {
                                  if (value == null) {
                                    return 'This field is required';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  border: OutlineInputBorder(),
                                  enabledBorder: (_currentSelectedValueLevel!=null)?
                                  OutlineInputBorder(borderSide: BorderSide(color: Colors.green)):null,
                                ),
                                hint: Text("Please Select year of study"),
                                value: _currentSelectedValueLevel,
                                isDense: true,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _currentSelectedValueLevel = newValue;
                                  });
                                },
                                items: level.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                        value, style: TextStyle(fontSize: 18)),
                                  );
                                }).toList(),
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(bottom: 4),
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Work',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child: DropdownButtonFormField<String>(
                                validator: (value) {
                                  if (value == null) {
                                    return 'This field is required';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  border: OutlineInputBorder(),
                                  enabledBorder: (_currentSelectedValueWork!=null)?
                                  OutlineInputBorder(borderSide: BorderSide(color: Colors.green)):null,
                                ),
                                hint: Text("Please Select type of work"),
                                value: _currentSelectedValueWork,
                                isDense: true,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _currentSelectedValueWork = newValue;
                                  });
                                },
                                items: work.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                        value, style: TextStyle(fontSize: 18)),
                                  );
                                }).toList(),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.arrow_back_ios,
                                  color: Color.fromRGBO(36, 88, 120, 1),
                                  size: 22,
                                ),
                                Text(
                                  'Back',
                                  style: TextStyle(fontSize: 22, color: Color.fromRGBO(36, 88, 120, 1),),
                                ),
                              ],
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => RegisterSecondPageUser()),
                              );
                              _setData(_currentSelectedValueSchool, _currentSelectedValueFaculty,
                                  _currentSelectedValueCourse, _currentSelectedValueLevel,
                                  _currentSelectedValueWork);
                            },
                          ),
                          TextButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Finish',
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Color.fromRGBO(
                                        48, 126, 171, 1),
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  color: Color.fromRGBO(
                                      48, 126, 171, 1),
                                  size: 22,
                                )
                              ],
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState((){_loading=true;});
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                String? fname = prefs.getString('firstname');
                                String? lname = prefs.getString('lastname');
                                String email = prefs.getString('email')!;
                                String password = prefs.getString('password')!;

                                dynamic result = await _auth.registerWithEmailAndPassword(
                                    email:email, password:password, fname:fname, lname:lname,
                                    school:_currentSelectedValueSchool, faculty:_currentSelectedValueFaculty,
                                    course:_currentSelectedValueCourse, studyLevel:_currentSelectedValueLevel,
                                    work:_currentSelectedValueWork, bio:""
                                );

                               if(result == true) {
                                  Navigator.pushReplacement(context,
                                      AnimatedPageRouteSlideRegister(page: RegisterThirdPageUser()),
                                  );
                                }
                               else{
                                 setState((){_loading=false;});
                                 _showToast(context, result);
                               }
                                _setData(_currentSelectedValueSchool, _currentSelectedValueFaculty,
                                    _currentSelectedValueCourse, _currentSelectedValueLevel,
                                    _currentSelectedValueWork);
                              }
                            },
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
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _showToast(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
            label: 'Okay', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? schoolname = prefs.getString('schoolname');
    String? faculty = prefs.getString('faculty');
    String? course = prefs.getString('course');
    String? studylevel = prefs.getString('studylevel');
    String? work = prefs.getString('work');
    if(schoolname!=null && faculty!=null && course!=null && studylevel!=null && work!=null) {
      setState(() {
        _currentSelectedValueSchool = schoolname;
        _currentSelectedValueFaculty = faculty;
        _currentSelectedValueCourse = course;
        _currentSelectedValueLevel = studylevel;
        _currentSelectedValueWork = work;
      });
    }
  }

  _setData(schoolname, faculty, course, studylevel, work) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('schoolname',schoolname);
    prefs.setString('faculty',faculty);
    prefs.setString('course',course);
    prefs.setString('studylevel',studylevel);
    prefs.setString('work',work);
  }
}
