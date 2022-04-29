import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_library_app/resources/colors.dart';
import 'package:the_library_app/resources/constants.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/view_items/book_list_title_view.dart';
import 'package:the_library_app/widgets/book_list_title_and_serials_view.dart';

class BookDetailPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          children: [
            AppBarView(),
            SizedBox(height: MARGIN_MEDIUM_2X,),
            Column(
              children: [
                BookTitleAndCoverView(),
                SizedBox(height: MARGIN_MEDIUM_2_EXTRA,),
                BookDetail(),
                SizedBox(height: MARGIN_MEDIUM_2X,),
                ButtonRowView(
                  btn1Text: "Free sample",
                  btn2Text: "Buy \$14.99",
                  btn1Click: (){},
                  btn2Click: (){},
                ),
                SizedBox(height: MARGIN_MEDIUM_2_EXTRA,),
                SwitchButtonView(
                  data: "audiobook",
                ),
                SizedBox(height: MARGIN_MEDIUM_2_EXTRA,),
                Divider(color: Colors.black,thickness: 1,),
                SizedBox(height: MARGIN_MEDIUM_2_EXTRA,),
                AboutTheBookView(
                  title: "About this eBook",
                  content: "\"A distressing and important book\" \-Stephanie Ruhle,MSNBC For readers of War Dogs and Bad Blood,an explosive look inside the rush to profit from the Capital.It was very intersting and beautiful.",
                ),
                SizedBox(height: MARGIN_MEDIUM_2_EXTRA,),
                AboutTheBookView(
                  title: "About the Author",
                  content: "J. David McSwane is a reporter in ProPublica\'s DC office.Previously,he was an investigative reporter for The Dallas Morning News and the Austin American-Statesman.",
                ),
                SizedBox(height: MARGIN_MEDIUM_2_EXTRA,),
                BookListTileAndSerialsView(
                  title: "Similar Books",
                   onClick: () => 
                      navigateToNextScreen(context),
                   ),
              ],
            )
          ],
        ),
      ),
    );
  }

      navigateToNextScreen(BuildContext context) {
    return Navigator.push(context,
         MaterialPageRoute(builder: (BuildContext context) => BookDetailPage()));
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BookListTitleView(
          title: title,
          padd: 0,
          ),
          SizedBox(height: MARGIN_SMALL,),
        Text(content,
          style: TextStyle(
            color: Colors.grey,
            fontSize: TEXT_REGULAR,
          ),
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class SwitchButtonView extends StatelessWidget {

  final String data;

  SwitchButtonView({required this.data});

  @override
  Widget build(BuildContext context) {
    return Text("Switch to ${data}",
      style: TextStyle(
        color: BUTTON_TEXT_COLOR,
        fontSize: TEXT_MEDIUM,
        fontWeight: FontWeight.w500,
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
    return Row(
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
          bgColor: BUTTON_COLOR,
          onClick: ()=> btn2Click(),
        ),
      ],
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
          border: (isGhostButton) ? Border.all(color: Colors.black) : null,
          color: bgColor,
        ),
        child: Center(
          child: Text(title,
          style: TextStyle(
            fontSize: TEXT_REGULAR,
            color: (isGhostButton) ? BUTTON_TEXT_COLOR :Colors.black,
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
          BookInfoView(
            isIcon: false,
            title: "4.9★",
            content: "7 reviews",
            icon: null,
          ),
          BookInfoDividerView(),
           BookInfoView(
             isIcon: true,
             title: "",
             content: "eBook",
             icon: FaIcon(FontAwesomeIcons.bookBookmark),
           ),
           BookInfoDividerView(),
            BookInfoView(
              isIcon: false,
              title: "336",
              content: "Pages",
              icon: null,
            ),
            BookInfoDividerView(),
             BookInfoView(
               isIcon: true,
               title: "",
               content: "Eligible",
               icon: FaIcon(FontAwesomeIcons.homeLgAlt),
             ),
      ],
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
      color: Colors.black,
    );
  }
}

class BookInfoView extends StatelessWidget {

  final bool isIcon;
  final String title;
  final String content;
  final FaIcon? icon;

  BookInfoView({
    required this.isIcon,
    required this.title,
    required this.content,
     this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: !isIcon,
          child: Text(title,
          style: TextStyle(
            color: Colors.black,
            fontSize: TEXT_MEDIUM_2,
            fontWeight: FontWeight.w600,
          ),
          ),
        ),
        Visibility(
          visible: isIcon,
          child: icon ?? Container(),
          ),
        Text(content,
        style: TextStyle(
          color: Colors.black,
          fontSize: TEXT_REGULAR,
          fontWeight: FontWeight.w600,
        ),
        ),
      ],
    );
  }
}

class BookTitleAndCoverView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            //width: 180,
            //height: 220,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(MARGIN_MEDIUM_2X),
            ),
            child: Image.network("https://s26162.pcdn.co/wp-content/uploads/2020/01/Sin-Eater-by-Megan-Campisi.jpg",
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
              Text(BOOK_NAME,
              style: TextStyle(
                color: Colors.black,
                fontSize: TEXT_MEDIUM_2X,
                fontWeight: FontWeight.w500,
              ),
              ),
              SizedBox(height: MARGIN_MEDIUM,),
              Text("A dark and thrilling page-tunner",
              style: TextStyle(
                color: BOOK_EXTRA_DATA_CONTENT_COLOR,
                fontSize: TEXT_SMALL_1X,
              ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AppBarView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: (){
          Navigator.of(context).pop();
        },
         icon: Icon(Icons.chevron_left_sharp,size: 34,),
         ),
         Spacer(),
         IconButton(
          onPressed: (){
        },
         icon: Icon(Icons.search,size: 28,),
         ),
         IconButton(
          onPressed: (){
        },
         icon: FaIcon(FontAwesomeIcons.circlePlus,),iconSize: 22,
         ),
         DropdownButton(
           alignment: Alignment.center,
           hint: FaIcon(FontAwesomeIcons.ellipsisVertical),iconSize: 22,
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
    );
  }
}