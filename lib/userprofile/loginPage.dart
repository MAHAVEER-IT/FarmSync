import 'dart:async';
import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:farmsync/userprofile/Auth_firebase.dart';
import 'package:farmsync/userprofile/signupPage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../colors/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isBlur = false;
  bool _showText = false;
  bool _passwordVisible = true;

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  String? _emailError;
  String? _passwordError;

  RegExp emailRegExp = RegExp(
    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
  );

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 1), () {
      setState(() {
        _isBlur = true;
      });
    });

    Timer(Duration(seconds: 1), () {
      setState(() {
        _showText = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    final height = screensize.height;
    final width = screensize.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: Stack(
          children: [
            Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    height: height * 0.3,
                    width: width,
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade100,
                      image: DecorationImage(
                          image: AssetImage('images/Login/cow4.jpg'),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                AnimatedOpacity(
                  opacity: _isBlur ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 500),
                  child: BackdropFilter(
                    filter: _isBlur
                        ? ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0)
                        : ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
                    child: Container(
                      color: Colors.black
                          .withOpacity(0), // Needed for BackdropFilter to work
                    ),
                  ),
                ),
                if (_isBlur)
                  Positioned(
                    top: height * 0.1,
                    left: width * 0.2,
                    child: SizedBox(
                      width: width * 0.5,
                      child: DefaultTextStyle(
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.black45,
                              offset: Offset(4, 4),
                            ),
                          ],
                        ),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            TyperAnimatedText("Login To Continue...")
                          ],
                          totalRepeatCount: 1,
                          isRepeatingAnimation: false,
                          onFinished: () {
                            setState(() {
                              _showText = true;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: height * 0.75,
                width: width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    _LoginOrRigister(),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.055,
                    ),
                    _LoginContent(),
                    SizedBox(
                      height: 20,
                    ),
                    _GoogleOrFaceBook(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _LoginOrRigister() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.08,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: backgroundColor3.withOpacity(0.9),
          border: Border.all(
            color: Colors.white,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets
                      .zero, // Remove default padding to control size exactly
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  minimumSize: Size(MediaQuery.sizeOf(context).width / 2.2,
                      MediaQuery.sizeOf(context).height * 0.08),
                ),
                onPressed: () {
                  print("Clicked");
                  /*Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Register()));*/
                  // Define the action when the button is pressed
                },
                child: Center(
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: textColor1,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterPage(),
                    ),
                  );
                },
                child: Text(
                  "Register",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: textColor1,
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _LoginContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.sizeOf(context).width * 0.9,
          child: TextFormField(
            controller: _email,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                label: Text("Email"),
                suffixIcon: Icon(Icons.email_outlined),
                errorText: _emailError),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: MediaQuery.sizeOf(context).width * 0.9,
          child: Form(
            child: TextFormField(
              controller: _password,
              obscureText: _passwordVisible,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  label: Text("Password"),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                    icon: Icon(_passwordVisible
                        ? Icons.visibility_off
                        : Icons.visibility),
                  ),
                  errorText: _passwordError),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.topRight,
            child: Text(
              "Forget Password ?",
              style: TextStyle(
                  color: Colors.blue.shade400,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.9,
          height: MediaQuery.sizeOf(context).height * 0.055,
          child: ElevatedButton(
            onPressed: () {
              bool isValid = true;
              if (!emailRegExp.hasMatch(_email.text)) {
                setState(() {
                  _emailError = 'Invalid Email';
                });
                Fluttertoast.showToast(
                    msg: 'Invalid Email ',
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.SNACKBAR,
                    backgroundColor: Colors.black54,
                    textColor: Colors.white,
                    fontSize: 14);
                print('Email error');
                isValid = false;
              } else {
                _emailError = null;
              }
              if (_password.text.length < 5) {
                _passwordError = 'password must be have 6 letters';
                Fluttertoast.showToast(
                    msg: 'password must be have 6 letters',
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.SNACKBAR,
                    backgroundColor: Colors.black54,
                    textColor: Colors.white,
                    fontSize: 14);
                print('password error');
                isValid = false;
              } else {
                _passwordError = null;
              }

              if (isValid) {
                Authentication().Sinin(
                  email: _email.text,
                  password: _password.text,
                  context: context,
                );
              }
            },
            child: Text(
              "Log In",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.4,
                child: Divider(
                  color: Colors.black54,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  "or",
                  style: TextStyle(color: Colors.black54, fontSize: 17),
                ),
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.4,
                child: Divider(
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _GoogleOrFaceBook() {
    return Column(
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height * 0.05,
          width: MediaQuery.sizeOf(context).width * 0.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black54, width: 2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.sizeOf(context).height * 0.03,
                width: MediaQuery.sizeOf(context).width * 0.1,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/Login/google.png"),
                  ),
                ),
              ),
              Text(
                'Continue with Google',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: MediaQuery.sizeOf(context).height * 0.05,
          width: MediaQuery.sizeOf(context).width * 0.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black54, width: 2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.sizeOf(context).height * 0.03,
                width: MediaQuery.sizeOf(context).width * 0.1,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/Login/facebook.png"),
                  ),
                ),
              ),
              Text(
                'Continue with Facebook',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ],
    );
  }
}
