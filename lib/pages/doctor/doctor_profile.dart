import 'package:get/get.dart';
import 'package:mydoctor_user_app/constant/constant.dart';
import 'package:mydoctor_user_app/controllers/doctor_profile_controller.dart';
import 'package:mydoctor_user_app/model/doctors_model.dart';
import 'package:mydoctor_user_app/widget/column_builder.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:mydoctor_user_app/pages/screens.dart';

class DoctorProfile extends StatefulWidget {
  DoctorModel doctorModel;

  DoctorProfile({required this.doctorModel});

  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GetBuilder<DoctorProfileController>(
        init: DoctorProfileController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: darkBlueColor,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: whiteColor,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: controller.reviewList.length == 0
                ? Center(child: CircularProgressIndicator())
                : Stack(
                    children: [
                      Container(
                        height: (height * 0.36),
                        color: Colors.transparent,
                        padding:
                            EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
                        alignment: Alignment.bottomRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: (width - fixPadding * 11.0) / 2.0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.doctorModel.name,
                                    style: whiteColorHeadingTextStyle,
                                  ),
                                  heightSpace,
                                  Text(
                                    widget.doctorModel.typeDoctor,
                                    style: whiteColorSmallTextStyle,
                                  ),
                                  heightSpace,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.star,
                                          color: Colors.lime, size: 20.0),
                                      SizedBox(width: 5.0),
                                      Text(
                                        '4.5 Rating',
                                        style: whiteColorNormalTextStyle,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Hero(
                              tag: widget.doctorModel.image,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 80),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    widget.doctorModel.image,
                                    width: (width) / 2.0,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      DraggableScrollableSheet(
                        initialChildSize: 0.6,
                        minChildSize: 0.6,
                        maxChildSize: 1.0,
                        builder: (BuildContext context, myscrollController) {
                          return ClipRRect(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30.0)),
                            child: Container(
                              color: whiteColor,
                              padding: EdgeInsets.all(fixPadding * 2.0),
                              child: ListView(
                                controller: myscrollController,
                                children: [
                                  Text(
                                    'Recognizd Postgraduate teacher for M.D. Physiology course. - Recognized University examiner for M.D. Physiology examination. - Professor in Charge of Central Library and Associate Professor, Seth G. S. Medical College and K.E.M. Hospital, Mumbai - 400 012. - Life Member, Association of Physiologists and Pharmacologists of India (APPI)',
                                    style: greyNormalTextStyle,
                                    textAlign: TextAlign.justify,
                                  ),
                                  heightSpace,
                                  heightSpace,
                                  experience(),
                                  heightSpace,
                                  heightSpace,
                                  availability(),
                                  heightSpace,
                                  heightSpace,
                                  SizedBox(
                                    height: 250,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        "assets/map.jpeg",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  heightSpace,
                                  heightSpace,
                                  review(controller),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
          );
        });
  }

  experience() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Experience',
          style: blackHeadingTextStyle,
        ),
        heightSpace,
        Text(
          widget.doctorModel.experience,
          style: greyNormalTextStyle,
        ),
      ],
    );
  }

  availability() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Availability',
          style: blackHeadingTextStyle,
        ),
        heightSpace,
        Text(
          '8:00 AM - 10:30 PM',
          style: greyNormalTextStyle,
        ),
      ],
    );
  }

  // location() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         'Location',
  //         style: blackHeadingTextStyle,
  //       ),
  //       heightSpace,
  //       Container(
  //         width: double.infinity,
  //         height: 250.0,
  //         decoration: BoxDecoration(
  //           color: whiteColor,
  //           borderRadius: BorderRadius.circular(15.0),
  //           boxShadow: <BoxShadow>[
  //             BoxShadow(
  //               blurRadius: 1.0,
  //               spreadRadius: 1.0,
  //               color: Colors.grey[300]!,
  //             ),
  //           ],
  //         ),
  //         child: ClipRRect(
  //           borderRadius: BorderRadius.circular(15.0),
  //           child: GoogleMap(
  //             markers: markers,
  //             onMapCreated: (GoogleMapController controller) {
  //               Marker m = Marker(
  //                   markerId: MarkerId('1'),
  //                   position: LatLng(51.361005, -0.1746394));
  //               setState(() {
  //                 markers.add(m);
  //               });
  //             },
  //             initialCameraPosition: CameraPosition(
  //                 target: LatLng(51.361005, -0.1746394), zoom: 8),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  review(DoctorProfileController controller) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Review',
          style: blackHeadingTextStyle,
        ),
        heightSpace,
        ColumnBuilder(
          itemCount: 3,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          itemBuilder: (context, index) {
            final item = controller.reviewList[index];
            return Container(
              margin: (index == 0)
                  ? EdgeInsets.symmetric(horizontal: 2.0)
                  : EdgeInsets.only(
                      top: fixPadding * 2.0, right: 2.0, left: 2.0),
              padding: EdgeInsets.all(fixPadding * 2.0),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    blurRadius: 1.0,
                    spreadRadius: 1.0,
                    color: Colors.grey[300]!,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 70.0,
                        height: 70.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35.0),
                          image: DecorationImage(
                            image: NetworkImage(item.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      widthSpace,
                      widthSpace,
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: blackNormalBoldTextStyle,
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              item.date,
                              style: greySmallTextStyle,
                            ),
                            SizedBox(height: 5.0),
                            ratingBar(item.numberStar),
                          ],
                        ),
                      ),
                    ],
                  ),
                  heightSpace,
                  Text(
                    item.content,
                    style: blackNormalTextStyle,
                  ),
                ],
              ),
            );
          },
        ),
        heightSpace,
        heightSpace,
        InkWell(
          borderRadius: BorderRadius.circular(15.0),
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                duration: Duration(milliseconds: 600),
                type: PageTransitionType.rightToLeftWithFade,
                child: Review(
                  review: controller.reviewList,
                ),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.all(fixPadding * 1.5),
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(width: 1.0, color: primaryColor),
            ),
            child: Text(
              'Show all reviews',
              style: primaryColorsmallBoldTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  ratingBar(number) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 1 Star
        Icon(
          (number == 1 ||
                  number == 2 ||
                  number == 3 ||
                  number == 4 ||
                  number == 5)
              ? Icons.star
              : Icons.star_border,
          color: Colors.lime[600],
          size: 18.0,
        ),

        // 2 Star
        Icon(
          (number == 2 || number == 3 || number == 4 || number == 5)
              ? Icons.star
              : Icons.star_border,
          color: Colors.lime[600],
          size: 18.0,
        ),

        // 3 Star
        Icon(
          (number == 3 || number == 4 || number == 5)
              ? Icons.star
              : Icons.star_border,
          color: Colors.lime[600],
          size: 18.0,
        ),

        // 4 Star
        Icon(
          (number == 4 || number == 5) ? Icons.star : Icons.star_border,
          color: Colors.lime[600],
          size: 18.0,
        ),

        // 5 Star
        Icon(
          (number == 5) ? Icons.star : Icons.star_border,
          color: Colors.lime[600],
          size: 18.0,
        ),
      ],
    );
  }
}
