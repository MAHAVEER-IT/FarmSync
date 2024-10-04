import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:farmsync/colors/colors.dart';
import 'package:farmsync/userprofile/Auth_firebase.dart';
import 'package:farmsync/userprofile/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegExp emailRegExp = RegExp(
    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
  );

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();

  String? _emailError;
  String? _passwordError;
  bool _textAnimation = false;

  String? _selectedItem = 'Select';
  List<String> _doList = ['Former', 'Doctor'];

  @override
  Widget build(BuildContext context) {
    final ScreenSize = MediaQuery.of(context).size;
    final width = ScreenSize.width;
    final height = ScreenSize.height;
    return Scaffold(
      backgroundColor: backgroundColor3.withOpacity(0.95),
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  _AnimatedText(),
                  SizedBox(
                    height: 15,
                  ),
                  _Content(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _AnimatedText() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _textAnimation
            ? Center(
                child: Text(
                  "FormSync",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black45,
                        offset: Offset(5, 5),
                      ),
                    ],
                  ),
                ),
              )
            : Center(
                child: SizedBox(
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black45,
                          offset: Offset(5, 5),
                        ),
                      ],
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TyperAnimatedText(
                          "FormSync",
                          speed: Duration(milliseconds: 200),
                        ),
                      ],
                      totalRepeatCount: 1,
                      isRepeatingAnimation: false,
                      onFinished: () {
                        setState(() {
                          _textAnimation = true;
                        });
                      },
                    ),
                  ),
                ),
              ),
      ],
    );
  }

  Widget _Content() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            height: MediaQuery.sizeOf(context).height * 0.77,
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'REGISTER',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black45,
                          offset: Offset(5, 5),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.45,
                          child: TextFormField(
                            controller: _firstName,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              label: Text('First Name'),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.45,
                          child: TextFormField(
                            controller: _lastName,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              label: Text('Last Name'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      child: TextFormField(
                        controller: _email,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          label: Text('Email'),
                          suffixIcon: Icon(Icons.email_outlined),
                          errorText: _emailError,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      child: IntlPhoneField(
                        controller: _phoneNumber,
                        initialCountryCode: "IN",
                        decoration: InputDecoration(
                          label: Text('Enter phone number'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      child: TextFormField(
                        controller: _password,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            label: Text('Set Password'),
                            suffixIcon: Icon(Icons.lock),
                            errorText: _passwordError),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Select Work :',
                          style: TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.25,
                          height: MediaQuery.sizeOf(context).height * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black54),
                          ),
                          child: Center(
                            child: DropdownButton<String>(
                              hint: Text('${_selectedItem}'),
                              items: _doList.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newvalue) {
                                setState(
                                  () {
                                    _selectedItem = newvalue;
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      height: MediaQuery.sizeOf(context).height * 0.055,
                      child: ElevatedButton(
                        onPressed: () async {
                          bool isValid = true;
                          if (!emailRegExp.hasMatch(_email.text)) {
                            setState(() {
                              _emailError = 'Invalid Email';
                            });
                            print('Email error');
                            isValid = false;
                          } else {
                            _emailError = null;
                          }
                          if (_password.text.length < 5) {
                            _passwordError = 'password must be have 6 letters';
                            print('password error');
                            isValid = false;
                          } else {
                            _passwordError = null;
                          }
                          if (_phoneNumber.text == null ||
                              _phoneNumber.text.length == 0) {
                            Fluttertoast.showToast(
                                msg: 'Enter Mobile Number ',
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.SNACKBAR,
                                backgroundColor: Colors.black54,
                                textColor: Colors.white,
                                fontSize: 14);
                            isValid = false;
                          }
                          if (_firstName.text.length == 0) {
                            Fluttertoast.showToast(
                                msg: 'Please Enter First Name ',
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.SNACKBAR,
                                backgroundColor: Colors.black54,
                                textColor: Colors.white,
                                fontSize: 14);
                            isValid = false;
                          }
                          if (_selectedItem == 'Select') {
                            Fluttertoast.showToast(
                                msg: 'Select Your Work ',
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.SNACKBAR,
                                backgroundColor: Colors.black54,
                                textColor: Colors.white,
                                fontSize: 14);
                            isValid = false;
                          }

                          if (isValid) {
                            await Authentication().Sinup(
                              email: _email.text,
                              password: _password.text,
                              firstname: _firstName.text,
                              lastname: _lastName.text,
                              phoneNumber: _phoneNumber.text,
                              Work: _selectedItem,
                              context: context,
                            );
                          }
                        },
                        child: Text(
                          "REGISTER",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          Text(
                            "Already Have Account ? ",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.blue),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  _GoogleOrFacebook(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _GoogleOrFacebook() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
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
                    image: AssetImage("images/Login/google.png"),
                  ),
                ),
              ),
              Text(
                'Continue with Google',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
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
