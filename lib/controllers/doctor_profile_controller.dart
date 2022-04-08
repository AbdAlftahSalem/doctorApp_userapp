import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import '../model/review_model.dart';

class DoctorProfileController extends GetxController {
  List<ReviewModel> reviewList = [];

  getReview() async {
    FirebaseFirestore.instance.collection("review").get().then(
      (value) {
        value.docs.forEach(
          (element) {
            print(element.data());
            reviewList.add(ReviewModel.fromMap(element.data()));
            update();
          },
        );
      },
    );
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getReview();
  }
}
