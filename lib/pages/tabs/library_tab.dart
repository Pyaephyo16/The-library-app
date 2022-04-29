import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:the_library_app/blocs/crate_shelf_page_bloc.dart';
import 'package:the_library_app/blocs/home_page_bloc.dart';
import 'package:the_library_app/dummy/dummy_data.dart';
import 'package:the_library_app/pages/book_detail_page.dart';
import 'package:the_library_app/pages/create_shelf_page.dart';
import 'package:the_library_app/pages/shelf_page.dart';
import 'package:the_library_app/resources/colors.dart';
import 'package:the_library_app/resources/constants.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/view_items/book_name_and_info_view.dart';
import 'package:the_library_app/view_items/book_view.dart';
import 'package:the_library_app/view_items/check_icon_view.dart';
import 'package:the_library_app/view_items/ellipis_icon_view.dart';
import 'package:the_library_app/view_items/option_button_view.dart';
import 'package:the_library_app/widgets/book_list_title_and_serials_view.dart';
import 'package:the_library_app/widgets/book_view_for_carousel.dart';

class LibraryTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: ListView(
          children: [
           SizedBox(height: MARGIN_OVER,),
            DefaultTabController(
              length: 2, 
              child: Selector<HomePageBloc,int>(
                      selector: (context,bloc) => bloc.libTabIndex,
                      shouldRebuild: (previous,next) => previous != next,
                      builder: (context,libTabIndex,child) =>
                 TabBar(
                        indicatorSize: TabBarIndicatorSize.label,
                        labelColor: CHEVRON_ARROW_COLOR,
                        unselectedLabelColor: BOOK_EXTRA_DATA_CONTENT_COLOR,
                      tabs: [
                        Tab(child: Text(YOUR_BOOKS),),
                        Tab(child: Text(SHELVES),),
                      ],
                      onTap: (index){
                        HomePageBloc bloc = Provider.of(context,listen: false);
                        bloc.libChooseTab(index);
                      },
                    ),
              ),
              ),
              Column(
              mainAxisSize: MainAxisSize.min,
                children: [ 
                    Selector<HomePageBloc,int>(
                      selector: (context,bloc) => bloc.libTabIndex,
                      shouldRebuild: (previous,next) => previous != next,
                      builder: (context,libTabIndex,child) =>
                       Container(
                      child: (libTabIndex == 0) ?
                            Selector<HomePageBloc,int>(
                              selector: (context,bloc) => bloc.gpValue,
                              shouldRebuild: (previous,next) => previous != next,
                              builder: (context,gpValue,child) =>
                              Selector<HomePageBloc,List<ChipVO>>(
                              selector: (context,bloc) => bloc.chips,
                              shouldRebuild: (previous,next) => previous != next,
                              builder: (context,chips,child) =>
                                Selector<HomePageBloc,int>(
                              selector: (context,bloc) => bloc.sortStyle,
                              shouldRebuild: (previous,next) => previous != next,
                              builder: (context,sortStyle,child) =>
                                    YourBooksView(
                                     chips: chips,
                                   gpValue: gpValue,
                                   sortStyle: sortStyle,
                                    ChooseTab: (gpValue){
                                      BtmSheet(
                                        context,
                                         gpValue,
                                        title: BTM_SHEET_TITLE,
                                        rd1Text: BTM_RD_1,
                                        rd2Text: BTM_RD_2,
                                        rd3Text: BTM_RD_3,
                                        rd1: (val){
                                          HomePageBloc _bloc = Provider.of(context,listen: false);
                                               _bloc.chooseSort(val).then((value) => Navigator.pop(context));
                                        },
                                        rd2: (val){
                                           HomePageBloc _bloc = Provider.of(context,listen: false);
                                                  _bloc.chooseSort(val).then((value) => Navigator.pop(context));
                                        },
                                        rd3: (val){
                                           HomePageBloc _bloc = Provider.of(context,listen: false);
                                                 _bloc.chooseSort(val).then((value) => Navigator.pop(context));
                                        }
                                         );
                                    },
                                    onChooseStyle: (sortStyle){
                                        BtmSheet(
                                          context,
                                           sortStyle,
                                            title: BTM_SHEET_SORT_TITLE,
                                             rd1Text: BTM_RD_SORT_1,
                                              rd2Text: BTM_RD_SORT_2,
                                               rd3Text: BTM_RD_SORT_3,
                                                rd1: (val){
                                          HomePageBloc _bloc = Provider.of(context,listen: false);
                                               _bloc.listOrGridSort(val).then((value) => Navigator.pop(context));
                                                },
                                                 rd2: (val){
                                          HomePageBloc _bloc = Provider.of(context,listen: false);
                                               _bloc.listOrGridSort(val).then((value) => Navigator.pop(context));
                                                 },
                                                  rd3: (val){
                                          HomePageBloc _bloc = Provider.of(context,listen: false);
                                               _bloc.listOrGridSort(val).then((value) => Navigator.pop(context));
                                                  }
                                                  );
                                    },
                                    TapGenre: (index){
                                      HomePageBloc _bloc = Provider.of(context,listen: false);
                                      _bloc.TapFunction(index);
                                    },
                                    cancelGenre: (){
                                       HomePageBloc _bloc = Provider.of(context,listen: false);
                                      _bloc.TapFunction(null);
                                    },
                                    tabBookInfoBtn: (index){
                             BookOptionBtmSheet(context,index);
                                    },
                                    onClick: (){
                                      navigateToNextScreen(context, BookDetailPage());
                                    },
                                    ),
                                 ),
                              )
                              )
                          :
                         Selector<CreateShelfPageBloc,List<ShelfVO>>(
                            selector: (context,bloc) => bloc.shelfsName,
                            shouldRebuild: (previous,next) => previous != next,
                            builder: (context,shelfs,child) =>
                           ShelvesView(
                             shelfs: shelfs,
                              goToShelf: (index) =>
                              navigateToNextScreen(context,ShelfPage(index: index)),
                            ),
                          )
                           ),
                    )
                ],
              ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> navigateToNextScreen(BuildContext context,Widget pageWidget) {
    return Navigator.push(context,
                       MaterialPageRoute(builder: (BuildContext context) => pageWidget));
  }

  Future<dynamic> BookOptionBtmSheet(BuildContext context,int index) {
    return showModalBottomSheet(
                      context: context,
                          builder: (_){
                                return Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     mainAxisSize: MainAxisSize.min,
                                     children: [
                                       Padding(
                                         padding: const EdgeInsets.all(MARGIN_PRE_SMALL),
                                         child: BookNameAndInfoView(
                                           isSheet: true,
                                           title: bookDummy[index].title ?? "",
                                           content: bookDummy[index].content ?? "",
                                           isInShelf: false,
                                         ),
                                       ),
                                       Divider(),
                                          Column(
                                           mainAxisSize: MainAxisSize.min,
                                           children: [
                                             OptionButtonView(
                                               title: BOOK_OPTION_DOWNLOAD,
                                                icon: Icon(Icons.download_outlined), 
                                                onClick: () => print("todo"),
                                                ),
                                                SizedBox(height: MARGIN_MEDIUM,),
                                                OptionButtonView(
                                               title: BOOK_OPTION_DELETEFROMLIBRARY,
                                                icon: Icon(Icons.delete_outline_rounded), 
                                                onClick: () => print("todo"),
                                                ),
                                                SizedBox(height: MARGIN_MEDIUM,),
                                                OptionButtonView(
                                               title: BOOK_OPTION_MARKASFINISHED,
                                                icon: Icon(Icons.check), 
                                                onClick: () => print("todo"),
                                                ),
                                                SizedBox(height: MARGIN_MEDIUM,),
                                                OptionButtonView(
                                               title: BOOK_OPTION_ADDTOSHELF,
                                                icon: Icon(Icons.add), 
                                                onClick: () => print("todo"),
                                                ),
                                                SizedBox(height: MARGIN_MEDIUM,),
                                                OptionButtonView(
                                               title: BOOK_OPTION_ABOUTTHISBOOK,
                                                icon: Icon(Icons.book), 
                                                onClick: () => print("todo"),
                                                ),
                                                SizedBox(height: MARGIN_MEDIUM,),
                                           ],
                                         ),
                                     ],
                                   );
                                       }
                                       );
  }

  

  Future<dynamic> BtmSheet(BuildContext context, int gpValue,
  {required String title,
  required String rd1Text,
  required String rd2Text,
  required String rd3Text,
    required Function(int) rd1,
    required Function(int) rd2,
    required Function(int) rd3,
  }) {
    return showModalBottomSheet(
           context: context,
             builder: (_){
               return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                        Container(
                       margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2,vertical: MARGIN_SMALL),
                       child: Text(title,
                          style: TextStyle(
                          color: Colors.black,
                            fontSize: TEXT_MEDIUM,
                       fontWeight: FontWeight.w700,
                      ),  
                     ),
                       ),
                 Divider(),
                 Column(
                       mainAxisSize: MainAxisSize.min,
                       children: [
                      ListTile(
                           leading: Radio(
                  groupValue: gpValue,
                     value: 1,
                    onChanged: (int? val){
                    rd1(val ?? 1);
                    }
                    ),
                   title: Text(rd1Text,
                  style: TextStyle(
                    color: Colors.black,
                   fontWeight: FontWeight.w400,
             ),
             ),
            ),
                  ListTile(
           leading: Radio(
                   groupValue: gpValue,
                       value: 2,
        onChanged: (int? val){
             rd2(val ?? 2);
             }
            ),
             title: Text(rd2Text,
                  style: TextStyle(
                      color: Colors.black,
                   fontWeight: FontWeight.w400,
                       ),
                  ),
                 ),
                 ListTile(
               leading: Radio(
                 groupValue: gpValue,
               value: 3,
             onChanged: (int? val){
               rd3(val ?? 3);
                }
              ),
             title: Text(rd3Text,
               style: TextStyle(
                       color: Colors.black,
                       fontWeight: FontWeight.w400,
                     ),
                    ),
                   ),
            ],
          ),
        ],
      );
     }
     );
  }
}



class YourBooksView extends StatelessWidget {

  final List<ChipVO> chips;
  final int gpValue;
  final int sortStyle;
  final Function(int) ChooseTab;
  final Function(int) onChooseStyle;
  final Function(int) TapGenre;
  final Function cancelGenre;
  final Function(int) tabBookInfoBtn;
  final Function onClick;

  YourBooksView({
    required this.chips,
    required this.gpValue,
    required this.sortStyle,
    required this.ChooseTab,
    required this.onChooseStyle,
    required this.TapGenre,
    required this.cancelGenre,
    required this.tabBookInfoBtn,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return 
        ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
        children: [
          Container(
            margin: EdgeInsets.only(left: MARGIN_PRE_SMALL,top: MARGIN_PRE_SMALL),
            width: double.infinity,
            height: YOUR_BOOK_VIEW_GENRE_CONTAINER_HEIGHT,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                GestureDetector(
                  onTap: (){
                    cancelGenre();
                  },
                  child: Container(
                    width: GENRE_ALL_CANCEL_BTN_CONTAINER_WIDTH,
                    height: GENRE_ALL_CANCEL_BTN_CONTAINER_HEIGHT,
                  margin: EdgeInsets.only(left: MARGIN_PRE_SMALL,top: MARGIN_PRE_SMALL,bottom: MARGIN_PRE_SMALL),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(MARGIN_FOR_CANCEL_GENRE),
                      border: Border.all(color: Colors.black),
                    ),
                    child:Center(child: FaIcon(FontAwesomeIcons.xmark)),
                  ),
                ),
                ...chips.mapIndexed((index,type){
                  return ChipView(
                    index: index,
                    type: type,
                    TapGenre: (index) => TapGenre(index),
                  );
                }),
              ],
            ),
          ),
          SizedBox(height: MARGIN_SMALL,),
          Container(
        padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
            child: Row(
              children: [
                OptionButtonView(
                  title: (gpValue == 1) ? SORT_BY_RECENT : (gpValue == 2) ? SORT_BY_AUTHOR : SORT_BY_TITLE,
                  icon: Icon(Icons.filter_list,size: MARGIN_SIZE_FOR_ICON,),
                  onClick: (){
                     ChooseTab(gpValue);
                  },
                ),
                Spacer(),
                OptionButtonView(
                  title: (sortStyle == 1) ? LIST_STYLE : (sortStyle == 2) ? GRID_MEDIUM : GRID_LARGE,
                   icon: (sortStyle == 1) ? Icon(Icons.list_alt,size: MARGIN_SIZE_FOR_ICON,) : Icon(Icons.view_list_outlined,size: 22,),
                     onClick: ()=> onChooseStyle(sortStyle),
                     ),
              ],
            ),
          ),
          SizedBox(height: MARGIN_SMALL,),
            Container(
              child: (sortStyle == 1) ?
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: bookDummy.length,
                  itemBuilder: (BuildContext context,int index){
                    return BookInLibListView(
                        index: index,
                        tabBookInfoBtn: (index) => tabBookInfoBtn(index),
                        onClick: ()=> onClick(),
                        books: bookDummy[index],
                    );
                  }
                  )
               : GridView.builder(
                 physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: (sortStyle == 2) ? 2 : 3,
                  ),
                  itemCount:31,
                 itemBuilder: (BuildContext context,int index){
                   print("sort No =============> $sortStyle");
                   return BookInLibGridView(
                     styleNo: sortStyle,
                     onClick: ()=> onClick(),
                   );
                 }
                 ),
            ),
          ],
      );
  }
}

class BookInLibListView extends StatelessWidget {

  final int index;
  final BookVO books;
  final Function(int) tabBookInfoBtn;
  final Function onClick;

  BookInLibListView({
    required this.index,
    required this.tabBookInfoBtn,
    required this.onClick,
    required this.books,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onClick();
      },
      child: Container(
        margin: EdgeInsets.only(bottom: MARGIN_SMALL),
        child: Row(
          children: [
            BookNameAndInfoView(
              isSheet: false,
              title: books.title ?? "",
             content: books.content ?? "",
             isInShelf: false,
            ),
            Spacer(),
            CheckIconView(),
            EllipisIconView(
              color: Colors.black,
              tabBookInfoBtn: () => tabBookInfoBtn(index),
            ),
          ],
        ),
      ),
    );
  }
}



class BookInLibGridView extends StatelessWidget {

  final int styleNo;
  final Function onClick;

  BookInLibGridView({
    required this.styleNo,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_SMALL),
      child: BookView(
        name: "Sin Eater Sin Eater Sin Eater Sin Eater Sin Eater Sin Eater Sin Eater",
        bookWidth: MediaQuery.of(context).size.width * 0.32,
        bookHeight: (styleNo == 2) ? MediaQuery.of(context).size.height / 5 : MediaQuery.of(context).size.height / 8.6,
        SizeOfName: (styleNo == 2) ? TEXT_SMALL :TEXT_SMALL,
        isVisible: false,
        onClick: (){
            onClick();
        },
        ),
    );
  }
}

class ChipView extends StatelessWidget {

  final int index;
  final ChipVO type;
  final Function(int) TapGenre;

  ChipView({required this.index,required this.type,required this.TapGenre});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        TapGenre(index);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: MARGIN_PRE_SMALL),
        child: Chip(
          label: Text(type.title ?? "",
          style: TextStyle(
            color: (type.isSelected == true) ? Colors.white : Colors.black,
          ),
          ),
          backgroundColor: (type.isSelected == true) ? BUTTON_TEXT_COLOR : Colors.transparent,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: (type.isSelected==true) ? Colors.transparent :  Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(MARGIN_SMALL_1X)),
            ),
        ),
      ),
    );
  }
}




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
      padding: EdgeInsets.only(top: MARGIN_SMALL),
      child: 
      ListView.builder(
      shrinkWrap: true,
       physics: NeverScrollableScrollPhysics(),
       itemCount: shelfs.length,
       itemBuilder: (BuildContext context,int index){
         return ShelfView(
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
        FaIcon(FontAwesomeIcons.pen,color: Colors.white,),
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
                isSheet: false,
                title: title,
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
          Divider(color: Colors.grey.withOpacity(0.8),),
          SizedBox(height: MARGIN_SMALL_1X,),
        ],
      ),
    );
  }
}

