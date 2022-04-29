import 'package:flutter/material.dart';
import 'package:the_library_app/resources/constants.dart';
import 'package:the_library_app/resources/dimens.dart';

class BookNameAndInfoView extends StatelessWidget {
  
  final bool isSheet;
  final String title;
  final String content;
  final bool isInShelf;

  BookNameAndInfoView({
    required this.isSheet,
    required this.title,
    required this.content,
    required this.isInShelf,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Visibility(
          visible: !isInShelf,
          child: Container(
              margin: EdgeInsets.only(left: MARGIN_PRE_SMALL),
              width: (isSheet == true) ? BOOK_NAME_AND_INFO_SHEET_CONTAINER_WIDTH : BOOK_NAME_AND_INFO_CONTAINER_WIDTH,
              height: (isSheet == true) ? BOOK_NAME_AND_INFO_SHEET_CONTAINER_HEIGHT : BOOK_NAME_AND_INFO_CONTAINER_HEIGHT,
              child: Image.network("https://s26162.pcdn.co/wp-content/uploads/2020/01/Sin-Eater-by-Megan-Campisi.jpg",
               fit: BoxFit.cover,),
            ),
        ),
     Container(
       margin: EdgeInsets.only(left: MARGIN_PRE_SMALL),
       width: MediaQuery.of(context).size.width * 0.45,
       height: BOOK_NAME_AND_INFO_SHEET_CONTAINER_HEIGHT,
       child: Column(
         mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.start,
         mainAxisSize: MainAxisSize.min,
         children: [
           Text(title,
           style: TextStyle(
             fontSize: (isInShelf == true) ? TEXT_MEDIUM_2: TEXT_REGULAR,
             fontWeight: FontWeight.w600,
           ),
           ),
        Expanded(
          child: Text(content,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: (isInShelf == true) ? TEXT_MEDIUM : TEXT_SMALL_1X,
            fontWeight: FontWeight.w400,
          ),
          ),
          ),
         ],
       ),
     ),
      ],
    );
  }
}