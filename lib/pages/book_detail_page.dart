import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:the_library_app/blocs/home_page_bloc.dart';
import 'package:the_library_app/data/vos/overview/book_list_vo.dart';
import 'package:the_library_app/data/vos/overview/book_vo.dart';
import 'package:the_library_app/data/vos/show_more/show_more_result_vo.dart';
import 'package:the_library_app/pages/book_list_in_grid.dart';
import 'package:the_library_app/resources/colors.dart';
import 'package:the_library_app/resources/constants.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/view_items/book_list_title_view.dart';
import 'package:the_library_app/view_items/book_name_and_info_view.dart';
import 'package:the_library_app/view_items/user_profile_view.dart';
import 'package:the_library_app/widgets/book_list_title_and_serials_view.dart';

class BookDetailPage extends StatelessWidget {

  final BookVO userSelectBook;
  final ShowMoreResultVO userSelectBookFromShowMore;
  final bool isOverView;

  BookDetailPage({
    required this.userSelectBook,
    required this.userSelectBookFromShowMore,
    required this.isOverView,
    });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          AppBarView(),
          SizedBox(height: MARGIN_MEDIUM_2X,),
             Column(
              children: [
                BookTitleAndCoverView(
                    image: (isOverView) ? userSelectBook.bookImage ?? "" : IMAGE_CONSTANT,
                    name: (isOverView) ? userSelectBook.title ?? "" : userSelectBookFromShowMore.bookDetails?.first.title ?? "",
                    content: (isOverView) ? userSelectBook.description ?? "" : userSelectBookFromShowMore.bookDetails?.first.description ?? "",
                    author: (isOverView) ? userSelectBook.author ?? "" : userSelectBookFromShowMore.bookDetails?.first.author ?? "",
                ),
                SizedBox(height: MARGIN_MEDIUM_3X,),
                BookDetail(),
                SizedBox(height: MARGIN_MEDIUM_3X,),
                ButtonRowView(
                  btn1Text: FREE_SAMPLE_DETAIL_BUTTON_TEXT,
                  btn2Text: BUY_DETAIL_BUTTON_TEXT,
                  btn1Click: (){},
                  btn2Click: (){},
                ),
                SizedBox(height: MARGIN_MEDIUM_3X,),
                SwitchButtonView(
                  data: SWITCH_TO_AUDIO_DETAIL_TEXT,
                ),
                SizedBox(height: MARGIN_MEDIUM_2X,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                  child: Divider(color: DETAIL_TEXT_COLOR,thickness: 1,),
                ),
                SizedBox(height: MARGIN_MEDIUM_2X,),
                AboutTheBookView(
                  title: ABOUT_THIS_EBOOK_TEXT,
                  content: (isOverView) ? userSelectBook.description ?? "" : userSelectBookFromShowMore.bookDetails?.first.description ?? "",
                ),
                SizedBox(height: MARGIN_MEDIUM_2X,),
                RatingAndCommentsSection(),
                SizedBox(height: MARGIN_MEDIUM_2X,),
                AboutTheBookView(
                  title: ABOUT_THIS_AUTHOR_TEXT,
                  content: "J. David McSwane is a reporter in ProPublica\'s DC office.Previously,he was an investigative reporter for The Dallas Morning News and the Austin American-Statesman.",
                ),
                SizedBox(height: MARGIN_MEDIUM_2X,),
                Selector<HomePageBloc,List<BookListVO>>(
                  selector: (context,bloc) => bloc.bookLists ?? [],
                  shouldRebuild: (previous,next) => previous != next,
                  builder: (context,bookList,child) =>
                   BookListTileAndSerialsView(
                    title: SIMILAR_BOOK_TEXT,
                    books: bookList.first.books ?? [],
                     onClick: (userSelectBookIndex,) => 
                        navigateToNextScreen(context,BookDetailPage(
                          userSelectBook: bookList.first.books?[userSelectBookIndex] ?? BookVO.empty(),
                          userSelectBookFromShowMore: ShowMoreResultVO.empty(),
                          isOverView: true,
                          )),
                    goToNext: (){
                       HomePageBloc _bloc = Provider.of(context,listen: false);
                        _bloc.clickForMoreView(0).then((value){
                           navigateToNextScreen(context,BookListInGrid(
                          searchText: "",
                          isFromSearchPage: false,
                        ));
                        });
                    },
                     ),
                ),
              ],
            ),
        ],
      ),
    );
  }

      navigateToNextScreen(BuildContext context,Widget pageWidget) {
    return Navigator.push(context,
         MaterialPageRoute(builder: (BuildContext context) => pageWidget));
  }
}

class RatingAndCommentsSection extends StatelessWidget {
  const RatingAndCommentsSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BookListTitleView(
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

class AboutTheBookView extends StatelessWidget {

  final String title;
  final String content;

  AboutTheBookView({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BookListTitleView(
            title: title,
            padd: 0,
            isListFromHome: false,
            goToNext: (){},
            ),
            SizedBox(height: MARGIN_SMALL,),
          Padding(
           padding: EdgeInsets.only(right: MARGIN_MEDIUM_2,left: MARGIN_MEDIUM_2),
            child: Text(content,
              style: TextStyle(
                color: DETAIL_TEXT_COLOR,
                fontSize: TEXT_REGULAR,
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class SwitchButtonView extends StatelessWidget {

  final String data;

  SwitchButtonView({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      child: Text("Switch to ${data}",
        style: TextStyle(
          color: BUTTON_TEXT_COLOR,
          fontSize: TEXT_MEDIUM,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class ButtonRowView extends StatelessWidget {

  final String btn1Text;
  final String btn2Text;
  final Function btn1Click;
  final Function btn2Click;

  ButtonRowView({
    required this.btn1Text,
    required this.btn2Text,
    required this.btn1Click,
    required this.btn2Click,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ButtonView(
            isGhostButton: true,
            title: btn1Text,
            bgColor: Colors.white,
            onClick: () => btn1Click(),
          ),
          ButtonView(
            isGhostButton: false,
            title: btn2Text,
            bgColor: CREATE_BUTTON_COLOR,
            onClick: ()=> btn2Click(),
          ),
        ],
      ),
    );
  }
}

class ButtonView extends StatelessWidget {
  
  final bool isGhostButton;
  final String title;
  final Color bgColor;
  final Function onClick;

  ButtonView({
    required this.isGhostButton,
    required this.title,
    required this.bgColor,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onClick();
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.44,
        height: BUTTON_HEIGHT,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(MARGIN_SMALL)),
          border: (isGhostButton) ? Border.all(color: DETAIL_TEXT_COLOR) : null,
          color: bgColor,
        ),
        child: Center(
          child: Text(title,
          style: TextStyle(
            fontSize: TEXT_REGULAR,
            color: (isGhostButton) ? BUTTON_TEXT_COLOR :Colors.white,
            fontWeight: FontWeight.w500,
          ),
          ),
        ),
      ),
    );
  }
}

class BookDetail extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
            BookInfoView(
              isIcon: false,
              title: "4.9★",
              content: "7 reviews",
              icon: null,
              isInRatingAndReview: false,
            ),
            BookInfoDividerView(),
             BookInfoView(
               isIcon: true,
               title: "",
               content: "eBook",
               icon: FaIcon(FontAwesomeIcons.bookBookmark,color: DETAIL_TEXT_COLOR,size: MARGIN_SIZE_FOR_ICON,),
               isInRatingAndReview: false,
             ),
             BookInfoDividerView(),
              BookInfoView(
                isIcon: false,
                title: "336",
                content: "Pages",
                 isInRatingAndReview: false,
                icon: null,
              ),
              BookInfoDividerView(),
               BookInfoView(
                 isIcon: true,
                 title: "",
                 content: "Eligible",
                  isInRatingAndReview: false,
                 icon: FaIcon(FontAwesomeIcons.homeLgAlt,color: DETAIL_TEXT_COLOR,size: MARGIN_SIZE_FOR_ICON,),
               ),
        ],
      ),
    );
  }
}

class BookInfoDividerView extends StatelessWidget {
  const BookInfoDividerView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: BOOK_INFO_DIVIDER_WIDTH,
      height: BOOK_INFO_DIVIDER_HEIGHT,
      color: SAMPLE_BACKGROUND_COLOR,
    );
  }
}

class BookInfoView extends StatelessWidget {

  final bool isIcon;
  final String title;
  final String content;
  final FaIcon? icon;
  final bool isInRatingAndReview;

  BookInfoView({
    required this.isIcon,
    required this.title,
    required this.content,
     this.icon,
     required this.isInRatingAndReview,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: !isIcon,
          child: Text(
            title,
          style: TextStyle(
            color: (isInRatingAndReview) ? Colors.black : DETAIL_TEXT_COLOR,
            fontSize: (isInRatingAndReview) ?  46 :  TEXT_MEDIUM,
            fontWeight: FontWeight.w600,
          ),
          ),
        ),
        Visibility(
          visible: isInRatingAndReview,
          child: RatingStarView(
            star: 4.5,
          ),
          ),
        Visibility(
          visible: isIcon,
          child: icon ?? Container(),
          ),
          SizedBox(height: MARGIN_SMALL,),
        Text(content,
        style: TextStyle(
          color: SAMPLE_BACKGROUND_COLOR,
          fontSize: TEXT_SMALL_1X,
          fontWeight: FontWeight.w600,
        ),
        ),
      ],
    );
  }
}

class BookTitleAndCoverView extends StatelessWidget {

  final String name;
  final String content;
  final String image;
  final String author;

  BookTitleAndCoverView({
    required this.name,
    required this.content,
    required this.image,
    required this.author,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(MARGIN_PRE_SMALL),
              ),
              child: Image.network(image,
              fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: MARGIN_SMALL,),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(name,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: TEXT_MEDIUM_2X,
                  fontWeight: FontWeight.w500,
                ),
                ),
                SizedBox(height: MARGIN_MEDIUM_2,),
                Text(author,
                style: TextStyle(
                  color: CREATE_BUTTON_COLOR,
                  fontSize: TEXT_REGULAR,
                  fontWeight: FontWeight.w500,
                ),
                ),
                SizedBox(height: MARGIN_MEDIUM_2,),
                Text(content,
                style: TextStyle(
                  color: BOOK_EXTRA_DATA_CONTENT_COLOR,
                  fontSize: TEXT_REGULAR,
                  height: 1.4,
                ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AppBarView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: EdgeInsets.only(right: MARGIN_MEDIUM_2,left: MARGIN_SMALL),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            onPressed: (){
            Navigator.of(context).pop();
          },
           icon: Icon(Icons.chevron_left_sharp,size: MARGIN_MEDIUM_4,color: DETAIL_TEXT_COLOR,),
           ),
           Spacer(),
           IconButton(
            onPressed: (){
          },
           icon: Icon(Icons.search,size: MARGIN_MEDIUM_3X,color: DETAIL_TEXT_COLOR,),
           ),
           IconButton(
            onPressed: (){
          },
           icon: FaIcon(FontAwesomeIcons.bookAtlas,color: DETAIL_TEXT_COLOR,),iconSize: MARGIN_SIZE_FOR_ICON,
           ),
           DropdownButton(
             alignment: Alignment.center,
             hint: FaIcon(FontAwesomeIcons.ellipsisVertical,color: DETAIL_TEXT_COLOR,),iconSize: MARGIN_SIZE_FOR_ICON,
             underline: SizedBox(),
             icon: SizedBox(),
              items: [
                DropdownMenuItem(child: Text(SHARE_TAB_IN_DETAIL),value: 0,),
                DropdownMenuItem(child: Text(GIFT_TAB_IN_DETAIL),value: 1,)
              ],
               onChanged: (index){
               },
               ),
        ],
      ),
    );
  }
}