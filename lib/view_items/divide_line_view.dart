
import 'package:flutter/material.dart';
import 'package:the_library_app/resources/colors.dart';

class DivideLineView extends StatelessWidget {
  
    final double thick;

    DivideLineView({
      required this.thick,
    });

  @override
  Widget build(BuildContext context) {
    return Container(height: thick,color:BTM_SHEET_OPTION_ICON_COLOR,margin: EdgeInsets.symmetric(vertical: 10),);
  }
}