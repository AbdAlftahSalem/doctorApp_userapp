import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:mydoctor_user_app/controllers/localDB/local_db.dart';
import 'package:mydoctor_user_app/model/appointment_model.dart';
import 'package:mydoctor_user_app/pages/screens.dart';

class AppointmentController extends GetxController {
  List<AppointmentModel> appointmentList = [];
  List<AppointmentModel> pastAppointmentList = [];
  List<AppointmentModel> cancelledAppointmentList = [];
  bool finishGetData = false;

  getLocalDB() {
    return LocalDB.getData("User");
  }

  getAppointment() {
    FirebaseFirestore.instance
        .collection("Users")
        .doc(getLocalDB()["id"])
        .collection("Active Appointments")
        .snapshots()
        .listen((event) {
      appointmentList = [];
      event.docs.forEach((element) {
        print(element.data());
        appointmentList.add(AppointmentModel.fromMap(element.data()));
        update();
      });
    });
    update();
  }

  getCancelAppointment() {
    FirebaseFirestore.instance
        .collection("Users")
        .doc(getLocalDB()["id"])
        .collection("Cancel Appointments")
        .snapshots()
        .listen((event) {
      cancelledAppointmentList = [];
      event.docs.forEach((element) {
        cancelledAppointmentList.add(AppointmentModel.fromMap(element.data()));
        update();
      });
    });
    update();
  }

  cancelOrder(AppointmentModel appointment) async {
    //    USER

    // Add Appointments to Cancel Appointments
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(getLocalDB()["id"])
        .collection("Cancel Appointments")
        .doc(appointment.id)
        .set(appointment.toMap());

    // Delete Appointments from Active Appointments
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(getLocalDB()["id"])
        .collection("Active Appointments")
        .doc(appointment.id)
        .delete();

    // DOCTOR

    await FirebaseFirestore.instance
        .collection("Doctors")
        .doc(appointment.idDoctor)
        .collection("Appointments")
        .doc(appointment.id)
        .delete();

    await getAppointment();
    await getCancelAppointment();
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    await getAppointment();
    await getCancelAppointment();
  }
}
