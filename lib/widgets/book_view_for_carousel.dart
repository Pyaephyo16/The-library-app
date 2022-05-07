import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_library_app/resources/colors.dart';
import 'package:the_library_app/resources/constants.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/view_items/check_icon_view.dart';
import 'package:the_library_app/view_items/ellipis_icon_view.dart';

class BookViewForCarousel extends StatelessWidget {

  final String image;
  final bool isSample;
  final Function menuFun;

  BookViewForCarousel({
    required this.image,
    required this.isSample,
    required this.menuFun,
    });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            clipBehavior: Clip.antiAlias,
            width: MediaQuery.of(context).size.width * 0.5,
            height: CAROUSEL_IMAGE_CONTAINER_HEIGHT,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(MARGIN_SMALL_1X),
            ),
            child: Image.network(image,
            fit: BoxFit.cover,
            ),
        //    child: CachedNetworkImage(
        // imageUrl: image,
        // fit: BoxFit.cover,
        // progressIndicatorBuilder: (context, url, downloadProgress) => 
        //         Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
        // errorWidget: (context, url, error) => Image.asset("./asset/image/no_book.png",fit: BoxFit.cover,),
        //          ),
          )
        ),

        Align(
          alignment: Alignment.topLeft,
          child: Visibility(
            visible: isSample,
            child: SampleTextView(),
          ),
        ),

        Align(
          alignment: Alignment.topRight,
          child: EllipisIconView(
            color: Colors.white,
            tabBookInfoBtn: (){
              menuFun();
            },
          ),
        ),

        Align(
          alignment: Alignment.bottomLeft,
          child: HeadsetIconView(),
        ),

        Align(
          alignment: Alignment.bottomRight,
          child: CheckIconView(
            isInShelvesIcon: false,
          ),
        ),
      ],
    );
  }
}

class SampleTextView extends StatelessWidget {
  const SampleTextView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
       margin: EdgeInsets.all(MARGIN_SMALL_1X),
        width: BOOK_SAMPLE_VIEW_CONTAINER_WIDTH,
        height: BOOK_SAMPLE_VIEW_CONTAINER_HEIGHT,
        decoration: BoxDecoration(
          color: BOOK_ICON_COLOR,
          borderRadius: BorderRadius.circular(MARGIN_SMALL),
        ),
        child: Center(
          child: Text(BOOK_SAMPLE_TEXT,
            style: TextStyle(
              color: Colors.white,
              fontSize: TEXT_SMALL,
            ),
          ),
        ),
    );
  }
}


class HeadsetIconView extends StatelessWidget {
  const HeadsetIconView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(MARGIN_SMALL_1X),
      width: BOOK_DATA_VIEW_CONTAINER_WIDTH,
      height: BOOK_DATA_VIEW_CONTAINER_HEIGHT,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MARGIN_SMALL),
      color: BOOK_ICON_COLOR,
      ),
      child: IconButton(
      onPressed: (){
      },
       icon: FaIcon(FontAwesomeIcons.headset),iconSize: MARGIN_MEDIUM_2X,color: Colors.white,),
    );
  }
}

