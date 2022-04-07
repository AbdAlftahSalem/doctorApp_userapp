import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:mydoctor_user_app/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:mydoctor_user_app/controllers/localDB/local_db.dart';
import 'package:mydoctor_user_app/model/appointment_model.dart';

import '../../controllers/appointment_controller.dart';

class Appointment extends StatefulWidget {
  @override
  _AppointmentState createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  // deleteAppointmentDialog(AppointmentModel appointment) {
  //   ;
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: GetBuilder<AppointmentController>(
          init: AppointmentController(),
          builder: (controller) {
            return Scaffold(
              backgroundColor: whiteColor,
              appBar: AppBar(
                backgroundColor: whiteColor,
                elevation: 1.0,
                automaticallyImplyLeading: false,
                title: Text(
                  'Appointments',
                  style: appBarTitleTextStyle,
                ),
                bottom: TabBar(
                  tabs: [
                    Tab(
                      child:
                          tabItem('Active', controller.appointmentList.length),
                    ),
                    Tab(
                      child: tabItem(
                          'Past', controller.pastAppointmentList.length),
                    ),
                    Tab(
                      child: tabItem('Cancelled',
                          controller.cancelledAppointmentList.length),
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  activeAppointment(controller),
                  pastAppointment(controller),
                  cancelledAppointment(controller),
                ],
              ),
            );
          }),
    );
  }

  tabItem(text, number) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          text,
          style: blackSmallTextStyle,
        ),
        SizedBox(width: 4.0),
        Container(
          width: 20.0,
          height: 20.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: primaryColor,
          ),
          child: Text(
            '$number',
            style: TextStyle(
              color: whiteColor,
              fontSize: 10.0,
            ),
          ),
        ),
      ],
    );
  }

  activeAppointment(AppointmentController controller) {
    return (controller.appointmentList.length == 0)
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.date_range,
                  color: greyColor,
                  size: 70.0,
                ),
                heightSpace,
                Text(
                  'No Active Appointments',
                  style: greyNormalTextStyle,
                ),
              ],
            ),
          )
        : ListView.builder(
            itemCount: controller.appointmentList.length,
            itemBuilder: (context, index) {
              final item = controller.appointmentList[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(fixPadding * 2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 80.0,
                          height: 80.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.0),
                            border: Border.all(width: 1.0, color: Colors.green),
                            color: Colors.green[50],
                          ),
                          child: Text(
                            item.date,
                            textAlign: TextAlign.center,
                            style: greenColorNormalTextStyle,
                          ),
                        ),
                        widthSpace,
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    item.time,
                                    style: blackHeadingTextStyle,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      deleteAppointmentDialog(
                                          context, controller, item);
                                    },
                                    child: Icon(
                                      Icons.close,
                                      size: 18.0,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 7.0),
                              Text(
                                item.doctorName,
                                style: blackNormalTextStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 7.0),
                              Text(
                                item.doctorType,
                                style: primaryColorsmallTextStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  divider(),
                ],
              );
            },
          );
  }

  deleteAppointmentDialog(BuildContext context,
      AppointmentController controller, AppointmentModel item) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Dialog(
          elevation: 0.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Wrap(
            children: [
              Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Are you sure you want to cancel this appointment?",
                      style: blackNormalTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: (MediaQuery.of(context).size.width / 3.5),
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Text(
                              'No',
                              style: primaryColorButtonTextStyle,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            var user;
                            controller.cancelOrder(item);

                            Navigator.pop(context);
                          },
                          child: Container(
                            width: (MediaQuery.of(context).size.width / 3.5),
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Text(
                              'Yes',
                              style: whiteColorButtonTextStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  pastAppointment(AppointmentController controller) {
    return (controller.pastAppointmentList.length == 0)
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.date_range,
                  color: greyColor,
                  size: 70.0,
                ),
                heightSpace,
                Text(
                  'No Past Appointments',
                  style: greyNormalTextStyle,
                ),
              ],
            ),
          )
        : ListView.builder(
            itemCount: controller.pastAppointmentList.length,
            itemBuilder: (context, index) {
              final item = controller.pastAppointmentList[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(fixPadding * 2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 80.0,
                          height: 80.0,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.0),
                            border: Border.all(width: 1.0, color: primaryColor),
                            color: primaryColor.withOpacity(0.15),
                          ),
                          child: Text(
                            item.date,
                            textAlign: TextAlign.center,
                            style: primaryColorNormalTextStyle,
                          ),
                        ),
                        widthSpace,
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.time,
                                style: blackHeadingTextStyle,
                              ),
                              SizedBox(height: 7.0),
                              Text(
                                item.doctorName,
                                style: blackNormalTextStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 7.0),
                              Text(
                                item.doctorType,
                                style: primaryColorsmallTextStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  divider(),
                ],
              );
            },
          );
  }

  cancelledAppointment(AppointmentController controller) {
    return (controller.cancelledAppointmentList.length == 0)
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.date_range,
                  color: greyColor,
                  size: 70.0,
                ),
                heightSpace,
                Text(
                  'No Cancelled Appointments',
                  style: greyNormalTextStyle,
                ),
              ],
            ),
          )
        : ListView.builder(
            itemCount: controller.cancelledAppointmentList.length,
            itemBuilder: (context, index) {
              final item = controller.cancelledAppointmentList[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(fixPadding * 2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 80.0,
                          height: 80.0,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.0),
                            border: Border.all(width: 1.0, color: Colors.red),
                            color: Colors.red[50],
                          ),
                          child: Text(
                            item.date,
                            textAlign: TextAlign.center,
                            style: redColorNormalTextStyle,
                          ),
                        ),
                        widthSpace,
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.time,
                                style: blackHeadingTextStyle,
                              ),
                              SizedBox(height: 7.0),
                              Text(
                                item.doctorName,
                                style: blackNormalTextStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 7.0),
                              Text(
                                item.doctorType,
                                style: primaryColorsmallTextStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  divider(),
                ],
              );
            },
          );
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
