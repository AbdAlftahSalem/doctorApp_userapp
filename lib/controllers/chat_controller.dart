import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mydoctor_user_app/controllers/localDB/local_db.dart';
import 'package:mydoctor_user_app/model/doctors_model.dart';

import '../model/chat_model.dart';
import '../model/last_message_model.dart';

class ChatController extends GetxController {
  List<MessageModel> listChatMessages = [];
  List<DoctorModel> listChatDoctor = [];
  List<LastMessageModel> listLastMessageModel = [];

  MessageModel chatUser = MessageModel(
    content: '',
    dateTime: '',
    receiverId: '',
    senderId: '',
    index: 0,
    idMessage: '',
    nameReceiver: '',
    nameSender: '',
    profileImageSender: '',
    profileImageReceiver: '',
  );

  getIdUser() {
    return LocalDB.getData("User");
  }

  getLastMessage() async {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(getIdUser()["id"])
        .collection("lastMessage")
        .snapshots()
        .listen((event) {
      listChatMessages = [];
      event.docs.forEach((element) {
        listLastMessageModel.add(LastMessageModel.fromMap(element.data()));
        update();
      print(listLastMessageModel.length);
      });
    });
    update();
  }

  // String generateRandomString(int len) {
  //   var r = Random();
  //   const _chars =
  //       'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  //   return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
  //       .join();
  // }

  @override
  void onInit() async {
    super.onInit();
    await getLastMessage();
  }
}
