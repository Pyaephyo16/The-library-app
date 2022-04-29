import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_library_app/blocs/crate_shelf_page_bloc.dart';
import 'package:the_library_app/blocs/home_page_bloc.dart';
import 'package:the_library_app/dummy/dummy_data.dart';
import 'package:the_library_app/resources/colors.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/widgets/shelf_creation_section.dart';

class CreateShelfPage extends StatelessWidget {

  final TextEditingController shelfName = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
            child: shelfCreateSection(
              isFocus: true,
              formKey: formKey,
               shelfName: shelfName,
               creation: (){
                 if(formKey.currentState!.validate()){
                  CreateShelfPageBloc _bloc = Provider.of(context,listen: false);
                   _bloc.newShelf(shelfName.text).then((value) => Navigator.pop(context));
             }
               },
               focusNode: focusNode,
               ),
          ),
        ),
    );
  }
}


