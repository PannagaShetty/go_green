import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gogreen/components/custom_button.dart';
import 'package:gogreen/screens/home_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../constants.dart';

class LoginPage extends StatefulWidget {
  static String id = 'login_screen';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;

  String userEmail;
  String password;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  Future<FirebaseUser> _signIn() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: gSA.accessToken,
      idToken: gSA.idToken,
    );
    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    print(user.email);

    return user;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Builder(
        builder: (context) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Hero(
                      tag: 'logo',
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: kBackgroundColor,
                        backgroundImage: AssetImage('images/Asset.png'),
                      ),
                    ),
                    Hero(
                      tag: 'text',
                      child: Text(
                        "Go Green",
                        style: TextStyle(
                          fontSize: 35.0,
                          color: kInputTextColor,
                          fontFamily: 'Pacifico',
                        ),
                      ),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  color: kBackgroundColor,
//                    borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              GestureDetector(
                onTap: () async {
                  FirebaseUser user = await _signIn();
                  if (user != null) {
                    Navigator.pushReplacementNamed(context, HomeScreen.id);
                  } else {
                    Fluttertoast.showToast(msg: 'Select a Account');
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  width: MediaQuery.of(context).size.width * 3 / 4,
                  decoration: kInputContainerDecoration,
                  child: ListTile(
                    leading: Image.network(
                      'https://pluspng.com/img-png/google-logo-png-open-2000.png',
                      width: 25.0,
                    ),
                    title: Text(
                      'SIGN IN WITH GOOGLE',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                'or',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 15.0,
              ),
              GestureDetector(
                onTap: () async {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return SingleChildScrollView(
                          child: Container(
                            color: Color(0xff707175),
                            child: Container(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: Container(
                                padding: EdgeInsets.fromLTRB(20.0, 20, 20, 20),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: TextField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        textAlign: TextAlign.center,
                                        onChanged: (value) {
                                          userEmail = value;
                                        },
                                        decoration: kTextFieldDecoration
                                            .copyWith(hintText: 'Enter Email'),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: TextField(
                                        obscureText: true,
                                        textAlign: TextAlign.center,
                                        onChanged: (value) {
                                          password = value;
                                        },
                                        decoration:
                                            kTextFieldDecoration.copyWith(
                                                hintText: 'Enter Password'),
                                      ),
                                    ),
                                    CustomButton(
                                      inputText: 'Log In',
                                      onPress: () async {
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
//                                        Navigator.pop(context);
                                        setState(() {
                                          isLoading = true;
                                        });
                                        try {
                                          final newUser = await _auth
                                              .createUserWithEmailAndPassword(
                                            email: userEmail,
                                            password: password,
                                          );
                                          print(newUser);
                                          if (newUser != null) {
                                            Navigator.pushReplacementNamed(
                                                context, HomeScreen.id);
                                          }
                                        } catch (e) {
                                          try {
                                            final newUser = await _auth
                                                .signInWithEmailAndPassword(
                                              email: userEmail,
                                              password: password,
                                            );
                                            if (newUser != null) {
                                              Navigator.pushReplacementNamed(
                                                  context, HomeScreen.id);
                                            }
                                          } catch (e) {
                                            print('invalid');
                                            Fluttertoast.showToast(
                                                msg:
                                                    'Invalid Email or Password');
                                          }
                                        }
                                        setState(() {
                                          isLoading = false;
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Opacity(
                                        opacity: 0.6,
                                        child: Text(
                                            'Note: Please Enter a New Password while Logging in for First Time '),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25),
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                },
                child: isLoading
                    ? CircularProgressIndicator()
                    : Container(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        width: MediaQuery.of(context).size.width * 3 / 4,
                        decoration: kInputContainerDecoration,
                        child: ListTile(
                          leading: Image.network(
                            'https://upload.wikimedia.org/wikipedia/commons/b/bc/It_is_a_official_logo_of_SDM_Institute_of_Technology%2C_Ujire.jpg',
                            width: 25.0,
                          ),
                          title: Text(
                            'SIGN IN WITH SDM ID',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
