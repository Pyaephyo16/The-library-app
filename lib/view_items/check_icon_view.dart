import 'package:flutter/material.dart';
import 'package:the_library_app/resources/colors.dart';
import 'package:the_library_app/resources/dimens.dart';
import '../resources/constants.dart';

class CheckIconView extends StatelessWidget {
  const CheckIconView({
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
        color: SAMPLE_BACKGROUND_COLOR,
      ),
      child: Icon(Icons.check,color: Colors.white,),
    );
  }
}