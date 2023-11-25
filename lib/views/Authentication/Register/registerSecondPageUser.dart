import 'package:flutter/material.dart';
import 'package:stugetow/models/mainPage/AnimatedPageRouteSlideRegister.dart';
import 'package:stugetow/views/Authentication/Register/registerEducation.dart';
import 'package:stugetow/views/Authentication/Register/registerFirstPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterSecondPageUser extends StatefulWidget {
  RegisterSecondPageUser({Key? key}) : super(key: key);
  @override
  _RegisterSecondPageUserState createState() => _RegisterSecondPageUserState();
}

class _RegisterSecondPageUserState extends State<RegisterSecondPageUser> {
  bool _obscureText = true;
  bool _obscureTextConfirm = true;

  TextEditingController? _firstnameController;
  TextEditingController? _lastNameController;
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  TextEditingController? _confirmPasswordController;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 50.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'User',
                      style: TextStyle(
                        color: Color.fromRGBO(48, 126, 171, 1),
                        fontSize: 40.0,
                        fontFamily: 'cursive',
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      '--Details--',
                      style: TextStyle(
                        color: Color.fromRGBO(48, 126, 171, 1),
                        fontSize: 60.0,
                        fontFamily: 'cursive',
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'This field is required';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.name,
                                controller: _firstnameController,
                                obscureText: false,
                                maxLines: 1,
                                maxLength: 20,
                                decoration: InputDecoration(
                                  hintText: 'Firstname',
                                  labelText: 'Firstname',
                                  hintStyle: TextStyle(
                                    color: Colors.grey[400],
                                  ),
                                  enabledBorder: _firstnameController!.text.isEmpty!=true?
                                  OutlineInputBorder(borderSide: BorderSide(color: Colors.green)):null,
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.person_outline_rounded),
                                ),
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54,
                                ),
                                onChanged: (value) {},
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 8.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'This field is required';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.name,
                                controller: _lastNameController,
                                obscureText: false,
                                maxLines: 1,
                                maxLength: 20,
                                decoration: InputDecoration(
                                    hintText: 'Lastname',
                                    labelText: 'Lastname',
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                    ),
                                  enabledBorder: _lastNameController!.text.isEmpty!=true?
                                  OutlineInputBorder(borderSide: BorderSide(color: Colors.green)):null,
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.person_outline_rounded),
                                ),
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54,
                                ),
                                onChanged: (value) {},
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 8.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'This field is required';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.emailAddress,
                                controller: _emailController,
                                obscureText: false,
                                maxLines: 1,
                                maxLength: 50,
                                decoration: InputDecoration(
                                    hintText: 'Email',
                                    labelText: 'Email',
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                    ),
                                  enabledBorder: _emailController!.text.isEmpty!=true?
                                  OutlineInputBorder(borderSide: BorderSide(color: Colors.green)):null,
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.email_outlined),
                                ),
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54,
                                ),
                                onChanged: (value) {},
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 8.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'This field is required';
                                  }
                                  else if(value.length<6){
                                    return 'Your password should be at least 6 characters long';
                                  }
                                  return null;
                                },
                                controller: _passwordController,
                                obscureText: _obscureText,
                                maxLines: 1,
                                maxLength: 50,
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  labelText: 'Password',
                                  hintStyle: TextStyle(
                                    color: Colors.grey[400],
                                  ),
                                  enabledBorder: _passwordController!.text.isEmpty!=true?
                                  OutlineInputBorder(borderSide: BorderSide(color: Colors.green)):null,
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.lock_open_rounded),
                                  suffixIcon: IconButton(
                                    icon: Icon(_obscureText ? Icons.remove_red_eye :
                                    Icons.remove_red_eye_outlined),
                                    onPressed: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });},
                                  ),
                                ),
                                onChanged: (value) {},
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 8.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'This field is required';
                                  }
                                  else if(_confirmPasswordController!.text != _passwordController!.text){
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                                controller: _confirmPasswordController,
                                obscureText: _obscureTextConfirm,
                                maxLines: 1,
                                maxLength: 50,
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Confirm password',
                                  labelText: 'Confirm password',
                                  hintStyle: TextStyle(
                                    color: Colors.grey[400],
                                  ),
                                  enabledBorder: (_confirmPasswordController!.text.isEmpty!=true && _confirmPasswordController!.text==_passwordController!.text)?
                                  OutlineInputBorder(borderSide: BorderSide(color: Colors.green)):null,
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.lock_open_rounded),
                                  suffixIcon: IconButton(
                                    icon: Icon(_obscureTextConfirm ? Icons.remove_red_eye :
                                    Icons.remove_red_eye_outlined),
                                    onPressed: () {
                                      setState(() {
                                        _obscureTextConfirm = !_obscureTextConfirm;
                                      });
                                      },
                                  ),
                                ),
                                onChanged: (value) {},
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 105),
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
                                          style: TextStyle(
                                              fontSize: 22,
                                              color:
                                                  Color.fromRGBO(36, 88, 120, 1)),
                                        ),
                                      ],
                                    ),
                                    onPressed: () {
                                      Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) => RegisterSelectStatus()),
                                      );
                                      _setData(
                                          _firstnameController!.text, _lastNameController!.text,
                                          _emailController!.text, _passwordController!.text,
                                          _confirmPasswordController!.text
                                      );
                                    },
                                  ),
                                  TextButton(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Next',
                                          style: TextStyle(
                                              fontSize: 22,
                                              color: Color.fromRGBO(48, 126, 171, 1)),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios_sharp,
                                          color: Color.fromRGBO(48, 126, 171, 1),
                                          size: 22,
                                        )
                                      ],
                                    ),
                                    onPressed: () {
                                      if(_formKey.currentState!.validate()) {
                                        Navigator.pushReplacement(
                                          context,
                                          AnimatedPageRouteSlideRegister(
                                            page: RegisterEducation(),
                                          ),
                                        );
                                        _setData(
                                            _firstnameController!.text, _lastNameController!.text,
                                            _emailController!.text, _passwordController!.text,
                                            _confirmPasswordController!.text
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
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

    _firstnameController = new TextEditingController();
    _lastNameController = new TextEditingController();
    _emailController = new TextEditingController();
    _passwordController = new TextEditingController();
    _confirmPasswordController = new TextEditingController();

    _getData();
  }

  _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? fname = prefs.getString('firstname');
    String? lname = prefs.getString('lastname');
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');
    String? confirmPassword = prefs.getString('confirmPassword');
    if(fname!=null && lname!=null && email!=null && password!=null && confirmPassword!=null) {
      setState(() {
        _firstnameController!.text = fname;
        _lastNameController!.text = lname;
        _emailController!.text = email;
        _passwordController!.text = password;
        _confirmPasswordController!.text = confirmPassword;
      });
    }
  }

  _setData(firstname, lastname, email, password, confirmPassword) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('firstname',firstname);
    prefs.setString('lastname',lastname);
    prefs.setString('email',email);
    prefs.setString('password',password);
    prefs.setString('confirmPassword',confirmPassword);
  }
}
