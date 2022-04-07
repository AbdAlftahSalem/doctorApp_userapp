import 'package:get/get.dart';
import 'package:mydoctor_user_app/constant/constant.dart';
import 'package:mydoctor_user_app/controllers/home_controller.dart';
import 'package:mydoctor_user_app/model/lab_model.dart';
import 'package:mydoctor_user_app/pages/lab/lab.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final recentList = [
    {'title': 'Cough & Fever'},
    {'title': 'Nutrition'}
  ];

  HomeController homeController = Get.find();
  List<LabModel> listLab = [];

  String search = "";

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        title: Container(
          height: 40.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search for doctors & labs',
              hintStyle: TextStyle(
                fontSize: 15.0,
                color: Colors.grey,
              ),
              prefixIcon: Icon(Icons.search),
              border: InputBorder.none,
            ),
            onChanged: (val) {
              setState(() {
                search = val;
                searchMethod(val);
              });
            },
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(
                //   padding: EdgeInsets.only(
                //       top: fixPadding,
                //       bottom: fixPadding,
                //       right: fixPadding * 2.0,
                //       left: fixPadding * 2.0),
                //   color: Colors.grey[100],
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       Text(
                //         'Your recent searches',
                //         style: blackNormalBoldTextStyle,
                //       ),
                //       InkWell(
                //         onTap: () {},
                //         child: Text(
                //           'Show more',
                //           style: primaryColorsmallTextStyle,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(height: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: listLab.isEmpty && search.isNotEmpty
                      ? [
                          SizedBox(height: 250),
                          Center(
                            child: Container(
                              child: Text("No Data to Show !!",
                                  style: blackHeadingTextStyle),
                            ),
                          ),
                        ]
                      : listLab.map((e) {
                          return InkWell(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Text(e.name),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 3.0),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onTap: () {
                              Get.to(() => Lab(lab: e));
                            },
                          );
                        }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  searchMethod(String searchWord) {
    setState(() {
      listLab = homeController.lab
          .where((obj) => obj.name
              .toLowerCase()
              .trim()
              .contains(searchWord.toLowerCase().trim()))
          .toList();
    });
  }
}
