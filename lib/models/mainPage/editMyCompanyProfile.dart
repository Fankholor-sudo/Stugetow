import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stugetow/models/mainPage/Loading.dart';
import 'package:stugetow/services/auth.dart';
import 'package:stugetow/views/separateClasses/Company/UserCompany.dart';

class CompanyEditProfile extends StatefulWidget {
  final UserCompany? destination;
  CompanyEditProfile({this.destination});
  @override
  _CompanyEditProfileState createState() => _CompanyEditProfileState();
}

class _CompanyEditProfileState extends State<CompanyEditProfile> {
  bool _loading = false;
  TextEditingController? _nameController,_descriptionController;

  File? _image;
  final picker = ImagePicker();
  final String role = 'company';
  String? _image_url;

  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return _loading? Loading():Scaffold(
      appBar: new AppBar(
        titleSpacing: 0,
        elevation: 0,
        brightness: Brightness.dark,
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
                    fontWeight: FontWeight.w400
                ),
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
                dynamic result = await _auth.updateCompanyProfile(
                  name: _nameController!.text,
                  description: _descriptionController!.text,
                  img: _image??null,
                  imgUrl: _image_url
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
                    image: _image != null ? FileImage(_image!) : (_image_url != null ? NetworkImage(_image_url!) : AssetImage('assets/images/logo/stugetow_company.png')) as ImageProvider<Object>,
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
            margin: EdgeInsets.only(left:20,right:20,bottom: 10,top:40),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: 'Enter Company name',
                      labelText: 'Comapany name',
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
                      controller: _descriptionController,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: "About the company",
                        labelText: 'About',
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {},
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future _getImage(ImageSource source) async{
    final image = await picker.getImage(source: source);
    if(image != null){
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
              backgroundColor: Colors.white
          )
      );
      setState(() {
        _image = cropped;
      });
    }
  }

  @override
  void initState(){
    super.initState();
    _getUserDetails();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  _getUserDetails() async {
    dynamic result = await _auth.getUserData();
    setState(() {
      _nameController!.text = result['name'];
      _descriptionController!.text = result['description'];
      _image_url = result['profileImg'];
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
