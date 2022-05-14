import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:the_library_app/pages/book_detail_page.dart';
import 'package:the_library_app/resources/colors.dart';
import 'package:the_library_app/resources/constants.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/view_items/book_list_title_view.dart';
import 'package:the_library_app/view_items/user_profile_view.dart';

class RatingAndCommentsSection extends StatelessWidget {
  const RatingAndCommentsSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BookListTitleView(
          indexO: -3,
            title: "Ratings and reviews",
            padd: MARGIN_MEDIUM_2,
            isListFromHome: false,
            goToNext: (){},
        ),
        SizedBox(height: MARGIN_MEDIUM_2,),
        RatingDetailSection(),
        SizedBox(height: MARGIN_MEDIUM_2X,),
        UserAccountView(
          name: "Vanessa Gayle",
          date: "29 Jan 2018",
          star: 5.0,
          image: "https://profiles.howard.edu/sites/profiles.howard.edu/files/20181105_193836.jpg",
          comment: "This eview MAY contain spoilers.Read at your own risk,This is one of my favourite Batman stories.I think that most notable thing about this piece is that it include in all DC movies.",
        ),
        SizedBox(height: MARGIN_MEDIUM_4,),
         UserAccountView(
          name: "Darth_Rean Sith_Lord",
          date: "13 Dec 2015",
          star: 3.0,
          image: "https://www.phdmedia.com/romania/wp-content/uploads/sites/73/2015/05/temp-people-profile.jpg",
          comment: "Iv wanted to read this story for years now I was so hyped up that i finally bought it after so long.. Then I read it and was sort of disappointed.. I\'m not saying is wasn\'t good..",
        ),
        SizedBox(height: MARGIN_MEDIUM_2,),
      ],
    );
  }
}

class UserAccountView extends StatelessWidget {

  final String name;
  final String date;
  final double star;
  final String comment;
  final String image;

  UserAccountView({
    required this.name,
    required this.date,
    required this.star,
    required this.comment,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
               UserProfileView(
                 width: USER_PROFILE_CMT_CONTAINER_WIDTH,
                 height: USER_PROFILE_CMT_CONTAINER_HEIGHT,
                 isInDetail: true,
                 image: image,
               ),
                UserNameAndRatingStarView(
                  name: name,
                   star: star,
                    date: date,
                    comment: comment,
                    ),
            ],
          ),
    );
  }
}

class UserNameAndRatingStarView extends StatelessWidget {
  const UserNameAndRatingStarView({
    Key? key,
    required this.name,
    required this.star,
    required this.date,
    required this.comment,
  }) : super(key: key);

  final String name;
  final double star;
  final String date;
  final String comment;

  @override
  Widget build(BuildContext context) {
    return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name,
        style: TextStyle(
          color: Colors.black,
          fontSize: TEXT_REGULAR,
          fontWeight: FontWeight.w500,
        ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RatingStarView(
              star: star,
            ),
     Text(date,
        style: TextStyle(
          color: SAMPLE_BACKGROUND_COLOR,
          fontSize: TEXT_SMALL_1X,
        ),
        ),
          ],
        ),
        SizedBox(height: MARGIN_MEDIUM_2,),
        Text(
          comment,
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
              color: DETAIL_TEXT_COLOR,
              fontSize: TEXT_REGULAR,
            ),
        ),
        SizedBox(height: MARGIN_MEDIUM_4,),
        Row(
          children: [
            Text(HELPFUL_QUESTION_TEXT,
            style: TextStyle(
                  color: DETAIL_TEXT_COLOR,
                  fontSize: TEXT_SMALL_1X,
                ),
            ),
            Spacer(),
            YesNoButton(
              title: "Yes",
            ),
            SizedBox(width: MARGIN_SMALL,),
            YesNoButton(
              title: "Yes",
            ),
          ],
        ),
      ],
    ),
    );
  }
}

class YesNoButton extends StatelessWidget {

  final String title;

  YesNoButton({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: YES_NO_BUTTON_WIDTH,
      height: YES_NO_BUTTON_HEIGHT,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MARGIN_MEDIUM_2_EXTRA),
        color: Colors.white,
        border: Border.all(color: Colors.black),
      ),
      child: Center(child: Text(title)),
    );
  }
}

class RatingStarView extends StatelessWidget {
 
  final double star;

  RatingStarView({
    required this.star,
  });

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
             initialRating: star,
           allowHalfRating: true,
           ignoreGestures: true,
          itemBuilder: (BuildContext context,int index){
          return Icon(Icons.star,color: CREATE_BUTTON_COLOR,);
           },
         itemSize: MARGIN_MEDIUM_2,
          onRatingUpdate: (rating){
          rating;
         },
      );
  }
}

class RatingDetailSection extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: BookInfoView(
            isIcon: false,
             title: "4.4",
              content: "1802 total",
              isInRatingAndReview: true,
              ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
               RatingBarAndTextView(
                 number: 5,
                 ratingRate: 0.3,
               ),
               SizedBox(height: 4),
               RatingBarAndTextView(
                 number: 4,
                 ratingRate: 0.16,
               ),
                SizedBox(height: 4),
               RatingBarAndTextView(
                 number: 3,
                 ratingRate: 0.51,
               ),
                SizedBox(height: 4),
               RatingBarAndTextView(
                 number: 2,
                 ratingRate: 0.1,
               ),
                SizedBox(height: 4),
               RatingBarAndTextView(
                 number: 1,
                 ratingRate: 0.4,
               ),
              ],
            ),
            ),
      ],
    );
  }
}

class RatingBarAndTextView extends StatelessWidget {

  final int number;
  final double ratingRate;

  RatingBarAndTextView({
    required this.number,
    required this.ratingRate,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("$number",
       style: TextStyle(
         color: SAMPLE_BACKGROUND_COLOR,
         fontSize: TEXT_SMALL_1X,
       ),
     ),
     SizedBox(width: MARGIN_SMALL,),
        RatingBarView(
            ratingRate: ratingRate,
        ),
      ],
    );
  }
}


class RatingBarView extends StatelessWidget {
 
  final double ratingRate;

  RatingBarView({
    required  this.ratingRate,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
             children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.56,
                height: MARGIN_SMALL_1X,
                decoration: BoxDecoration(
                    color: RATING_BAR_COLOR,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Text(''),
              ),
              Container(
                width: MediaQuery.of(context).size.width * ratingRate,
                height: MARGIN_SMALL_1X,
                decoration: BoxDecoration(
                    color: CREATE_BUTTON_COLOR,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Text(''),
              ),
            ]
          );
  }
}
