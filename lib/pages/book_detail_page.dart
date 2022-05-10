import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:the_library_app/blocs/book_detail_bloc.dart';
import 'package:the_library_app/blocs/home_page_bloc.dart';
import 'package:the_library_app/blocs/show_more_bloc.dart';
import 'package:the_library_app/blocs/library_tab_bloc.dart';
import 'package:the_library_app/data/vos/overview/book_list_vo.dart';
import 'package:the_library_app/data/vos/overview/book_vo.dart';
import 'package:the_library_app/data/vos/overview/result_vo.dart';
import 'package:the_library_app/data/vos/show_more/show_more_result_vo.dart';
import 'package:the_library_app/pages/book_list_in_grid.dart';
import 'package:the_library_app/resources/colors.dart';
import 'package:the_library_app/resources/constants.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/view_items/book_list_title_view.dart';
import 'package:the_library_app/view_items/book_name_and_info_view.dart';
import 'package:the_library_app/view_items/user_profile_view.dart';
import 'package:the_library_app/widgets/book_list_title_and_serials_view.dart';
import 'package:the_library_app/widgets/rating_and_comment_section.dart';

class BookDetailPage extends StatelessWidget {

  final BookVO book;

  BookDetailPage({
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return 
    ChangeNotifierProvider<BookDetailBloc>.value(
      value: BookDetailBloc(book),
      // ChangeNotifierProvider<BookDetailBloc>(
      //   create: (context) => BookDetailBloc(book),
      child: Scaffold(
        body: ListView(
          children: [
            AppBarView(),
            SizedBox(height: MARGIN_MEDIUM_2X,),
               Column(
                children: [
                  Selector<BookDetailBloc,BookVO>(
                    selector: (context,bloc) => bloc.detailsInfo ?? BookVO.empty(),
                    shouldRebuild: (previous,next) => previous != next,
                    builder: (context,detailsInfo,child) =>
                     BookTitleAndCoverView(
                        image: detailsInfo.bookImage ?? detailsInfo.searchResult?.volumeInfo?.imageLinks?.thumbnail  ?? IMAGE_CONSTANT_ONLINE,
                        name:  detailsInfo.title ?? detailsInfo.bookDetails?.first.title ?? detailsInfo.searchResult?.volumeInfo?.title ?? "",
                        content: detailsInfo.description ?? detailsInfo.searchResult?.volumeInfo?.description ?? detailsInfo.bookDetails?.first.description ?? "",
                        author:  detailsInfo.author ?? detailsInfo.bookDetails?.first.author ?? "",
                    ),
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
                  Selector<BookDetailBloc,BookVO>(
                    selector: (context,bloc) => bloc.detailsInfo ?? BookVO.empty(),
                    shouldRebuild: (previous,next) => previous != next,
                    builder: (context,detailsInfo,child) =>
                    AboutTheBookView(
                      title: ABOUT_THIS_EBOOK_TEXT,
                      content: detailsInfo.description ?? detailsInfo.searchResult?.volumeInfo?.description  ?? detailsInfo.bookDetails?.first.description ?? "",
                    ),
                  ),
                  SizedBox(height: MARGIN_MEDIUM_2X,),
                  RatingAndCommentsSection(),
                  SizedBox(height: MARGIN_MEDIUM_2X,),
                  AboutTheBookView(
                    title: ABOUT_THIS_AUTHOR_TEXT,
                    content: AUTHOR_TEXT,
                  ),
                  SizedBox(height: MARGIN_MEDIUM_2X,),
                     Selector<BookDetailBloc,List<BookVO>>(
                      selector: (context,bloc) => bloc.similarBooks ?? [],
                      shouldRebuild: (previous,next) => previous != next,
                      builder: (context,similarBooks,child) =>
                         BookListTileAndSerialsView(
                           isShowPrice: true,
                          title: SIMILAR_BOOK_TEXT,
                          books: similarBooks.take(6).toList(),
                           onClick: (userSelectBookIndex,){
                             BookDetailBloc bloc = Provider.of(context,listen: false);
                             bloc.saveBookToCarousel(similarBooks[userSelectBookIndex]).then((value) =>
                            navigateToNextScreen(context,BookDetailPage(
                               book: similarBooks[userSelectBookIndex],
                              ))
                             );
                           }, 
                          goToNext: (){},
                           ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }

      navigateToNextScreen(BuildContext context,Widget pageWidget) {
    return Navigator.push(context,
         MaterialPageRoute(builder: (BuildContext context) => pageWidget));
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
        //       child: CachedNetworkImage(
        // imageUrl: image,
        // fit: BoxFit.cover,
        // progressIndicatorBuilder: (context, url, downloadProgress) => 
        //         Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
        // errorWidget: (context, url, error) => Image.asset("./asset/image/no_book.png",fit: BoxFit.cover,),
        //          ),
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
                maxLines: 8,
                overflow: TextOverflow.ellipsis,
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