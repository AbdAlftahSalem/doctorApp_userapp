import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:mydoctor_user_app/constant/constant.dart';
import 'package:mydoctor_user_app/model/doctors_model.dart';
import 'package:mydoctor_user_app/pages/screens.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

const labelMonth = 'Month';
const labelDate = 'Date';
const labelWeekDay = 'Week Day';

class DoctorTimeSlot extends StatefulWidget {
  DoctorModel doctorModel;

  DoctorTimeSlot({required this.doctorModel});

  @override
  _DoctorTimeSlotState createState() => _DoctorTimeSlotState();
}

class _DoctorTimeSlotState extends State<DoctorTimeSlot> {
  DateTime? _selectedDate;
  String? selectedTime = '';
  String? selectedDate;
  String? monthString;
  DateTime firstDate = DateTime.now();
  DateTime lastDate = DateTime.now().add(Duration(days: 30));

  final morningSlotList = [
    {'time': '8:00 AM'},
    {'time': '8:30 AM'},
    {'time': '9:00 AM'},
    {'time': '9:30 AM'},
    {'time': '10:00 AM'},
    {'time': '10:30 AM'},
    {'time': '11:00 AM'},
    {'time': '11:30 AM'}
  ];

  final afternoonSlotList = [
    {'time': '12:30 PM'},
    {'time': '1:00 PM'},
    {'time': '1:30 PM'},
    {'time': '2:00 PM'},
    {'time': '2:30 PM'},
    {'time': '3:00 PM'},
    {'time': '3:30 PM'},
    {'time': '4:00 PM'},
    {'time': '4:30 PM'},
    {'time': '5:00 PM'},
    {'time': '5:30 PM'},
    {'time': '6:00 PM'}
  ];

  final eveningSlotList = [
    {'time': '8:00 PM'},
    {'time': '8:30 PM'},
    {'time': '9:00 PM'},
    {'time': '9:30 PM'},
    {'time': '10:00 PM'},
    {'time': '10:30 PM'}
  ];
  List<String> timeAppointments = [];
  bool finishGetTime = false;

  getTimeAppointmentsDoctor() async {
    FirebaseFirestore.instance
        .collection("Doctors")
        .doc(widget.doctorModel.id)
        .collection("Appointments")
        .get()
        .then(
      (value) {
        value.docs.forEach(
          (element) {
            setState(() {
              timeAppointments.add(element.data()["time"]);
            });
          },
        );
      },
    );

    setState(() {
      finishGetTime = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
    selectedDate =
        '${firstDate.day}-${convertNumberMonthToStringMonth(firstDate.month)}';
    getTimeAppointmentsDoctor();
  }

  void _resetSelectedDate() {
    _selectedDate = DateTime.now();
  }

  String? convertNumberMonthToStringMonth(month) {
    if (month == 1) {
      monthString = 'January';
    } else if (month == 2) {
      monthString = 'Fabruary';
    } else if (month == 3) {
      monthString = 'March';
    } else if (month == 4) {
      monthString = 'April';
    } else if (month == 5) {
      monthString = 'May';
    } else if (month == 6) {
      monthString = 'June';
    } else if (month == 7) {
      monthString = 'July';
    } else if (month == 8) {
      monthString = 'August';
    } else if (month == 9) {
      monthString = 'September';
    } else if (month == 10) {
      monthString = 'October';
    } else if (month == 11) {
      monthString = 'November';
    } else if (month == 12) {
      monthString = 'December';
    }
    return monthString;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        titleSpacing: 0.0,
        elevation: 0.0,
        title: Text(
          'Time Slots',
          style: appBarTitleTextStyle,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: blackColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      bottomNavigationBar: (selectedTime == '')
          ? Container(
              height: 0.0,
              width: 0.0,
            )
          : Material(
              elevation: 5.0,
              child: Container(
                color: Colors.white,
                width: double.infinity,
                height: 70.0,
                padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
                alignment: Alignment.center,
                child: InkWell(
                  borderRadius: BorderRadius.circular(15.0),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        duration: Duration(milliseconds: 600),
                        child: ConsultationDetail(
                          doctorModel: widget.doctorModel,
                          date: selectedDate!,
                          time: selectedTime!,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: primaryColor,
                    ),
                    child: Text(
                      'Book now',
                      style: whiteColorButtonTextStyle,
                    ),
                  ),
                ),
              ),
            ),
      body: finishGetTime
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Material(
                  elevation: 1.0,
                  child: Container(
                    color: whiteColor,
                    padding: EdgeInsets.only(top: fixPadding * 2.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: fixPadding * 2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Hero(
                                tag: widget.doctorModel.image,
                                child: Container(
                                  width: 76.0,
                                  height: 76.0,
                                  decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(38.0),
                                    border: Border.all(
                                        width: 0.3, color: primaryColor),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        blurRadius: 1.0,
                                        spreadRadius: 1.0,
                                        color: Colors.grey[300]!,
                                      ),
                                    ],
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          widget.doctorModel.image),
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                              ),
                              widthSpace,
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            '${widget.doctorModel.name}',
                                            style: blackNormalBoldTextStyle,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Wrap(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  PageTransition(
                                                    duration: Duration(
                                                        milliseconds: 600),
                                                    type:
                                                        PageTransitionType.fade,
                                                    child: DoctorProfile(
                                                      doctorModel:
                                                          widget.doctorModel,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                'View Profile',
                                                style:
                                                    primaryColorsmallBoldTextStyle,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 7.0),
                                    Text(
                                      widget.doctorModel.typeDoctor,
                                      style: greyNormalTextStyle,
                                    ),
                                    SizedBox(height: 7.0),
                                    Text(
                                      widget.doctorModel.experience,
                                      style: primaryColorNormalTextStyle,
                                    ),
                                    SizedBox(height: 7.0),
                                    Text(
                                      'jd 39',
                                      style: blackHeadingTextStyle,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        CalendarTimeline(
                          showYears: false,
                          initialDate: _selectedDate!,
                          firstDate: firstDate,
                          lastDate: DateTime(2022, 7, 30),
                          onDateSelected: (date) {
                            setState(() {
                              _selectedDate = date;
                              selectedDate =
                                  '${_selectedDate!.day}-${convertNumberMonthToStringMonth(_selectedDate!.month)}';
                            });
                          },
                          leftMargin: 20,
                          monthColor: primaryColor,
                          dayColor: Colors.teal[500],
                          dayNameColor: whiteColor.withOpacity(0.85),
                          activeDayColor: whiteColor,
                          activeBackgroundDayColor: primaryColor,
                          dotsColor: whiteColor.withOpacity(0.85),
                          locale: 'en',
                        ),
                        heightSpace,
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: slots(),
                ),
              ],
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  slots() {
    return ListView(
      children: [
        heightSpace,
        // Morning Slot Start
        Container(
          padding: EdgeInsets.only(
              bottom: fixPadding * 2.0,
              right: fixPadding * 2.0,
              left: fixPadding * 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/sunrise.png',
                height: 35.0,
                width: 35.0,
                fit: BoxFit.cover,
              ),
              widthSpace,
              Text(
                '${morningSlotList.length} Morning',
                style: blackNormalBoldTextStyle,
              )
            ],
          ),
        ),
        Wrap(
          children: morningSlotList
              .map(
                (e) => Padding(
                  padding: EdgeInsets.only(
                      left: fixPadding * 2.0, bottom: fixPadding * 2.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        searchInList(e['time']!) == "found"
                            ? Get.snackbar(
                                "Message", "This time is already Booked up")
                            : selectedTime = e['time'];
                      });
                    },
                    child: Container(
                      width: 90.0,
                      padding: EdgeInsets.all(fixPadding),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(width: 0.7, color: greyColor),
                        color: searchInList(e['time']!) == "found"
                            ? Color(0xffD0D0D0)
                            : (e['time'] == selectedTime)
                                ? primaryColor
                                : whiteColor,
                      ),
                      child: Text(e['time']!,
                          style: (e['time'] == selectedTime)
                              ? whiteColorNormalTextStyle
                              : primaryColorNormalTextStyle),
                    ),
                  ),
                ),
              )
              .toList()
              .cast<Widget>(),
        ),

        // Morning Slot End

        // Afternoon Slot Start
        Container(
          padding: EdgeInsets.only(
              bottom: fixPadding * 2.0,
              right: fixPadding * 2.0,
              left: fixPadding * 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/sun.png',
                height: 35.0,
                width: 35.0,
                fit: BoxFit.cover,
              ),
              widthSpace,
              Text(
                '${afternoonSlotList.length} afternoon',
                style: blackNormalBoldTextStyle,
              )
            ],
          ),
        ),
        Wrap(
          children: afternoonSlotList
              .map(
                (e) => Padding(
                  padding: EdgeInsets.only(
                      left: fixPadding * 2.0, bottom: fixPadding * 2.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedTime = e['time'];
                      });
                    },
                    child: Container(
                      width: 90.0,
                      padding: EdgeInsets.all(fixPadding),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(width: 0.7, color: greyColor),
                        color: (e['time'] == selectedTime)
                            ? primaryColor
                            : whiteColor,
                      ),
                      child: Text(e['time']!,
                          style: (e['time'] == selectedTime)
                              ? whiteColorNormalTextStyle
                              : primaryColorNormalTextStyle),
                    ),
                  ),
                ),
              )
              .toList()
              .cast<Widget>(),
        ),
        // Afternoon Slot End

        // Evening Slot Start
        Container(
          padding: EdgeInsets.only(
              bottom: fixPadding * 2.0,
              right: fixPadding * 2.0,
              left: fixPadding * 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/sun-night.png',
                height: 35.0,
                width: 35.0,
                fit: BoxFit.cover,
              ),
              widthSpace,
              Text(
                '${eveningSlotList.length} evening',
                style: blackNormalBoldTextStyle,
              )
            ],
          ),
        ),
        Wrap(
          children: eveningSlotList
              .map(
                (e) => Padding(
                  padding: EdgeInsets.only(
                      left: fixPadding * 2.0, bottom: fixPadding * 2.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedTime = e['time'];
                      });
                    },
                    child: Container(
                      width: 90.0,
                      padding: EdgeInsets.all(fixPadding),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(width: 0.7, color: greyColor),
                        color: (e['time'] == selectedTime)
                            ? primaryColor
                            : whiteColor,
                      ),
                      child: Text(e['time']!,
                          style: (e['time'] == selectedTime)
                              ? whiteColorNormalTextStyle
                              : primaryColorNormalTextStyle),
                    ),
                  ),
                ),
              )
              .toList()
              .cast<Widget>(),
        ),
        // Evening Slot End
      ],
    );
  }

  searchInList(String time) {
    var checkValue =
        timeAppointments.where((element) => time == element).isEmpty;
    if (checkValue) {
      return "not found";
    } else {
      return "found";
    }
  }
}
