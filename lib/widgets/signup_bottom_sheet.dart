import 'package:chefmenu2/widgets/cta_button.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:chefmenu2/theme/style_constants.dart';
import 'package:universal_io/io.dart';
import 'package:flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupBottomSheet extends StatefulWidget {
  @override
  _SignupBottomSheetState createState() => _SignupBottomSheetState();
}

class _SignupBottomSheetState extends State<SignupBottomSheet> {
  bool step1Done = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: Duration(milliseconds: 400),
      curve: Curves.easeOutSine,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
          color: MediaQuery.of(context).platformBrightness == Brightness.dark ? colorIosSafariDark : colorIosSafariLight,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(kSignupBottomSheetCornerRadius),
          ),
        ),
        child: step1Done
            ? SignupStep2()
            : SignupStep1(
                step1DoneCallback: () {
                  setState(() {
                    step1Done = true;
                  });
                },
              ),
      ),
    );
  }
}

class SignupStep2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kCtaHeight / 2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: kSignupFieldPadding),
          SwipableHorizontalLine(),
          SizedBox(height: kSignupBottomSheetCornerRadius / 2),
          Text(
            '¡Enhorabuena!',
            textAlign: TextAlign.center,
            style:
                MediaQuery.of(context).platformBrightness == Brightness.dark ? ktsSignupFieldStep2DarkThemeTitle : ktsSignupFieldStep2LightThemeTitle,
          ),
          SizedBox(height: kSignupBottomSheetCornerRadius / 2),
          Text(
            'Una vez que el Admin para crear el menú esté listo, le enviaremos el enlace a su email.',
            textAlign: TextAlign.center,
            style: MediaQuery.of(context).platformBrightness == Brightness.dark ? ktsSignupStep2DarkThemeMessage : ktsSignupStep2LightThemeMessage,
          ),
          SizedBox(height: kSignupBottomSheetCornerRadius / 2),
          Text(
            'Trabajamos para que funcione genial.',
            textAlign: TextAlign.center,
            style: MediaQuery.of(context).platformBrightness == Brightness.dark ? ktsSignupStep2DarkThemeMessage : ktsSignupStep2LightThemeMessage,
          ),
          SizedBox(height: kSignupBottomSheetCornerRadius / 2),
        ],
      ),
    );
  }
}

class SignupStep1 extends StatelessWidget {
  final Function step1DoneCallback;
  SignupStep1({this.step1DoneCallback});
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
          onComplete: () {
            FocusScope.of(context).nextFocus();
          },
        ),
        SignupField(
          hint: 'contraseña',
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          onComplete: () {
            print('tada');
          },
        ),
        SizedBox(height: kSignupBottomSheetCornerRadius / 2 - kBigBoxPadding),
        CtaButton(
          onTap: () async {
            try {
              UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: "barry.allen@example.com", password: "12345");
            } /* on FirebaseAuthException catch (e) {
              if (e.code == 'weak-password') {
                print('The password provided is too weak: ${e.toString()}');
              } else if (e.code == 'email-already-in-use') {
                print(e.toString());
                print('The account already exists for that email.');
              }
            } */
            catch (e) {
              print(e.toString());
              print('huhululu');
              Flushbar(
                margin: EdgeInsets.all(kFlushbarPadding),
                backgroundColor: colorIosSafariDark,
                icon: Icon(Icons.error, color: colorRed),
                title: 'Error',
                message: e.toString(),
                borderRadius: 100,
                flushbarPosition: FlushbarPosition.TOP,
                duration: Duration(seconds: 15),
              ).show(context);
            }

            step1DoneCallback();
          },
        ),
        SizedBox(height: kSignupBottomSheetCornerRadius / 2),
      ],
    );
  }
}

class SwipableHorizontalLine extends StatelessWidget {
  const SwipableHorizontalLine({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: kSignupBottomSheetHorizontalLineWidth,
        height: kSignupBottomSheetHorizontalLineHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(90)),
          color: MediaQuery.of(context).platformBrightness == Brightness.dark
              ? colorSignupBottomSheetHorizontalDarkLine
              : colorSignupBottomSheetHorizontalLightLine,
        ));
  }
}

class SignupField extends StatelessWidget {
  final String hint;
  final TextInputType keyboardType;
  final bool obscureText;
  final Function onComplete;
  SignupField({this.hint, this.keyboardType, this.obscureText = false, this.onComplete});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: (Platform.isIOS || Platform.isAndroid) ? null : 500,
      padding: const EdgeInsets.symmetric(vertical: kSignupFieldPadding, horizontal: kCtaHeight / 2),
      child: TextField(
        onEditingComplete: onComplete,
        keyboardAppearance: Brightness.dark,
        textInputAction: TextInputAction.next,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: ktsSignupField,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: ktsHintSignupField,
          fillColor: colorBackground,
          focusColor: Colors.purple,
          filled: true,
          enabled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(kSignupFieldCornerRadius)),
            //borderSide: BorderSide(color: Colors.blue),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(kSignupFieldCornerRadius)),
          ),
        ),
      ),
    );
  }
}
