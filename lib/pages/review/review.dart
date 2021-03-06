import 'package:mydoctor_user_app/constant/constant.dart';
import 'package:mydoctor_user_app/model/review_model.dart';
import 'package:mydoctor_user_app/widget/column_builder.dart';
import 'package:flutter/material.dart';

class Review extends StatefulWidget {
  List<ReviewModel> review;

  Review({required this.review});

  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 1.0,
        titleSpacing: 0.0,
        title: Text(
          '${widget.review.length} review found',
          style: appBarTitleTextStyle,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: blackColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: [
          heightSpace,
          heightSpace,
          ColumnBuilder(
            itemCount: widget.review.length,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            itemBuilder: (context, index) {
              final item = widget.review[index];
              return Container(
                margin: (index == 0)
                    ? EdgeInsets.symmetric(horizontal: fixPadding * 2.0)
                    : EdgeInsets.only(
                        top: fixPadding * 2.0,
                        right: fixPadding * 2.0,
                        left: fixPadding * 2.0,
                      ),
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
        ],
      ),
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
