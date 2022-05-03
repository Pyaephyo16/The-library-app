import 'package:flutter/material.dart';
import 'package:the_library_app/data/vos/overview/book_vo.dart';
import 'package:the_library_app/resources/constants.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/view_items/book_list_title_view.dart';
import 'package:the_library_app/view_items/book_view.dart';

class BookListTileAndSerialsView extends StatelessWidget {

  final String title;
  final List<BookVO> books;
  final Function(int) onClick;
  final Function goToNext;

  BookListTileAndSerialsView({
    required this.title,
    required this.books,
    required this.onClick,
    required this.goToNext,
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
              isListFromHome: false,
              title: title,
              padd: MARGIN_SMALL,
              goToNext: (){
                goToNext();
              },
          ),
          HorizontalBookListView(
            books: books,
            onClick: (userSelectBookIndex) => onClick(userSelectBookIndex),
          ),
        ],
      ),
    );
  }
}

class HorizontalBookListView extends StatelessWidget {

  final List<BookVO> books;
  final Function(int) onClick;

  HorizontalBookListView({
    required this.books,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: BOOK_VIEW_CONTAINER_HEIGHT,
      child: ListView.builder(
        padding: EdgeInsets.only(left: MARGIN_SMALL_1,right: MARGIN_MEDIUM_2,top: MARGIN_SMALL_1X),
        scrollDirection: Axis.horizontal,
        itemCount: books.length,
        itemBuilder: (context,index){
          return BookView(
            name: books[index].title ?? "",
            price: books[index].price ?? "",
            image: books[index].bookImage ?? "",
            bookWidth: BOOK_COVER_CONTAINER_WIDTH,
            bookHeight: BOOK_COVER_CONTAINER_HEIGHT,
            SizeOfName: TEXT_SMALL_1X,
            isVisible: true,
            onClick: ()=> onClick(index),
          );
        },
      ),
    );
  }
}
