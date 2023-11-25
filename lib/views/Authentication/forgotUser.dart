import 'package:stugetow/views/Authentication/Login.dart';
import 'package:flutter/material.dart';
import 'package:stugetow/views/Authentication/Register/registerFirstPage.dart';

class ForgotUser extends StatefulWidget {
  ForgotUser({Key? key}) : super(key: key);

  @override
  _ForgotUserState createState() => _ForgotUserState();
}

class _ForgotUserState extends State<ForgotUser> {
  TextEditingController? _phoneNoController;
  TextEditingController? _emailController;
  final _formKey = GlobalKey<FormState>();

  int? selectedRadio;

  void initState() {
    super.initState();
    _phoneNoController = TextEditingController();
    _emailController = TextEditingController();
    // selectedRadio = 1;
  }

  // selectState(int val) {
  //   setState(() {
  //     selectedRadio = val;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 100.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'StugetoW',
                    style: TextStyle(
                      color: Color.fromRGBO(48, 126, 171, 1),
                      fontSize: 90.0,
                      fontFamily: 'cursive',
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    'Forgot details',
                    style: TextStyle(
                      color: Color.fromRGBO(48, 126, 171, .5),
                      fontSize: 30.0,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                                top: 10.0, left: 20, right: 20),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
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
                            padding: EdgeInsets.only(
                                top: 10.0, bottom: 30, left: 20, right: 20),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter phone number';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.phone,
                              controller: _phoneNoController,
                              obscureText: false,
                              maxLines: 1,
                              maxLength: 50,
                              decoration: InputDecoration(
                                  hintText: 'Enter phone number',
                                  labelText: 'Phone number',
                                  hintStyle: TextStyle(
                                    color: Colors.grey[400],
                                  ),
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.phone)
                              ),
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
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
                      // color: Colors.blueGrey[600],
                    ),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromRGBO(48, 126, 171, 1))),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pushReplacement(context,
                            MaterialPageRoute(
                              builder: (context) => Login(),
                            ),
                          );
                        }
                      },
                      child: Text(
                        'Request',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    child: Text(
                      "Back to Login",
                      style: TextStyle(color: Color.fromRGBO(41, 127, 212, 1)),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
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
                  Text("Do not have an account?"),
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
}
