import 'package:flutter/material.dart';
import 'package:the_library_app/resources/colors.dart';
import 'package:the_library_app/resources/constants.dart';
import 'package:the_library_app/resources/dimens.dart';

class SearchFieldSection extends StatelessWidget {
  
    final bool isSearchPage;
    final Function prefixTouch;
    final Icon icon;
    final Function(String) typing;
    final TextEditingController searchText;

    SearchFieldSection({
      required this.isSearchPage,
      required this.prefixTouch,
      required this.icon,
      required this.typing,
      required this.searchText,
    });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: searchText,
      enabled: isSearchPage,
      onChanged: (str){
          typing(str);
      },
      style: TextStyle(
        fontSize: TEXT_REGULAR,
        fontWeight: FontWeight.w400,
      ),
    decoration: InputDecoration(
      fillColor: Colors.white,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(MARGIN_SMALL_1X)),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      prefixIcon: IconButton(
        onPressed: (){
            prefixTouch();
      }, 
      icon: icon,
      ),
      suffixIcon: Visibility(
        visible: !isSearchPage,
        child: Container(
          width: PROFILE_CONTAINER_WIDTH,
          height: PROFILE_CONTAINER_HEIGHT,
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.only(right: MARGIN_SMALL),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(MARGIN_SMALL_1X),
          ),
          child: Image.network("https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg",
            fit: BoxFit.cover,
          ),
        ),
      ),
      hintStyle: TextStyle(
        color: TEXT_FIELD_HINT_TEXT_COLOR,
        fontSize:TEXT_REGULAR,
        fontWeight: FontWeight.w600,
      ),
      hintText: TEXTFIELD_HINT_TEXT,
    ),
       );
  }
}