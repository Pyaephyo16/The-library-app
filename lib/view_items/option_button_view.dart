import 'package:flutter/material.dart';
import 'package:the_library_app/resources/colors.dart';
import 'package:the_library_app/resources/dimens.dart';

class OptionButtonView extends StatelessWidget {

  final String title;
  final Icon icon;
  final Function() onClick;

  OptionButtonView({
    required this.title,
    required this.icon,
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
         icon,
         SizedBox(width: MARGIN_SMALL,),
          Text( title,
          style: TextStyle(
            color: BOOK_EXTRA_DATA_CONTENT_COLOR,
            fontSize: TEXT_SMALL_1X,
          ),
          ),
        ],
      ),
    );
  }
}