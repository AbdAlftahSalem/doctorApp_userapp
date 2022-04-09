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
  bool sendCode = true;

  onPhoneNumberChange({required String number, required String dialCode}) {
    phoneNumber = number;
    this.dialCode = dialCode;
    print(number);
    update();
  }

  // checkPhoneNum() async {
  //   FirebaseFirestore.instance
  //       .collection("Users")
  //       .where("phone", isEqualTo: phoneNumber)
  //       .get()
  //       .then((value) {
  //     if (value.docs.length == 0) {
  //     } else {
  //       Get.snackbar("Message", "This phone is already sign in");
  //     }
  //   });
  // }

  sendOTP() async {
    sendCode = false;
    update();
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "$phoneNumber",
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        print("The error is $e");
        Get.snackbar("Message", "Some thing error please try again");
        sendCode = true;
        update();
      },
      codeSent: (String verificationId, int? resendToken) {
        this.verificationId = verificationId;
        sendCode = true;
        update();
    Get.to(() => OTPScreen());
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        this.verificationId = verificationId;
        sendCode = true;
        update();
      },
    );
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
      FirebaseFirestore.instance
          .collection("Users")
          .where("phone", isEqualTo: "+970598045064")
          .get()
          .then((value) {
        if (value.docs.length == 0) {
          Get.to(() => Register());
        } else {
          LocalDB.setData("User", value.docs[0].data());
          print(LocalDB.getData("User"));
          Get.to(() => BottomBar());
        }
      });
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
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(id)
          .set(userData);
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
