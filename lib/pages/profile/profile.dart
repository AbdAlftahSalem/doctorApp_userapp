import 'package:mydoctor_user_app/constant/constant.dart';
import 'package:mydoctor_user_app/controllers/localDB/local_db.dart';
import 'package:mydoctor_user_app/pages/screens.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  logoutDialogue() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        double width = MediaQuery.of(context).size.width;
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
                      "You sure want to logout?",
                      style: blackHeadingTextStyle,
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: (width / 3.5),
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Text(
                              'Cancel',
                              style: blackColorButtonTextStyle,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          },
                          child: Container(
                            width: (width / 3.5),
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Text(
                              'Log out',
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

  var user;

  @override
  Widget build(BuildContext context) {
    setState(() {
      user = LocalDB.getData("User");
      print(user);
    });

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppBar(
                backgroundColor: whiteColor,
                elevation: 1.0,
                automaticallyImplyLeading: false,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 46.0,
                      height: 46.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(23.0),
                        border: Border.all(width: 0.2, color: greyColor),
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/User-avatar.svg/1024px-User-avatar.svg.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    widthSpace,
                    Text(
                      user["username"],
                      style: appBarTitleTextStyle,
                    ),
                  ],
                ),
                actions: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              duration: Duration(milliseconds: 500),
                              type: PageTransitionType.rightToLeft,
                              child: EditProfile(),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.only(right: 15.0),
                          child: Text(
                            'Edit Profile',
                            style: primaryColorsmallBoldTextStyle,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(fixPadding * 2.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'About App',
                  style: blackHeadingTextStyle,
                ),
                heightSpace,
                heightSpace,
                heightSpace,
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            duration: Duration(milliseconds: 500),
                            type: PageTransitionType.rightToLeft,
                            child: AboutUs()));
                  },
                  child: listItem(primaryColor, Icons.touch_app, 'About Us'),
                ),
                heightSpace,
                listItem(Colors.green, Icons.star_border, 'Rate Us'),
                heightSpace,
                listItem(Colors.red, Icons.help_outline, 'Help'),
              ],
            ),
          ),
          divider(),
          Container(
            padding: EdgeInsets.all(fixPadding * 2.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => logoutDialogue(),
                  child: listItem(Colors.teal, Icons.exit_to_app, 'Logout'),
                ),
              ],
            ),
          ),
        ],
      ),
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

  listItem(color, icon, title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 50.0,
                height: 50.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  border: Border.all(width: 0.3, color: color),
                  color: color.withOpacity(0.15),
                ),
                child: Icon(
                  icon,
                  size: 22.0,
                  color: color,
                ),
              ),
              widthSpace,
              Expanded(
                child: Text(
                  title,
                  style: blackNormalBoldTextStyle,
                ),
              ),
            ],
          ),
        ),
        Icon(
          Icons.arrow_forward_ios,
          color: blackColor,
          size: 14.0,
        ),
      ],
    );
  }
}
