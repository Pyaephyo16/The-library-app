import 'package:flutter/material.dart';
import 'package:the_library_app/resources/colors.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/view_items/shelf_text_view.dart';

class shelfCreateSection extends StatelessWidget {
  const shelfCreateSection({
    Key? key,
    required this.isFocus,
    required this.formKey,
    required this.shelfName,
    required this.creation,
    required this.focusNode,
  }) : super(key: key);

  final bool isFocus;
  final GlobalKey<FormState> formKey;
  final TextEditingController shelfName;
  final Function creation;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
            CreateButton(
              createBtn: (){
                creation();
              },
            ),
           SizedBox(height: MARGIN_SMALL_1X,),
           ShelfTextView(
             name: shelfName,
             formKey: formKey,
             isFocus: isFocus,
             focusNode: focusNode,
           ),
      ],
    );
  }
}


class CreateButton extends StatelessWidget {
  
    final Function createBtn;

    CreateButton({
      required this.createBtn,
    });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (){
          createBtn();
      },
     icon: Icon(Icons.check,color: Colors.blue,size: 32,),
     );
  }
}

