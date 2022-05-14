import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:the_library_app/blocs/home_tab_bloc.dart';
import 'package:the_library_app/data/vos/shelf_vo.dart';
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
  final String image;

  ShelvesView({
    required this.shelfs,
    required this.goToShelf,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {

    // WidgetsBinding.instance?.addPostFrameCallback((_){
    //   HomePageBloc bloc= Provider.of(context,listen: false);
    //   bloc.yourbookOrLib(1);
    // });

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
            key: Key("ShelvesViewShelf$index"),
             index: index,
             image:  (shelfs[index].books?.length != 0) ? shelfs[index].books?.first.bookImage ?? shelfs[index].books?.first.searchResult?.volumeInfo?.imageLinks?.thumbnail ?? IMAGE_CONSTANT_ONLINE : IMAGE_CONSTANT_ONLINE,
             goToShelf: (index)=> goToShelf(index),
             title: shelfs[index].shelfName ?? "",
             book: shelfs[index].books?.length ?? 0,
             isInAddToShelf: false,
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
    required this.key,
    required this.index,
    required this.goToShelf,
    required this.title,
    required this.book,
    required this.image,
    required this.isInAddToShelf,
  });

  final Key key;
  final int index;
  final Function goToShelf;
  final String title;
  final int book;
  final String image;
  final bool isInAddToShelf;

  @override
  Widget build(BuildContext context) {
    // return GestureDetector(
    //   onTap: (){
    //     goToShelf(index);
    //   },
    //   child: Column(
    //     children: [
    //       Row(
    //         children: [
    //           BookNameAndInfoView(
    //             onClick: (){
    //               goToShelf(index);
    //             },
    //             isSheet: false,
    //             title: title,
    //             image: image,
    //             content: "$book books",
    //             isInShelf: false,
    //             ),
    //           Spacer(),
    //           Visibility(
    //             visible: !isInAddToShelf,
    //             child: IconButton(
    //               onPressed: (){
    //                 goToShelf(index);
    //             }, 
    //             icon: Icon(Icons.chevron_right,size: MARGIN_MEDIUM_4,),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
    return ListTile(
      onTap: (){
        goToShelf(index);
      },
      leading: Container(
        width: 76,
        height: 140,
        child: CachedNetworkImage(
          imageUrl: image,
          fit: BoxFit.cover,
          progressIndicatorBuilder: (context, url, downloadProgress) => 
                  Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
          errorWidget: (context, url, error) => Image.asset("./asset/image/no_book.png",fit: BoxFit.cover,),
                   ),
      ),
      title: Text(title,
             maxLines: 2,
             overflow: TextOverflow.ellipsis,
             style: TextStyle(
               //fontSize: (isInShelf == true) ? TEXT_MEDIUM : TEXT_SMALL_1X,
               fontSize: TEXT_MEDIUM_2,
               fontWeight: FontWeight.w400,
               color: BTM_SHEET_OPTION_TEXT_COLOR,
             ),
             ),
             subtitle: Text("$book books",
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              //fontSize: (isInShelf == true) ? TEXT_MEDIUM : TEXT_SMALL_1X,
              fontSize: TEXT_SMALL_1X,
              fontWeight: FontWeight.w400,
            ),
            ),
      trailing:  Visibility(
                visible: !isInAddToShelf,
               child: IconButton(
                 onPressed: (){
                  goToShelf(index);
               }, 
                icon: Icon(Icons.chevron_right,size: MARGIN_MEDIUM_4,),
                ),
      ),    
    );
  }
}