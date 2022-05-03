
import 'package:flutter/material.dart';
import 'package:the_library_app/resources/colors.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/view_items/check_icon_view.dart';

class BookView extends StatelessWidget {

  final String name;
  final String price;
  final String image;
  final double bookWidth;
  final double bookHeight;
  final double SizeOfName;
  final bool isVisible;
  final Function onClick;

  BookView({
    required this.name,
    required this.price,
    required this.image,
    required this.bookWidth,
    required this.bookHeight,
    required this.SizeOfName,
    required this.isVisible,
    required this.onClick,
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
               image: image,
               bookWidth: bookWidth,
                bookHeight: bookHeight,
                isVisible: isVisible,
                ),
              SizedBox(height: MARGIN_SMALL,),
               Text(name,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  color: BTM_SHEET_OPTION_TEXT_COLOR,
                  fontSize: SizeOfName,
                ),
               ),
               Visibility(
                 visible: isVisible,
                 child: Text("${5.0}★  \$$price",
                 maxLines: 2,
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
  }) : super(key: key);

  final String image;
  final double bookWidth;
  final double bookHeight;
  final bool isVisible;

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
                 //margin: EdgeInsets.only(right: MARGIN_PRE_SMALL),
                 child: Image.network(image,
                 fit: BoxFit.cover,),
                      ),
              ),
              
              Align(
                alignment: Alignment.bottomRight,
                child: Visibility(
                  visible: !isVisible,
                  child: CheckIconView(
                    isInShelvesIcon: false,
                  )),
              )
            ],
          ),
        ),
      );
  }
}