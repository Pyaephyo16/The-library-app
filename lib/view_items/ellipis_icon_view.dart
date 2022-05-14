import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_library_app/resources/colors.dart';
import 'package:the_library_app/resources/dimens.dart';

class EllipisIconView extends StatelessWidget {
 
  final Key key;
  final Color color;
  final Function tabBookInfoBtn;

  EllipisIconView({
    required this.key,
    required this.color,
    required this.tabBookInfoBtn,
    });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (){
        tabBookInfoBtn();
      },
       icon: FaIcon(FontAwesomeIcons.ellipsis,color: color,),iconSize: MARGIN_MEDIUM_3X);
  }
}