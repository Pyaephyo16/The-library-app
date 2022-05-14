import 'package:flutter/material.dart';
import 'package:the_library_app/data/vos/overview/book_list_vo.dart';
import 'package:the_library_app/data/vos/overview/book_vo.dart';
import 'package:the_library_app/widgets/book_list_title_and_serials_view.dart';

class EbooksView extends StatelessWidget {

  final List<BookListVO> bookList;
  final Function(BookVO) onClick;
  final Function(int) goToNext;

  EbooksView({
    required this.bookList,
    required this.onClick,
    required this.goToNext,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: bookList.length,
      itemBuilder: (BuildContext context,int indexO){
        return BookListTileAndSerialsView(
          key: Key("EbookListTitleAndSerial"),
          isShowPrice: true,
          indexO: indexO,
          title: bookList[indexO].listName ?? "",
          books: bookList[indexO].books ?? [],
           onClick: (userSelectBookIndex){
             onClick(bookList[indexO].books?[userSelectBookIndex] ?? BookVO.empty());
           },
            goToNext:()=> goToNext(indexO),
            );
      },
    );
  }

 

}