
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:the_library_app/resources/colors.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/view_items/check_icon_view.dart';
import 'package:the_library_app/view_items/ellipis_icon_view.dart';

class BookView extends StatelessWidget {

  final String name;
  final String price;
  final String author;
  final String image;
  final bool isShowPrice;
  final double bookWidth;
  final double bookHeight;
  final double SizeOfName;
  final bool isVisible;
  final Function onClick;
  final Function sheetFun;
  final bool isInShelf;

  BookView({
    required this.name,
    required this.price,
    required this.author,
    required this.isShowPrice,
    required this.image,
    required this.bookWidth,
    required this.bookHeight,
    required this.SizeOfName,
    required this.isVisible,
    required this.onClick,
    required this.sheetFun,
    required this.isInShelf,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onClick();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: MARGIN_PRE_SMALL),
        child: Container(
          width: bookWidth,
          height: bookHeight,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             BookCoverImageView(
               sheetFun: (){
                 sheetFun();
               },
               isINShelf: isInShelf,
               image: image,
               bookWidth: bookWidth,
                bookHeight: bookHeight,
                isVisible: isVisible,
                ),
              SizedBox(height: MARGIN_SMALL,),
               Text(name,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color: BTM_SHEET_OPTION_TEXT_COLOR,
                  fontSize: SizeOfName,
                  fontWeight: FontWeight.w400,
                ),
               ),
               Visibility(
                 visible: isVisible,
                 child: Text("$author",
                 maxLines: 1,
                 overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: BTM_SHEET_OPTION_TEXT_COLOR,
                    fontSize: TEXT_SMALL_1X,
                  ),
                 ),
               ),
               Visibility(
                 visible: isShowPrice,
                 child: Text("\$$price",
                 maxLines: 1,
                 overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: BTM_SHEET_OPTION_TEXT_COLOR,
                    fontSize: TEXT_SMALL_1X,
                  ),
                 ),
               ),
            ],
          ),
        ),
      ),
    );
  }
}

class BookCoverImageView extends StatelessWidget {
  const BookCoverImageView({
    Key? key,
    required this.image,
    required this.bookWidth,
    required this.bookHeight,
    required this.isVisible,
    required this.sheetFun,
    required this.isINShelf,
  }) : super(key: key);

  final String image;
  final double bookWidth;
  final double bookHeight;
  final bool isVisible;
  final Function sheetFun;
  final bool isINShelf;

  @override
  Widget build(BuildContext context) {
      return Center(
        child: Container(
          height: bookHeight,
          width: bookWidth,
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                 width: bookWidth,
                 height: bookHeight,
                 clipBehavior: Clip.antiAlias,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.all(Radius.circular(MARGIN_PRE_SMALL)),
                 ),
                //  child: Image.network(image,
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
              
              Align(
                alignment: Alignment.bottomRight,
                child: Visibility(
                  visible: !isVisible,
                  child: CheckIconView(
                    isInShelvesIcon: false,
                  )),
              ),

              Align(
                alignment: Alignment.topRight,
                child: Visibility(
                  visible: isINShelf,
                  child: EllipisIconView(
                    color: Colors.white,
                     tabBookInfoBtn: (){
                        sheetFun();
                     },
                     ),
                ),
              )
            ],
          ),
        ),
      );
  }
}