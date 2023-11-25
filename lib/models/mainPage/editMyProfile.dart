import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stugetow/models/mainPage/Loading.dart';
import 'package:stugetow/services/auth.dart';
import 'package:stugetow/views/separateClasses/Chats/Users.dart';

class EditProfile extends StatefulWidget {
  final User? destination;

  EditProfile({this.destination});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool _loading = false;
  TextEditingController? _firstNameController,
      _lastNameController,
      _bioController;
  String? _currentSelectedValueFaculty;
  String? _currentSelectedValueCourse;
  String? _currentSelectedValueLevel;
  String? _currentSelectedValueWork;

  File? _image;
  final picker = ImagePicker();
  final String role = 'student';

  String? _imageUrl;

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

  var workList = [
    "Open for available jobs",
    "Not open for available jobs",
    "Already occupied",
  ];

  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Loading()
        : Scaffold(
            appBar: new AppBar(
              titleSpacing: 0,
              elevation: 0,
              backgroundColor: Colors.grey[50],
              leading: IconButton(
                icon: Icon(Icons.close, color: Colors.blueAccent[200]),
                iconSize: 30.0,
                onPressed: () => Navigator.pop(
                  context,
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Edit profile",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22.0,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.check, color: Colors.blueAccent[200]),
                  iconSize: 30.0,
                  onPressed: () async {
                    setState(() {
                      _loading = true;
                    });

                    dynamic result = await _auth.updateUserProfile(
                      fname: _firstNameController!.text,
                      lname: _lastNameController!.text,
                      faculty: _currentSelectedValueFaculty,
                      course: _currentSelectedValueCourse,
                      studyLevel: _currentSelectedValueLevel,
                      work: _currentSelectedValueWork,
                      bio: _bioController!.text,
                      img: _image!,
                      imgUrl: _imageUrl!
                    );

                    if (result != false) {
                      Navigator.pop(context);
                    }
                    else {
                      setState(() {
                        _loading = false;
                      });
                      _showToast(context, 'Connection problems, please try again later');
                    }
                  },
                ),
              ],
            ),
            body: ListView(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      height: 170.0,
                      width: 170.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          width: 2,
                          color: Colors.blueAccent[200]!,
                        ),
                        borderRadius: BorderRadius.circular(3),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: _image!=null? FileImage(_image!)
                              :(_imageUrl==null? AssetImage('assets/images/logo/stugetow_user.png'):NetworkImage(_imageUrl!)) as ImageProvider<Object>,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 60.0,
                      right: 100.0,
                      child: Material(
                        elevation: 5,
                        color: Colors.white,
                        type: MaterialType.circle,
                        shadowColor: Color.fromRGBO(48, 126, 171, 1),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              _getImage(ImageSource.gallery);
                            },
                            splashColor: Color.fromRGBO(48, 126, 171, 1),
                            child: Icon(
                              Icons.camera_alt_rounded,
                              size: 30,
                              color: Color.fromRGBO(48, 126, 171, 1),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 40),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: TextField(
                          controller: _firstNameController,
                          decoration: InputDecoration(
                            hintText: 'Enter firstname',
                            labelText: 'Firstname',
                            labelStyle: TextStyle(),
                            contentPadding: EdgeInsets.all(8),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: TextField(
                          controller: _lastNameController,
                          decoration: InputDecoration(
                            hintText: 'Enter lastname',
                            labelText: 'Lastname',
                            labelStyle: TextStyle(),
                            contentPadding: EdgeInsets.all(8),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: 150.0),
                          child: TextField(
                            controller: _bioController,
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: "About you",
                              labelText: 'Bio',
                              contentPadding: EdgeInsets.all(10),
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {},
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 4),
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Year of study',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            border: OutlineInputBorder(),
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
                              child: Text(value, style: TextStyle(fontSize: 18)),
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
                            fontSize: 13,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10.0),
                              border: OutlineInputBorder()),
                          hint: Text("Please Select type of work"),
                          value: _currentSelectedValueWork,
                          isDense: true,
                          onChanged: (String? newValue) {
                            setState(() {
                              _currentSelectedValueWork = newValue;
                            });
                          },
                          items: workList.map((String value) {
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
                          'Please Select faculty',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 15),
                        child: FormField<String>(
                          builder: (FormFieldState<String> state) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.0))),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  hint: Text("Please Select faculty"),
                                  value: _currentSelectedValueFaculty,
                                  isDense: true,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _currentSelectedValueFaculty = newValue;
                                      state.didChange(newValue);
                                    });
                                  },
                                  items: faculties.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 4),
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Please Select course',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 15),
                        child: FormField<String>(
                          builder: (FormFieldState<String> state) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  hint: Text("Please Select Course"),
                                  value: _currentSelectedValueCourse,
                                  isDense: true,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _currentSelectedValueCourse = newValue;
                                      state.didChange(newValue);
                                    });
                                  },
                                  items: courses.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value,
                                          style: TextStyle(fontSize: 18)),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  Future _getImage(ImageSource source) async {
    final image = await picker.pickImage(source: source);
    if (image != null) {
      final cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxWidth: 700,
          maxHeight: 700,
          androidUiSettings: AndroidUiSettings(
              toolbarColor: Colors.blueGrey[700],
              toolbarTitle: "Crop Image",
              toolbarWidgetColor: Colors.blueGrey[100],
              statusBarColor: Colors.blueGrey[700],
              backgroundColor: Colors.white));
      setState(() {
        _image = cropped;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserDetails();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _bioController = TextEditingController();
  }

  _getUserDetails() async {
    dynamic result = await _auth.getUserData();
    setState(() {
      _firstNameController!.text = result['firstname'];
      _lastNameController!.text = result['lastname'];
      _bioController!.text = result['bio'];
      _currentSelectedValueCourse = result['course'];
      _currentSelectedValueFaculty = result['faculty'];
      _currentSelectedValueLevel = result['studyLevel'];
      _currentSelectedValueWork = result['work'];
      _imageUrl = result['profileImg'];
    });
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
}
