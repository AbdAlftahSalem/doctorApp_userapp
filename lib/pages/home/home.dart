import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:mydoctor_user_app/constant/constant.dart';
import 'package:mydoctor_user_app/controllers/home_controller.dart';
import 'package:mydoctor_user_app/model/lab_model.dart';
import 'package:mydoctor_user_app/pages/screens.dart';
import 'package:mydoctor_user_app/widget/column_builder.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String city = 'As-salt';

  final doctorTypeList = [
    {
      'type': 'Chest and Respiratory',
      'image': 'assets/icons/Chest and Respiratory.png'
    },
    {'type': 'Dentistry', 'image': 'assets/icons/Dentistry.png'},
    {'type': 'Dermatology', 'image': 'assets/icons/Dermatology.png'},
    {
      'type': 'Diabetes and Endocrinology',
      'image': 'assets/icons/Diabetes and Endocrinology.png'
    },
    {
      'type': 'Ear, Nose and Throat',
      'image': 'assets/icons/Ear, Nose and Throat.png'
    },
    {'type': 'Neurology', 'image': 'assets/icons/Neurology.png'},
    {
      'type': 'Pediatrics and New Born',
      'image': 'assets/icons/Pediatrics-and-New-Born.png'
    },
    {'type': 'Orthopedics', 'image': 'assets/icons/Orthopedics.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return controller.finishGetData
            ? Scaffold(
                backgroundColor: whiteColor,
                appBar: AppBar(
                  backgroundColor: whiteColor,
                  automaticallyImplyLeading: false,
                  elevation: 0.0,
                  title: InkWell(
                    onTap: () => _selectCityBottomSheet(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: blackColor,
                          size: 18.0,
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          city,
                          style: appBarLocationTextStyle,
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    IconButton(
                      icon: Icon(
                        Icons.notifications,
                        color: blackColor,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                duration: Duration(milliseconds: 500),
                                type: PageTransitionType.rightToLeft,
                                child: Notifications()));
                      },
                    ),
                  ],
                ),
                body: ListView(
                  children: [
                    search(),
                    banner(),
                    heightSpace,
                    heightSpace,
                    doctorBySpeciality(controller),
                    heightSpace,
                    heightSpace,
                    healthCheckup(controller.lab, controller),
                  ],
                ),
              )
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  search() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            duration: Duration(milliseconds: 400),
            type: PageTransitionType.scale,
            alignment: Alignment.bottomCenter,
            child: Search(),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(fixPadding * 2.0),
        padding: EdgeInsets.all(fixPadding * 1.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(width: 0.5, color: greyColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.search, color: greyColor, size: 23.0),
            SizedBox(width: 5.0),
            Text('What type of appointment?', style: greySearchTextStyle),
          ],
        ),
      ),
    );
  }

  banner() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      width: width,
      height: height / 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(
          image: AssetImage('assets/banner.jpeg'),
          fit: BoxFit.fill,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 1.0,
            spreadRadius: 1.0,
            color: Colors.grey[400]!,
          ),
        ],
      ),
    );
  }

  doctorBySpeciality(HomeController controller) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
          child: Text(
            'Available specialties',
            style: blackHeadingTextStyle,
          ),
        ),
        Container(
          height: 190.0,
          child: ListView.builder(
            itemCount: doctorTypeList.length,
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final item = doctorTypeList[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      duration: Duration(milliseconds: 800),
                      type: PageTransitionType.fade,
                      child: DoctorList(
                        doctors: controller.doctors,
                        type: item["type"]!,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 180.0,
                  padding: EdgeInsets.all(fixPadding),
                  alignment: Alignment.center,
                  margin: (index == doctorTypeList.length - 1)
                      ? EdgeInsets.all(fixPadding * 2.0)
                      : EdgeInsets.only(
                          left: fixPadding * 2.0,
                          top: fixPadding * 2.0,
                          bottom: fixPadding * 2.0),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Colors.teal),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        blurRadius: 1.0,
                        spreadRadius: 1.0,
                        color: Colors.grey[300]!,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        item['image']!,
                        width: 70.0,
                        height: 70.0,
                        fit: BoxFit.cover,
                      ),
                      heightSpace,
                      Text(
                        item['type']!,
                        style: TextStyle(
                          color: Colors.teal,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      duration: Duration(milliseconds: 500),
                      type: PageTransitionType.fade,
                      child: Speciality()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'View All',
                  style: primaryColorNormalBoldTextStyle,
                ),
                SizedBox(width: 5.0),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16.0,
                  color: blackColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  healthCheckup(List<LabModel> lab, HomeController controller) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(fixPadding * 2.0),
      color: scaffoldBgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Lab tests & health checkup',
            style: blackHeadingTextStyle,
          ),
          ColumnBuilder(
            itemCount: lab.length,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            itemBuilder: (context, index) {
              final item = lab[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      duration: Duration(milliseconds: 600),
                      type: PageTransitionType.rightToLeft,
                      child: Lab(
                        lab: item,
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(
                    top: fixPadding * 2.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: whiteColor,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        blurRadius: 1.0,
                        spreadRadius: 1.0,
                        color: Colors.grey[300]!,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 180.0,
                        width: width / 3.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(10.0)),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: item.image,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              CircularProgressIndicator(),
                            ],
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.warning_amber_outlined),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(fixPadding),
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
                                "${item.address} ${item.city} ${item.country}",
                                style: greySmallBoldTextStyle,
                              ),
                              heightSpace,
                              InkWell(
                                onTap: () => controller.launchURL(item.phone),
                                child: Container(
                                  padding: EdgeInsets.all(fixPadding),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(
                                        width: 0.7, color: primaryColor),
                                  ),
                                  child: Text(
                                    'Call now',
                                    style: primaryColorsmallBoldTextStyle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 165.0,
                        width: 30.0,
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 18.0,
                          color: blackColor,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          heightSpace,
          heightSpace,
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      duration: Duration(milliseconds: 600),
                      type: PageTransitionType.rightToLeft,
                      child: LabList(labList: lab)));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'View All',
                  style: primaryColorNormalBoldTextStyle,
                ),
                SizedBox(width: 5.0),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16.0,
                  color: blackColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Bottom Sheet for Select City Start Here
  void _selectCityBottomSheet() {
    double width = MediaQuery.of(context).size.width;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            color: whiteColor,
            child: Wrap(
              children: <Widget>[
                Container(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: width,
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Choose City',
                            textAlign: TextAlign.center,
                            style: blackHeadingTextStyle,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              city = 'As-salt';
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: width,
                            padding: EdgeInsets.all(10.0),
                            child: Text('As-salt'),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              city = 'Amman';
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: width,
                            padding: EdgeInsets.all(10.0),
                            child: Text('Amman'),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              city = 'Irbid';
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: width,
                            padding: EdgeInsets.all(10.0),
                            child: Text('Irbid'),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
// Bottom Sheet for Select City Ends Here
}
