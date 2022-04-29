import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_library_app/resources/dimens.dart';

class EllipisIconView extends StatelessWidget {
 
  final Color color;
  final Function tabBookInfoBtn;

  EllipisIconView({
    required this.color,
    required this.tabBookInfoBtn,
    });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (){
        tabBookInfoBtn();
      },
       icon: FaIcon(FontAwesomeIcons.ellipsis),iconSize: MARGIN_MEDIUM_3X,color: color);
  }
}