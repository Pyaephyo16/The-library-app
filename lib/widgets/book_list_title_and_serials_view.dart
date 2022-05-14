import 'package:flutter/material.dart';
import 'package:the_library_app/data/vos/overview/book_vo.dart';
import 'package:the_library_app/resources/constants.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/view_items/book_list_title_view.dart';
import 'package:the_library_app/view_items/book_view.dart';

class BookListTileAndSerialsView extends StatelessWidget {

  final int indexO;
  final Key key;
  final String title;
  final List<BookVO> books;
  final Function(int) onClick;
  final Function goToNext;
  final bool isShowPrice;

  BookListTileAndSerialsView({
    required this.key,
    required this.title,
    required this.indexO,
    required this.books,
    required this.isShowPrice,
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
            indexO: indexO,
              isListFromHome: false,
              title: title,
              padd: MARGIN_MEDIUM_2,
              goToNext: (){
                goToNext();
              },
          ),
          HorizontalBookListView(
            books: books,
            indexO: indexO,
            isShowPrice: isShowPrice,
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
  final bool isShowPrice;
  final int indexO;

  HorizontalBookListView({
    required this.books,
    required this.indexO,
    required this.isShowPrice,
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
            key: Key("ebook$indexO$index"),
            isInShelf: false,
            isShowPrice: isShowPrice,
            name: books[index].title ?? books[index].searchResult?.volumeInfo?.title ?? "",
            price: books[index].price ?? "",
            author: books[index].author ?? books[index].searchResult?.volumeInfo?.authors?.first ?? "",
            image: books[index].bookImage ?? books[index].searchResult?.volumeInfo?.imageLinks?.thumbnail ?? IMAGE_CONSTANT_ONLINE,
            bookWidth: BOOK_COVER_CONTAINER_WIDTH,
            bookHeight: BOOK_COVER_CONTAINER_HEIGHT,
            SizeOfName: TEXT_SMALL_1X,
            isVisible: true,
            sheetFun: (){},
            onClick: ()=> onClick(index),
          );
        },
      ),
    );
  }
}
