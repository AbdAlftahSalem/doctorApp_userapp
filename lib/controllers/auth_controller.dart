import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mydoctor_user_app/controllers/localDB/local_db.dart';
import 'package:mydoctor_user_app/pages/bottom_bar.dart';
import 'package:mydoctor_user_app/pages/login_signup/otp.dart';

import '../pages/login_signup/register.dart';

class AuthController extends GetxController {
  String phoneNumber = '';
  String? phoneIsoCode;
  String? dialCode;
  String verificationId = "";
  String otp1 = "", otp2 = "", otp3 = "", otp4 = "", otp5 = "", otp6 = "";
  bool finishTarget = false;
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  onPhoneNumberChange({required String number, required String dialCode}) {
    phoneNumber = number;
    this.dialCode = dialCode;
    print(number);
    update();
  }

  sendOTP() async {
    print(phoneNumber);
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "$phoneNumber",
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        Get.snackbar("Message", "Some thing error");
        print(e);
      },
      codeSent: (String verificationId, int? resendToken) {
        this.verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        this.verificationId = verificationId;
      },
    );
    Get.to(() => OTPScreen());
  }

  verifyOTp(String otp) async {
    finishTarget = false;
    update();
    print(otp);
    var credential = await FirebaseAuth.instance.signInWithCredential(
      PhoneAuthProvider.credential(
          verificationId: this.verificationId, smsCode: otp),
    );
    if (credential.user != null) {
      Get.to(() => Register());
    } else {
      Get.snackbar("Message", "Please enter valid OTP");
    }
    finishTarget = true;
    update();
  }

  singUpUser() async {
    if (password.text.trim() == confirmPassword.text.trim()) {
      String id = generateRandomString(10);
      Map<String, String> userData = {
        "email": email.text,
        "username": username.text,
        "password": password.text,
        "phone": phoneNumber,
        "id": id,
        "status": "online",
      };
      await FirebaseFirestore.instance.collection("Users").doc(id).set(userData);
      await LocalDB.setData("User", userData);
      // Navigator.push(
      //     context,
      //     PageTransition(
      //         duration: Duration(milliseconds: 600),
      //         type: PageTransitionType.fade,
      //         child: BottomBar()));
      Get.to(() => BottomBar());
    } else {
      Get.snackbar("Message", "Please check password");
    }
  }

  static String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }
}
