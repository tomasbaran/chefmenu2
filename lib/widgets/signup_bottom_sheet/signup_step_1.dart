import 'package:flutter/material.dart';
import 'package:chefmenu2/theme/style_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import '../cta_button.dart';
import 'signup_field.dart';
import 'swipable_horizontal_line.dart';
import 'package:universal_io/io.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupStep1 extends StatefulWidget {
  final Function step1DoneCallback;
  SignupStep1({this.step1DoneCallback});

  @override
  _SignupStep1State createState() => _SignupStep1State();
}

class _SignupStep1State extends State<SignupStep1> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _email;
  String password;
  bool isLoading = false;

  Flushbar _errorFlushbar;

  void _dismissFlushbar() async {
    if (_errorFlushbar != null) await _errorFlushbar.dismiss();
  }

  void _showFlushbar(BuildContext context, String message) async {
    _dismissFlushbar();
    _errorFlushbar = Flushbar(
      margin: EdgeInsets.all(kFlushbarPadding),
      backgroundColor: colorIosSafariDark,
      icon: Icon(Icons.error, color: colorRed),
      title: 'Error',
      message: message,
      borderRadius: 100,
      flushbarPosition: FlushbarPosition.TOP,
      duration: Duration(seconds: 10),
    );
    _errorFlushbar.show(context);
    return;
  }

  void registerUser(String email, String password) async {
    try {
      _dismissFlushbar();
      setState(() {
        isLoading = true;
      });
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      // if no error mark step1Done = true
      widget.step1DoneCallback(email);

      // write user info (esp. language) to DB
      _firestore.collection('owners').doc(_auth.currentUser.uid).set({
        'email': email,
        'language': Platform.localeName.toLowerCase().substring(0, 2),
        'uid': _auth.currentUser.uid,
      });

      setState(() {
        isLoading = false;
      });
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'weak-password') {
        message = 'The password needs to have at least 6 characters.';
      } else if (e.code == 'email-already-in-use') {
        print('e: $e email: $email');
        //message = 'The account already exists for that email.';
        message = '$e email: $email';
      } else if (e.code == 'invalid-email') {
        message = 'The email address format is NOT correct. It looks like you made a typo while typing your email address.';
      } else {
        message = e.toString();
      }
      setState(() {
        isLoading = false;
      });
      _showFlushbar(context, message);
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      _showFlushbar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: kSignupFieldPadding),
        SwipableHorizontalLine(),
        SizedBox(height: kSignupBottomSheetCornerRadius / 2),
        SignupField(
          hint: 'email',
          keyboardType: TextInputType.emailAddress,
          onChanged: (_) {
            _email = _;
          },
          onComplete: () {
            FocusScope.of(context).nextFocus();
          },
        ),
        SignupField(
          hint: 'contraseña',
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          onChanged: (_) {
            password = _;
          },
        ),
        SizedBox(height: kSignupBottomSheetCornerRadius / 2 - kBigBoxPadding),
        CtaButton(
          isLoading: isLoading,
          onTap: () {
            registerUser(_email, password);
          },
        ),
        SizedBox(height: kSignupBottomSheetCornerRadius / 2),
      ],
    );
  }
}
