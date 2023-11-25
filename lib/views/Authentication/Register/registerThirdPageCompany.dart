import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stugetow/models/mainPage/AnimatedPageRouteSlideRegister.dart';
import 'package:stugetow/models/mainPage/Loading.dart';
import 'package:stugetow/screens/mainPage/mainPage.dart';
import 'package:stugetow/views/Authentication/Register/registerSecondPageCompany.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stugetow/services/auth.dart';

class RegisterThirdPageCompany extends StatefulWidget {
  const RegisterThirdPageCompany({Key? key}) : super(key: key);

  @override
  _RegisterThirdPageCompanyState createState() =>
      _RegisterThirdPageCompanyState();
}

class _RegisterThirdPageCompanyState extends State<RegisterThirdPageCompany> {
  TextEditingController? _descriptionController;
  File? _image;
  AssetImage? _img;
  final _picker = ImagePicker();
  bool _loading = false;

  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Loading()
        : Scaffold(
            body: ListView(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        height: 250,
                        color: Color.fromRGBO(10, 90, 150, .8),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.width * .6,
                        width: MediaQuery.of(context).size.width * .6,
                        margin: EdgeInsets.only(top: 110),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.grey[50],
                          border: Border.all(
                            width: 2,
                            color: Color.fromRGBO(48, 126, 171, 1),
                          ),
                          borderRadius: BorderRadius.circular(2),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: (_image == null ? _img! : FileImage(_image!)) as ImageProvider<Object>,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 80.0,
                        right: 60.0,
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
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 150.0),
                    child: TextField(
                      controller: _descriptionController,
                      minLines: 10,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: "About the company",
                        labelText: 'Description',
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(),
                        enabledBorder: (_descriptionController!.text.isEmpty)
                            ? null
                            : OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.green)),
                      ),
                      onChanged: (value) {},
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 160, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromRGBO(48, 126, 171, 1))),
                        child: Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          String? name = prefs.getString('name');
                          setState(() {
                            _loading = true;
                          });
                          dynamic result = await _auth.updateCompanyProfile(
                              img: _image ?? null,
                              imgUrl: "",
                              name: name,
                              description: _descriptionController!.text
                          );
                          if (result != false) {
                            Navigator.pushReplacement(
                              context,
                              AnimatedPageRouteSlideRegister(page: MainPage()),
                            );
                          }
                          else {
                            setState(() {
                              _loading = false;
                            });
                            _showToast(context, result);
                          }
                          _setData(_descriptionController!.text);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
  }

  Future _getImage(ImageSource source) async {
    final image = await _picker.getImage(source: source);
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
    _img = AssetImage('assets/images/logo/stugetow_company.png');
    _descriptionController = new TextEditingController();
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(_img!, context);
  }

  _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? message = prefs.getString('message');
    if (message != null) {
      setState(() {
        _descriptionController!.text = message;
      });
    }
  }

  _setData(message) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('message', message);
  }
}
