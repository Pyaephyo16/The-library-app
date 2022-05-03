import 'package:flutter/material.dart';
import 'package:the_library_app/resources/constants.dart';
import 'package:the_library_app/resources/dimens.dart';

class UserProfileView extends StatelessWidget {
 
    final double width;
    final double height;
    final bool isInDetail;
    final String image;

    UserProfileView({
      required this.width,
      required this.height,
      required this.isInDetail,
      required this.image,
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.only(right: MARGIN_SMALL),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular((isInDetail) ? 25 : MARGIN_SMALL_1X),
      ),
      child: Image.network(image,
        fit: BoxFit.cover,
      ),
    );
  }
}