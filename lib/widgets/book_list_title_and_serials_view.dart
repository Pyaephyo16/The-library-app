import 'package:flutter/material.dart';
import 'package:the_library_app/resources/constants.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/view_items/book_list_title_view.dart';
import 'package:the_library_app/view_items/book_view.dart';

class BookListTileAndSerialsView extends StatelessWidget {

  final String title;
  final Function onClick;

  BookListTileAndSerialsView({
    required this.title,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: HORIZONTAL_LIST_CONTAINER_HEIGHT,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BookListTitleView(
              title: title,
              padd: MARGIN_MEDIUM_2,
          ),
          HorizontalBookListView(
            onClick: () => onClick(),
          ),
        ],
      ),
    );
  }
}

class HorizontalBookListView extends StatelessWidget {

  final Function onClick;

  HorizontalBookListView({
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: BOOK_VIEW_CONTAINER_HEIGHT,
      child: ListView.builder(
        padding: EdgeInsets.only(left: MARGIN_MEDIUM_2,right: MARGIN_MEDIUM_2,top: MARGIN_SMALL_1X),
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context,index){
          return BookView(
            name: BOOK_NAME,
            bookWidth: BOOK_COVER_CONTAINER_WIDTH,
            bookHeight: BOOK_COVER_CONTAINER_HEIGHT,
            SizeOfName: TEXT_SMALL_1X,
            isVisible: true,
            onClick: ()=> onClick(),
          );
        },
      ),
    );
  }
}
