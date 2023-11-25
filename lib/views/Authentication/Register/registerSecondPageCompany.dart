import 'package:flutter/material.dart';
import 'package:stugetow/models/mainPage/AnimatedPageRouteSlideRegister.dart';
import 'package:stugetow/models/mainPage/Loading.dart';
import 'package:stugetow/views/Authentication/Register/registerFirstPage.dart';
import 'package:stugetow/views/Authentication/Register/registerThirdPageCompany.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stugetow/services/auth.dart';

class RegisterSecondPageCompany extends StatefulWidget {
  RegisterSecondPageCompany({Key? key}) : super(key: key);
  @override
  _RegisterSecondPageCompanyState createState() => _RegisterSecondPageCompanyState();
}

class _RegisterSecondPageCompanyState extends State<RegisterSecondPageCompany> {
  bool _obscureText = true;
  bool _loading = false;
  bool _obscureTextConfirm = true;

  TextEditingController? _nameController;
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  TextEditingController? _confirmPasswordController;

  final _formKey = GlobalKey<FormState>();
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return _loading? Loading():Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 60.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Company',
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
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 80.0),
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
                                controller: _nameController,
                                obscureText: false,
                                maxLines: 1,
                                maxLength: 20,
                                decoration: InputDecoration(
                                    hintText: 'Company name',
                                    labelText: 'Company name',
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                    ),
                                    enabledBorder: _nameController!.text.isEmpty!=true?
                                    OutlineInputBorder(borderSide: BorderSide(color: Colors.green)):null,
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.person_outline_rounded)
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
                                    hintText: 'Company email',
                                    labelText: 'Company email',
                                    errorText: null,
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                    ),
                                    enabledBorder: _emailController!.text.isEmpty!=true?
                                    OutlineInputBorder(borderSide: BorderSide(color: Colors.green)):null,
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.email_outlined)
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
                                    errorText: null,
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                    ),
                                    enabledBorder: _passwordController!.text.isEmpty!=true?
                                    OutlineInputBorder(borderSide: BorderSide(color: Colors.green)):null,
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.lock_open_rounded),
                                    suffixIcon: IconButton(
                                      icon: Icon(_obscureText
                                          ? Icons.remove_red_eye
                                          : Icons.remove_red_eye_outlined),
                                      onPressed: () {
                                        setState(() {
                                          _obscureText = !_obscureText;
                                        });
                                      },
                                    )
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
                                    errorText: null,
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                    ),
                                    enabledBorder:(_confirmPasswordController!.text.isEmpty!=true && _confirmPasswordController!.text==_passwordController!.text)?
                                    OutlineInputBorder(borderSide: BorderSide(color: Colors.green)):null,
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.lock_open_rounded),
                                    suffixIcon: IconButton(
                                      icon: Icon(_obscureTextConfirm ? Icons.remove_red_eye : Icons.remove_red_eye_outlined),
                                      onPressed: () {
                                        setState(() {
                                          _obscureTextConfirm = !_obscureTextConfirm;
                                        });
                                      },
                                    )
                                ),
                                onChanged: (value) {},
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(top: 150),
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
                                          style: TextStyle(fontSize: 22,
                                              color: Color.fromRGBO(
                                                  36, 88, 120, 1)),
                                        ),
                                      ],
                                    ),
                                    onPressed: () {
                                      Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) => RegisterSelectStatus()),
                                      );
                                      _setData(
                                          _nameController!.text, _emailController!.text,
                                          _passwordController!.text, _confirmPasswordController!.text
                                      );
                                    },
                                  ),
                                  TextButton(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Finish',
                                          style: TextStyle(fontSize: 22,
                                              color: Color.fromRGBO(
                                                  48, 126, 171, 1)),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios_sharp,
                                          color: Color.fromRGBO(48, 126, 171, 1),
                                          size: 22,
                                        )
                                      ],
                                    ),
                                    onPressed: () async {
                                      if(_formKey.currentState!.validate()){
                                        setState((){_loading=true;});
                                        SharedPreferences prefs = await SharedPreferences.getInstance();
                                        String? name = prefs.getString('name');
                                        String email = prefs.getString('email')!;
                                        String password = prefs.getString('password')!;

                                        dynamic result = await _auth.registerWithEmailAndPasswordCompany(email:email, password:password, name:name, description: "");

                                        if(result == true) {
                                          Navigator.pushReplacement(
                                            context,
                                            AnimatedPageRouteSlideRegister(page: RegisterThirdPageCompany()),
                                          );
                                        }
                                        else{
                                          setState((){_loading=false;});
                                          _showToast(context, result);
                                        }
                                        _setData(
                                            _nameController!.text, _emailController!.text,
                                            _passwordController!.text, _confirmPasswordController!.text
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

    _nameController = new TextEditingController();
    _emailController = new TextEditingController();
    _passwordController = new TextEditingController();
    _confirmPasswordController = new TextEditingController();

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
    String? name = prefs.getString('name');
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');
    String? confirmPassword = prefs.getString('confirmPassword');
    if(name!=null && email!=null && password!=null && confirmPassword!=null) {
      setState(() {
        _nameController!.text = name;
        _emailController!.text = email;
        _passwordController!.text = password;
        _confirmPasswordController!.text = confirmPassword;
      });
    }
  }

  _setData(name, email, password, confirmPassword) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name',name);
    prefs.setString('email',email);
    prefs.setString('password',password);
    prefs.setString('confirmPassword',confirmPassword);
  }
}