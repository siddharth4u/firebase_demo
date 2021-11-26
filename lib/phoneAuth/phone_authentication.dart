import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PhoneAuthentication extends StatefulWidget {
  @override
  _PhoneAuthenticationState createState() => _PhoneAuthenticationState();
}

class _PhoneAuthenticationState extends State<PhoneAuthentication> {
  //
  bool codeSend = false;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  String? verificationId;
  String errorMessage = '';

  //
  @override
  void initState() {
    super.initState();
  }

  //
  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
    otpController.dispose();
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          //
          Text('$errorMessage'),

          //
          SizedBox(height: 32),

          //
          codeSend ? otpVerificationScreen() : phoneVerificationScreen(),
        ],
      ),
    );
  }

  Widget phoneVerificationScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //
        Text('Phone Verification'),

        SizedBox(height: 32),

        //
        TextField(
          controller: phoneController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(hintText: 'Phone Number'),
        ),

        SizedBox(height: 32),

        //
        ElevatedButton(
          child: Text('Send OTP'),
          onPressed: () {
            //
            autoPhoneVerification();
          },
        ),
      ],
    );
  }

  //
  Widget otpVerificationScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //
        Text('OPT Verification'),

        SizedBox(height: 32),

        //
        TextField(
          controller: otpController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(hintText: 'OTP'),
        ),

        SizedBox(height: 32),

        //
        ElevatedButton(
          child: Text('Verify OTP'),
          onPressed: () {
            //
            manualPhoneVerification();
          },
        ),
      ],
    );
  }

  //
  Future<void> autoPhoneVerification() async {
    try {
      firebaseAuth.verifyPhoneNumber(
        timeout: Duration(seconds: 120),
        phoneNumber: phoneController.text,

        //
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          print('Doning automatic verification...');

          // write smsCode in otp text field
          otpController.text = phoneAuthCredential.smsCode!;

          // Create user in fireabase
          UserCredential userCredential =
              await firebaseAuth.signInWithCredential(phoneAuthCredential);

          User? user = userCredential.user;

          if (user != null) {
            // done
            print('User Created');
          } else {
            setState(() {
              errorMessage = 'Unable to Create User';
            });
          }
        },

        //
        verificationFailed: (FirebaseAuthException error) {
          setState(() {
            errorMessage = 'Phone Verification Falied';
          });
        },

        //
        codeSent: (String verificationId, int? foreceReSend) {
          this.verificationId = verificationId;
          setState(() {
            codeSend = true;
          });
        },

        //
        codeAutoRetrievalTimeout: (String verificationId) {
          //
        },
      );
    } on FirebaseAuthException catch (error) {
      setState(() {
        errorMessage = '${error.message}';
      });
    }
  }

  //
  Future<void> manualPhoneVerification() async {
    try {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationId!,
        smsCode: otpController.text,
      );

      UserCredential userCredential =
          await firebaseAuth.signInWithCredential(phoneAuthCredential);

      User? user = userCredential.user;

      if (user != null) {
        // done
        print('User Created');
      } else {
        setState(() {
          errorMessage = 'Unable to Create User';
        });
      }
    } on FirebaseAuthException catch (error) {
      setState(() {
        errorMessage = '${error.message}';
      });
    }
  }
}
