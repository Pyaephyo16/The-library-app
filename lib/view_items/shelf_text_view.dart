import 'package:flutter/material.dart';
import 'package:the_library_app/resources/colors.dart';
import 'package:the_library_app/resources/constants.dart';
import 'package:the_library_app/resources/dimens.dart';

class ShelfTextView extends StatelessWidget {
 
  final TextEditingController name;
  final GlobalKey<FormState> formKey;
  final bool isFocus;
  final FocusNode focusNode;

  ShelfTextView({
    required this.name,
    required this.formKey,
    required this.isFocus,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: TextFormField(
        controller: name,
        focusNode: focusNode,
        autofocus: isFocus,
        cursorWidth: 3,
        cursorHeight: 26,
        style: TextStyle(
            fontSize: TEXT_MEDIUM_2,
            fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: ENTE_SHELF_NAME_TEXT,
          hintStyle: TextStyle(
            color: BOOK_EXTRA_DATA_CONTENT_COLOR,
            fontSize: TEXT_MEDIUM_2,
            fontWeight: FontWeight.w400,
          ),
        ),
        validator: (str){
          if(str!.isEmpty){
            return REQUIRED_TEXT;
          }
          return null;
        },
      ),
    );
  }
}