import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_flutter/Resources/Colors.dart';
import '/Component/button.dart';
import '../constants.dart';
import 'Home_Screen.dart';
import 'Register_Screen.dart';
import 'package:instagram_flutter/Resources/Colors.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: formkey,
              child: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.light,
                child: Stack(
                  children: [
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: Colors.white,
                      child: SingleChildScrollView(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 120),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/FishedLogo.png'),
                            SizedBox(height: 50),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) {
                                email = value;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Epost kan ikke være blank!";
                                }
                              },
                              textAlign: TextAlign.center,
                              decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Epost',
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: fishedBlue,
                                ),
                              ),
                            ),
                            SizedBox(height: 25),
                            TextFormField(
                              obscureText: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Passord kan ikke være blankt!";
                                }
                              },
                              onChanged: (value) {
                                password = value;
                              },
                              textAlign: TextAlign.center,
                              decoration: kTextFieldDecoration.copyWith(
                                  hintText: 'Passord',
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: fishedBlue,
                                  )),
                            ),
                            SizedBox(height: 50),
                            LoginSignupButton(
                              title: 'Logg inn',
                              ontapp: () async {
                                if (formkey.currentState!.validate()) {
                                  setState(() {
                                    isloading = true;
                                  });
                                  try {
                                    await _auth.signInWithEmailAndPassword(
                                        email: email, password: password);

                                    await Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (contex) => HomeScreen(),
                                      ),
                                    );

                                    setState(() {
                                      isloading = false;
                                    });
                                  } on FirebaseAuthException catch (e) {
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: Text(
                                            "Noe gikk galt, innlogging feilet!"),
                                        content: Text('${e.message}'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(ctx).pop();
                                            },
                                            child:
                                                Text('Innlogging vellykket!'),
                                          )
                                        ],
                                      ),
                                    );
                                    print(e);
                                  }
                                  setState(() {
                                    isloading = false;
                                  });
                                }
                              },
                            ),
                            SizedBox(height: 30),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => SignupScreen(),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Har ikke du konto?",
                                    style: TextStyle(
                                        fontSize: 15, color: fishedBlue),
                                  ),
                                  SizedBox(width: 25),
                                  Hero(
                                    tag: '1',
                                    child: Text(
                                      'Registrer deg her!',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: fishedBlue),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
