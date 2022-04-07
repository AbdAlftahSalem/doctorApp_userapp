import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mydoctor_user_app/constant/constant.dart';
import 'package:mydoctor_user_app/controllers/chat_controller.dart';
import 'package:mydoctor_user_app/controllers/home_controller.dart';
import 'package:mydoctor_user_app/model/doctors_model.dart';
import 'package:mydoctor_user_app/pages/screens.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ChatList extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final chatList = [
    {
      'name': 'Ronan Peiterson',
      'image': 'assets/doctor/doctor-1.png',
      'msg': 'Hello, How can i help you?',
      'time': '1d ago',
      'status': 'unread'
    },
    {
      'name': 'Brayden Trump',
      'image': 'assets/doctor/doctor-2.png',
      'msg': 'Okay',
      'time': '1d ago',
      'status': 'read'
    },
    {
      'name': 'Apollonia Ellison',
      'image': 'assets/doctor/doctor-3.png',
      'msg': 'Good',
      'time': '5d ago',
      'status': 'read'
    },
    {
      'name': 'Beatriz Watson',
      'image': 'assets/doctor/doctor-4.png',
      'msg': 'Take care.',
      'time': '1w ago',
      'status': 'read'
    },
    {
      'name': 'Ronan Peiterson',
      'image': 'assets/doctor/doctor-1.png',
      'msg': 'Hello, How can i help you?',
      'time': '1d ago',
      'status': 'unread'
    },
    {
      'name': 'Brayden Trump',
      'image': 'assets/doctor/doctor-2.png',
      'msg': 'Okay',
      'time': '1d ago',
      'status': 'read'
    },
    {
      'name': 'Apollonia Ellison',
      'image': 'assets/doctor/doctor-3.png',
      'msg': 'Good',
      'time': '5d ago',
      'status': 'read'
    },
    {
      'name': 'Beatriz Watson',
      'image': 'assets/doctor/doctor-4.png',
      'msg': 'Take care.',
      'time': '1w ago',
      'status': 'read'
    }
  ];

  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
        init: ChatController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: whiteColor,
            appBar: AppBar(
              backgroundColor: whiteColor,
              automaticallyImplyLeading: false,
              elevation: 1.0,
              title: Text(
                'Chats',
                style: appBarTitleTextStyle,
              ),
            ),
            body: (chatList.length == 0)
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat,
                          color: greyColor,
                          size: 70.0,
                        ),
                        heightSpace,
                        Text(
                          'No Chat Available',
                          style: greyNormalTextStyle,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: controller.listLastMessageModel.length,
                    itemBuilder: (context, index) {
                      final item = controller.listLastMessageModel[index];
                      final time =
                          DateFormat.jm().format(DateTime.parse(item.dateTime));
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  duration: Duration(milliseconds: 500),
                                  type: PageTransitionType.rightToLeft,
                                  child: ChatScreen(
                                    idDoctor: item.receiverId,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(fixPadding * 2.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 70.0,
                                    height: 70.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(35.0),
                                      border: Border.all(
                                          width: 0.3, color: primaryColor),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            item.profileImageReceiver),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  widthSpace,
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    item.nameReceiver,
                                                    style:
                                                        blackNormalBoldTextStyle,
                                                  ),
                                                  SizedBox(width: 7.0),
                                                  (item.read == 'false')
                                                      ? Container(
                                                          width: 10.0,
                                                          height: 10.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0),
                                                            color: primaryColor,
                                                          ),
                                                        )
                                                      : Container(),
                                                ],
                                              ),
                                              heightSpace,
                                              Text(
                                                item.content,
                                                style: greySmallTextStyle,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Wrap(
                                          children: [
                                            Text(
                                              time,
                                              style: greySmallTextStyle,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          divider(),
                        ],
                      );
                    },
                  ),
          );
        });
  }

  divider() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      width: MediaQuery.of(context).size.width - fixPadding * 4.0,
      height: 1.0,
      color: Colors.grey[200],
    );
  }
}
