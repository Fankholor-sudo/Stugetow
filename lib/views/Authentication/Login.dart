import 'package:stugetow/models/mainPage/Loading.dart';
import 'package:stugetow/screens/mainPage/mainPage.dart';
import 'package:stugetow/services/auth.dart';
import 'package:stugetow/views/Authentication/Register/registerFirstPage.dart';
import 'package:stugetow/views/Authentication/forgotUser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = true;
  bool _loading = false;
  dynamic _error = null;
  TextEditingController? _passwordController;
  TextEditingController? _emailController;

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
              padding: EdgeInsets.only(top:100.0),
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'StugetoW',
                    style: TextStyle(
                      color: Color.fromRGBO(48, 126, 171,1),
                      fontSize: 90.0,
                      fontFamily: 'cursive',
                      fontWeight: FontWeight.w900,
                    ),
                  ),

                  Text(
                    'Login',
                    style: TextStyle(
                      color: Color.fromRGBO(48, 126, 171,1),
                      fontSize: 60.0,
                      fontFamily: 'cursive',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0, bottom: 30.0, right: 10, left: 10),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10.0),
                            child: TextFormField(
                              validator:(value){
                                if(value!.isEmpty){
                                  return 'Please enter email';
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
                                errorText: _error,
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                ),
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.email_outlined)
                              ),
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10.0),
                            child: TextFormField(
                              validator:(value){
                                if(value!.isEmpty){
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                              controller: _passwordController,
                              obscureText: _obscureText,
                              maxLines: 1,
                              maxLength: 20,
                              style: TextStyle(color: Colors.black54),
                              decoration: InputDecoration(
                                hintText: 'Password',
                                labelText: 'Password',
                                errorText: _error,
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                ),
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.lock_open_rounded),
                                suffixIcon: IconButton(
                                  icon: Icon(_obscureText? Icons.remove_red_eye:Icons.remove_red_eye_outlined),
                                  onPressed: (){
                                    setState((){
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                )
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(48, 126, 171,1))),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () async {
                        if(_formKey.currentState!.validate()){
                          setState((){_loading=true;});
                          dynamic result = await _auth.signInWithEmailAndPassword(
                              email:_emailController!.text,
                              password:_passwordController!.text
                          );

                          if(result == true) {
                            dynamic result = await _auth.getUserData();
                            _setData(result!['role']);

                            setState(() {
                              _error = null;
                            });
                            _showToast(context, "Login Successful... Enjoy!");
                            Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (context) => MainPage()),
                            );
                          }
                          else{
                            setState(() {
                              _error = 'Invalid login details';
                              _loading = false;
                            });
                          }
                        }
                      },
                    ),
                  ),
                  TextButton(
                    child: Text(
                      "Forgot password?",
                      style: TextStyle(color: Color.fromRGBO(41, 127, 212, 1)),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotUser(),
                          ));
                    },
                  ),
                  Text(
                    '__OR__',
                    style: TextStyle(
                      color: Colors.blueGrey[100],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Do not have an account?",
                  ),
                  TextButton(
                    child: Text(
                      "Register",
                      style: TextStyle(color: Color.fromRGBO(41, 127, 212, 1)),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterSelectStatus(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState(){
    super.initState();
    _emailController = new TextEditingController();
    _passwordController = new TextEditingController();
  }

  _setData(role) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('role', role);
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
