
import 'package:flutter/material.dart';
import 'package:the_library_app/resources/constants.dart';
import 'package:the_library_app/widgets/book_list_title_and_serials_view.dart';

class AudioBooksView extends StatelessWidget {
  final Function(int) onClick;
  final Function goToNext;

  AudioBooksView({
    required this.onClick,
    required this.goToNext,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
       mainAxisSize: MainAxisSize.min,
      children: [
        BookListTileAndSerialsView(
          key: Key("EbookListOneTitleAndSerial"),
          books: [],
          indexO: -2,
          isShowPrice: true,
          title: AUDIOBOOK_LIST_TITLE_1,
          onClick: (userSelectBookIndex) => onClick(userSelectBookIndex),
          goToNext: (){
            goToNext();
          },
          ),
          BookListTileAndSerialsView(
             key: Key("EbookListTwoTitleAndSerial"),
            books: [],
            indexO: -2,
            isShowPrice: true,
          title: AUDIOBOOK_LIST_TITLE_2,
          onClick: (userSelectBookIndex) => onClick(userSelectBookIndex),
          goToNext: (){
            goToNext();
          },
          ),
          BookListTileAndSerialsView(
             key: Key("EbookListThreeTitleAndSerial"),
            books: [],
            indexO: -2,
            isShowPrice: true,
          title: AUDIOBOOK_LIST_TITLE_3,
          onClick: (userSelectBookIndex) => onClick(userSelectBookIndex),
          goToNext: (){
            goToNext();
          },
          ),
      ],
    );
  }

     
}
