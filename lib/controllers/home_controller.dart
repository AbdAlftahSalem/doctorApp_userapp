import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mydoctor_user_app/model/doctors_model.dart';
import 'package:mydoctor_user_app/model/lab_model.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  List<DoctorModel> doctors = [];
  List<LabModel> lab = [];
  bool finishGetData = false;

  getDoctors() async {
    await FirebaseFirestore.instance.collection("Doctors").get().then((value) {
      value.docs.forEach((element) {
        doctors.add(DoctorModel.fromMap(element.data()));
      });
    });
    print("doctors.length  ${doctors.length}");
    update();
  }

  getLaps() async {
    await FirebaseFirestore.instance.collection("Laps").get().then((value) {
      value.docs.forEach((element) {
        print(element.data()["iamge"]);
        lab.add(LabModel.fromMap(element.data()));
      });
    });

    print(lab[0].name);

    update();
  }

  void launchURL(String phone) async {
    try {
      await launch('tel:$phone');
    } catch (e) {
      print(e);
      Get.snackbar("Message", e.toString());
    }
  }

  @override
  void onInit() async {
    super.onInit();
    await getDoctors();
    await getLaps();
    finishGetData = true;
    update();
  }
}
