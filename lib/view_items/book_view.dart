
import 'package:flutter/material.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/view_items/check_icon_view.dart';

class BookView extends StatelessWidget {

  final String name;
  final double bookWidth;
  final double bookHeight;
  final double SizeOfName;
  final bool isVisible;
  final Function onClick;

  BookView({
    required this.name,
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
             BookCoverImageView(bookWidth: bookWidth, bookHeight: bookHeight,isVisible: isVisible),
          SizedBox(height: MARGIN_SMALL,),
           Text(name,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(
              color: Colors.black,
              fontSize: SizeOfName,
              fontWeight: FontWeight.w600,
            ),
           ),
           Visibility(
             visible: isVisible,
             child: Text("${5.0}★ \$${3.99}",
              style: TextStyle(
                color: Colors.black,
                fontSize: TEXT_SMALL_1X,
                fontWeight: FontWeight.w600,
              ),
             ),
           ),
        ],
      ),
    );
  }
}

class BookCoverImageView extends StatelessWidget {
  const BookCoverImageView({
    Key? key,
    required this.bookWidth,
    required this.bookHeight,
    required this.isVisible,
  }) : super(key: key);

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
                   borderRadius: BorderRadius.all(Radius.circular(MARGIN_SMALL_1X)),
                 ),
                 margin: EdgeInsets.only(right: MARGIN_SMALL_1X),
                 child: Image.network("https://s26162.pcdn.co/wp-content/uploads/2020/01/Sin-Eater-by-Megan-Campisi.jpg",
                 fit: BoxFit.cover,),
                      ),
              ),
              
              Align(
                alignment: Alignment.bottomRight,
                child: Visibility(
                  visible: !isVisible,
                  child: CheckIconView()),
              )
            ],
          ),
        ),
      );
  }
}