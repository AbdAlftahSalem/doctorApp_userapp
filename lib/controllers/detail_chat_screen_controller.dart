import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mydoctor_user_app/model/chat_model.dart';
import 'package:mydoctor_user_app/pages/patient/patient_directory.dart';

import '../model/doctors_model.dart';
import 'localDB/local_db.dart';

class DetailChatScreenController extends GetxController {
  List<MessageModel> listChatMessages = [];
  DoctorModel doctorModel = DoctorModel(
    city: '',
    typeDoctor: '',
    lat: '',
    phoneNumber: '',
    experience: '',
    name: "",
    id: '',
    reviewsNumbers: '',
    image: '',
    long: '',
    address: '',
  );

  getIdUser() {
    return LocalDB.getData("User");
  }

  getMessage(String receiveId) {
    FirebaseFirestore.instance
        .collection("Users")
        .doc(getIdUser()["id"])
        .collection('Chat')
        .doc(receiveId)
        .collection("Messages")
        .orderBy("index")
        .snapshots()
        .listen((event) {
      listChatMessages = [];
      event.docs.forEach((element) {
        listChatMessages.add(MessageModel.fromMap(element.data()));
        update();
      });
    });
    update();
  }

  sendMessage(MessageModel message, DoctorModel receiverUserMessage) async {
    int x = listChatMessages.length + 1;
    listChatMessages.length == 0 ? message.index = 1 : message.index = x;

    message.idMessage = generateRandomString(20);

    await sendMessageUser(message);

    await saveUserChatMessages(receiverUserMessage, message);
    update();
  }

  String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }

  sendMessageUser(MessageModel message) {
    FirebaseFirestore.instance
        .collection("Users")
        .doc(getIdUser()["id"])
        .collection("Chat")
        .doc(message.receiverId)
        .collection('Messages')
        .doc(message.idMessage)
        .set(message.toMap());

    FirebaseFirestore.instance
        .collection("Doctors")
        .doc(message.receiverId)
        .collection("Chat")
        .doc(getIdUser()["id"])
        .collection('Messages')
        .doc(message.idMessage)
        .set(message.toMap());

    FirebaseFirestore.instance
        .collection("Users")
        .doc(getIdUser()["id"])
        .collection("lastMessage")
        .doc(message.receiverId)
        .set({
      "address": "",
      "city": "",
      "experience": "",
      "lat": "",
      "long": "",
      "phoneNumber": "",
      "status": "",
      "typeDoctor": "",
      'dateTime': message.dateTime,
      'receiverId': message.receiverId,
      'senderId': message.senderId,
      'content': message.content,
      'idMessage': message.idMessage,
      'profileImageSender': message.profileImageSender,
      'profileImageReceiver': message.profileImageReceiver,
      'nameSender': message.nameSender,
      'nameReceiver': message.nameReceiver,
      'index': message.index,
      "read": getIdUser()["status"] == "online" ? "true" : "false",
    });

    FirebaseFirestore.instance
        .collection("Doctors")
        .doc(message.receiverId)
        .collection("lastMessage")
        .doc(getIdUser()["id"])
        .collection('Messages')
        .doc("lastMessageDetail")
        .set(message.toMap());
  }

  saveUserChatMessages(DoctorModel doctor, MessageModel message) {
    // if (message.index == 1) {
    //   FirebaseFirestore.instance
    //       .collection("Users")
    //       .doc(getIdUser()["id"])
    //       .collection('UserChats')
    //       .doc(doctor.id)
    //       .set(doctor.toMap());
    //
    //   FirebaseFirestore.instance
    //       .collection("Doctors")
    //       .doc(doctor.id)
    //       .collection('UserChats')
    //       .doc(getIdUser()["id"])
    //       .set(doctor.toMap());
    // }
  }

  getDoctor(String id) async {
    await FirebaseFirestore.instance
        .collection('Doctors')
        .where('id' , isEqualTo: id)
        .get()
        .then((value) {
      doctorModel = DoctorModel.fromMap(value.docs[0].data());
      update();
    });
    update();
  }

  @override
  void onInit() async {
    super.onInit();
  }
}
