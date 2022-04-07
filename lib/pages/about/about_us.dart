import 'package:mydoctor_user_app/constant/constant.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        titleSpacing: 0.0,
        elevation: 1.0,
        title: Text(
          'About Us',
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
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: fixPadding * 2.0,
              right: fixPadding * 2.0,
              left: fixPadding * 2.0,
            ),
            child: Text(
              "MAWIDCOMIt \n is a free mobile application available for Android and iPhone, which includes clinics for doctors located in Amman, Salt and Irbid, as well as medical examination laboratories. So that you can book an appointment with your doctor remotely through the application and thus you save effort and money.The application provides an open chat feature and personal calls with your doctor.The application allows customers to view the available appointments and choose the appropriate appointment.When they need to amend or cancel an appointment, they can do so easily through the app.In addition to the possibility of adding your assessment.",
              style: blackNormalTextStyle,
              textAlign: TextAlign.justify,
            ),
          ),

        ],
      ),
    );
  }
}
