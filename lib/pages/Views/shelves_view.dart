import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_library_app/dummy/dummy_data.dart';
import 'package:the_library_app/pages/book_list_in_grid.dart';
import 'package:the_library_app/resources/colors.dart';
import 'package:the_library_app/resources/constants.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/view_items/book_name_and_info_view.dart';
import 'package:the_library_app/view_items/divide_line_view.dart';

class ShelvesView extends StatelessWidget {

  final List<ShelfVO> shelfs;
  final Function(int) goToShelf;

  ShelvesView({
    required this.shelfs,
    required this.goToShelf,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MARGIN_SMALL,left: 12,right: 12),
      child: 
      ListView.separated(
       separatorBuilder: ((context, index) => DivideLineView(thick: 1,)),
      shrinkWrap: true,
       physics: NeverScrollableScrollPhysics(),
       itemCount: shelfs.length,
       itemBuilder: (BuildContext context,int index){
         return 
          ShelfView(
           index: index,
           goToShelf: (index)=> goToShelf(index),
           title: shelfs[index].title ?? "",
           book: shelfs[index].content ?? "",
           );
       },
            ),
    );
  }
}





class CreateShelfButton extends StatelessWidget {
  
  final Function createShelf;

  CreateShelfButton({
    required this.createShelf,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        createShelf();
      },
      child: Container(
        width: CREATE_SHELF_BUTTON_CONTAINER_WIDTH,
        height: CREATE_SHELF_BUTTON_CONTAINER_HEIGHT,
        decoration: BoxDecoration(
          color: BUTTON_COLOR,
          borderRadius: BorderRadius.all(Radius.circular(MARGIN_MEDIUM_3X)),
        ),
        child: ShelfCreateBtnTextView(),
      ),
    );
  }
}

class ShelfCreateBtnTextView extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FaIcon(FontAwesomeIcons.pen,color: Colors.white,size: 22,),
        SizedBox(width: MARGIN_PRE_SMALL,),
        Text(CREATE_NEW_SHELF,
        style: TextStyle(
          color: Colors.white,
          fontSize: TEXT_MEDIUM_2,
          fontWeight: FontWeight.w600,
        ),
        ),
      ],
    );
  }
}

class ShelfView extends StatelessWidget {
  const ShelfView({
    Key? key,
    required this.index,
    required this.goToShelf,
    required this.title,
    required this.book,
  }) : super(key: key);

  final int index;
  final Function goToShelf;
  final String title;
  final String book;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        goToShelf(index);
      },
      child: Column(
        children: [
          Row(
            children: [
              BookNameAndInfoView(
                onClick: (){
                  goToShelf(index);
                },
                isSheet: false,
                title: title,
                image: IMAGE_CONSTANT_ONLINE,
                content: "$book",
                isInShelf: false,
                ),
              Spacer(),
              IconButton(
                onPressed: (){
                  goToShelf(index);
              }, 
              icon: Icon(Icons.chevron_right,size: MARGIN_MEDIUM_4,),
              ),
            ],
          ),
        ],
      ),
    );
  }
}