import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:the_library_app/resources/colors.dart';
import 'package:the_library_app/resources/constants.dart';
import 'package:the_library_app/resources/dimens.dart';

class BookNameAndInfoView extends StatelessWidget {
  
  final bool isSheet;
  final String title;
  final String image;
  final String content;
  final bool isInShelf;
  final Function onClick;

  BookNameAndInfoView({
    required this.isSheet,
    required this.title,
    required this.image,
    required this.content,
    required this.isInShelf,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onClick();
      },
      child: Row(
        children: [
          Visibility(
            visible: !isInShelf,
            child: Container(
                margin: EdgeInsets.only(left: MARGIN_PRE_SMALL),
                width: (isSheet == true) ? BOOK_NAME_AND_INFO_SHEET_CONTAINER_WIDTH : BOOK_NAME_AND_INFO_CONTAINER_WIDTH,
                height: (isSheet == true) ? BOOK_NAME_AND_INFO_SHEET_CONTAINER_HEIGHT : BOOK_NAME_AND_INFO_CONTAINER_HEIGHT,
                // child: Image.network(image,
                //  fit: BoxFit.cover,),
        child: CachedNetworkImage(
        imageUrl: image,
        fit: BoxFit.cover,
        progressIndicatorBuilder: (context, url, downloadProgress) => 
                Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
        errorWidget: (context, url, error) => Image.asset("./asset/image/no_book.png",fit: BoxFit.cover,),
                 ),
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
             maxLines: 2,
             overflow: TextOverflow.ellipsis,
             style: TextStyle(
               fontSize: (isInShelf == true) ? TEXT_MEDIUM : TEXT_SMALL_1X,
               fontWeight: FontWeight.w400,
               color: BTM_SHEET_OPTION_TEXT_COLOR,
             ),
             ),
          Expanded(
            child: Text(content,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
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
      ),
    );
  }
}