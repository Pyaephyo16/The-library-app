import 'package:flutter/material.dart';
import 'package:the_library_app/resources/colors.dart';
import 'package:the_library_app/resources/dimens.dart';

class BookListTitleView extends StatelessWidget {

  final String title;
  final double padd;
  final bool isListFromHome;
  final Function goToNext;

  BookListTitleView({
    required this.title,
    required this.padd,
    required this.isListFromHome,
    required this.goToNext,
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: MARGIN_MEDIUM_2,left: padd),
      child: Row(
                  children: [
                     Visibility(
                       visible: isListFromHome,
                       child: IconButton(
                         onPressed: (){
                            Navigator.pop(context);
                         }, 
                        icon: Icon(Icons.chevron_left,size: MARGIN_MEDIUM_4,color: CHEVRON_ARROW_COLOR),
                         ),
                       ),
                    Expanded(
                      child: Text(title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: TEXT_MEDIUM_2,
                        fontWeight: FontWeight.w600,
                        color: BTM_SHEET_OPTION_TEXT_COLOR
                      ),
                      ),
                    ),
                    Visibility(
                      visible: !isListFromHome,
                      child: IconButton(
                        onPressed: (){
                            goToNext();
                        }, 
                        icon:  Icon(Icons.chevron_right,size: MARGIN_MEDIUM_4,color: CHEVRON_ARROW_COLOR),
                        ),
                      ),
                  ],
                ),
    );
  }
}