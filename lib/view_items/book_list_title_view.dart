import 'package:flutter/material.dart';
import 'package:the_library_app/resources/colors.dart';
import 'package:the_library_app/resources/dimens.dart';

class BookListTitleView extends StatelessWidget {

  final String title;
  final double padd;

  BookListTitleView({required this.title,required this.padd});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padd),
      child: Row(
                  children: [
                    Expanded(
                      child: Text(title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: TEXT_MEDIUM_2,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                      ),
                    ),
                    Icon(Icons.chevron_right,size: MARGIN_MEDIUM_4,color: CHEVRON_ARROW_COLOR),
                  ],
                ),
    );
  }
}