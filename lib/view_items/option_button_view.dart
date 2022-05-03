import 'package:flutter/material.dart';
import 'package:the_library_app/resources/colors.dart';
import 'package:the_library_app/resources/dimens.dart';

class OptionButtonView extends StatelessWidget {

  final bool isInSheet;
  final String title;
  final Icon icon;
  final Function() onClick;

  OptionButtonView({
    required this.isInSheet,
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
    
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: (isInSheet) ?  MARGIN_MEDIUM_2 : 0),
        child: Row(
          children: [
           icon,
           SizedBox(width: (isInSheet) ? MARGIN_MEDIUM_2 : MARGIN_SMALL,),
            Text( title,
            style: TextStyle(
              fontSize: (isInSheet) ? TEXT_REGULAR : TEXT_SMALL_1X,
              fontWeight: (isInSheet) ? FontWeight.w600 : FontWeight.w600,
              color: (isInSheet) ? BTM_SHEET_OPTION_TEXT_COLOR: SAMPLE_BACKGROUND_COLOR, 
            ),
            ),
          ],
        ),
      ),
    );
  }
}