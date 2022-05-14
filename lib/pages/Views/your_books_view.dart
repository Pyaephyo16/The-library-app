import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:the_library_app/blocs/home_tab_bloc.dart';
import 'package:the_library_app/data/vos/chip_vo.dart';
import 'package:the_library_app/data/vos/overview/book_vo.dart';
import 'package:the_library_app/dummy/dummy_data.dart';
import 'package:the_library_app/pages/tabs/library_tab.dart';
import 'package:the_library_app/resources/colors.dart';
import 'package:the_library_app/resources/constants.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/view_items/book_name_and_info_view.dart';
import 'package:the_library_app/view_items/book_view.dart';
import 'package:the_library_app/view_items/check_icon_view.dart';
import 'package:the_library_app/view_items/ellipis_icon_view.dart';
import 'package:the_library_app/view_items/option_button_view.dart';

class YourBooksView extends StatelessWidget {

  final Key key;
  final List<ChipVO> chips;
  final List<String> currentBox;
  final List<BookVO> listForCarousel;
  final int gpValue;
  final int sortStyle;
  final Function(int) ChooseTab;
  final Function(int) onChooseStyle;
  final Function(int) TapGenre;
  final Function cancelGenre;
  final Function(int,BookVO) tabBookInfoBtn;
  final Function(BookVO) onClick;
  final Function(int,BookVO) sheetFun;

  YourBooksView({
    required this.key,
    required this.chips,
    required this.currentBox,
    required this.gpValue,
    required this.listForCarousel,
    required this.sortStyle,
    required this.ChooseTab,
    required this.onChooseStyle,
    required this.TapGenre,
    required this.cancelGenre,
    required this.tabBookInfoBtn,
    required this.onClick,
    required this.sheetFun,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
        children: [
        SizedBox(height: MARGIN_SMALL_1X,),
          ChipSection(
            cancelGenre: cancelGenre,
             chips: chips, 
             currentBox: currentBox,
             TapGenre: TapGenre,
             ),
        SizedBox(height: MARGIN_SMALL_1X,),
          SortBySection(
            gpValue: gpValue,
             ChooseTab: ChooseTab,
              sortStyle: sortStyle,
               onChooseStyle: onChooseStyle
               ),
         SizedBox(height: MARGIN_MEDIUM_2,),
            ListAndGridShowSection(
              listForCarousel: (gpValue == 1 ) ? listForCarousel.reversed.toList() : listForCarousel,
              sortStyle: sortStyle,
               tabBookInfoBtn: (index,book) => tabBookInfoBtn(index,book),
               sheetFun: (index,book){
                 sheetFun(index,book);
               },
                onClick:(book) => onClick(book),
                ),
          ],
      );
  }
}


class SortBySection extends StatelessWidget {
  const SortBySection({
    required this.gpValue,
    required this.ChooseTab,
    required this.sortStyle,
    required this.onChooseStyle,
  });

  final int gpValue;
  final Function(int p1) ChooseTab;
  final int sortStyle;
  final Function(int p1) onChooseStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      child: Row(
        children: [
          OptionButtonView(
            key: Key("YourBooksSortByKey"),
            isInSheet: false,
            title: (gpValue == 1) ? SORT_BY_RECENT : (gpValue == 2) ? SORT_BY_AUTHOR : SORT_BY_TITLE,
            icon: Icon(Icons.filter_list,size: MARGIN_MEDIUM_3,color: DETAIL_TEXT_COLOR,),
            onClick: (){
               ChooseTab(gpValue);
            },
          ),
          Spacer(),
          OptionButtonView(
            key: Key("YourBoksListOrGrid"),
            isInSheet: false,
            title: (sortStyle == 1) ? LIST_STYLE : (sortStyle == 2) ? GRID_MEDIUM : GRID_LARGE,
             icon: (sortStyle == 1) ? Icon(Icons.list_alt,size: MARGIN_MEDIUM_3,color: DETAIL_TEXT_COLOR,) : Icon(Icons.view_list_outlined,size: 24,color: DETAIL_TEXT_COLOR,),
               onClick: (){
                  onChooseStyle(sortStyle);
               },
               ),
        ],
      ),
    );
  }
}

class ChipSection extends StatelessWidget {
  const ChipSection({
    required this.cancelGenre,
    required this.chips,
    required this.currentBox,
    required this.TapGenre,
  });

  final Function cancelGenre;
  final List<ChipVO> chips;
  final List<String> currentBox;
  final Function(int p1) TapGenre;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: MARGIN_PRE_SMALL,),
      width: double.infinity,
      height: YOUR_BOOK_VIEW_GENRE_CONTAINER_HEIGHT,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
        (currentBox.length != 0) ?  CancelGenreButton(key: Key("YourBooksCancelAllChips"),cancelGenre: cancelGenre) : Container(),
          ...chips.mapIndexed((index,type){
            return 
            ChipView(
              key: Key("YourBooksChip$index"),
              index: index,
              type: type,
              TapGenre: (index) => TapGenre(index),
            );
          }),
        ],
      ),
    );
  }
}

class CancelGenreButton extends StatelessWidget {
  const CancelGenreButton({
    required this.key,
    required this.cancelGenre,
  });

  final Key key;
  final Function cancelGenre;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        cancelGenre();
      },
      child: Container(
        width: GENRE_ALL_CANCEL_BTN_CONTAINER_WIDTH,
        height: GENRE_ALL_CANCEL_BTN_CONTAINER_HEIGHT,
      margin: EdgeInsets.only(left: MARGIN_PRE_SMALL,top: MARGIN_PRE_SMALL,bottom: MARGIN_PRE_SMALL),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(MARGIN_FOR_CANCEL_GENRE),
          border: Border.all(color: BTM_SHEET_OPTION_ICON_COLOR),
        ),
        child:Center(child: FaIcon(FontAwesomeIcons.xmark,color: BTM_SHEET_OPTION_ICON_COLOR,size: MARGIN_MEDIUM_2X,)),
      ),
    );
  }
}

class ChipView extends StatelessWidget {

  final Key key;
  final int index;
  final ChipVO type;
  final Function(int) TapGenre;

  ChipView({
    required this.key,
    required this.index,
    required this.type,
    required this.TapGenre,
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        TapGenre(index);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: MARGIN_PRE_SMALL),
        child: Chip(
          label: Text(type.category ?? "",
          style: TextStyle(
            color: (type.isSelected == true) ? Colors.white : BTM_SHEET_OPTION_ICON_COLOR,
          ),
          ),
          backgroundColor: (type.isSelected == true) ? BUTTON_TEXT_COLOR : Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: (type.isSelected==true) ? Colors.transparent :  BTM_SHEET_OPTION_ICON_COLOR),
            borderRadius: BorderRadius.all(Radius.circular(MARGIN_MEDIUM_2X)),
            ),
        ),
      ),
    );
  }
}

class ListAndGridShowSection extends StatelessWidget {
  const ListAndGridShowSection({
    required this.sortStyle,
    required this.listForCarousel,
    required this.tabBookInfoBtn,
    required this.onClick,
    required this.sheetFun,
  });

  final int sortStyle;
  final List<BookVO> listForCarousel;
  final Function(int,BookVO) tabBookInfoBtn;
  final Function(BookVO) onClick;
  final Function(int,BookVO) sheetFun;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: (sortStyle == 1) ?
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: listForCarousel.length,
          itemBuilder: (BuildContext context,int index){
            return BookInLibListView(
                index: index,
                tabBookInfoBtn: (index,book) => tabBookInfoBtn(index,book),
                onClick: (book){
                  onClick(book);
                  print("book check ===========> $book");
                },
                books: listForCarousel[index],
            );
          }
          )
       : 
       GridView.builder(
         physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: (sortStyle == 2) ? 0.78 : 0.5,
          crossAxisCount: (sortStyle == 2) ? 2 : 3,
          ),
          itemCount: listForCarousel.length,
         itemBuilder: (BuildContext context,int index){
           print("sort No =============> $sortStyle");
           return BookInLibGridView(
             styleNo: sortStyle,
             key: Key("bookInLibGrid$index"),
             books: listForCarousel[index],
             sheetFun: (book){
               sheetFun(index,book);
             },
             onClick: (){
                onClick(listForCarousel[index]);
                 print("book check ===========> ${listForCarousel[index]}");
             },
           );
         }
         ),
    );
  }
}






class BookInLibListView extends StatelessWidget {

  final int index;
  final BookVO books;
  final Function(int,BookVO) tabBookInfoBtn;
  final Function(BookVO) onClick;

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
        onClick(books);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: MARGIN_MEDIUM,left: MARGIN_SMALL,right: MARGIN_SMALL),
        child: Row(
          children: [
            BookNameAndInfoView(
              onClick: (){
                onClick(books);
              },
              isSheet: false,
              image: books.bookImage ?? books.searchResult?.volumeInfo?.imageLinks?.thumbnail ?? IMAGE_CONSTANT_ONLINE,
              title: books.title ?? books.searchResult?.volumeInfo?.title ?? books.bookDetails?.first.title ?? "",
             content: books.author ?? books.searchResult?.volumeInfo?.authors?.first ?? books.bookDetails?.first.author ?? "",
             isInShelf: false,
            ),
            Spacer(),
            CheckIconView(
              isInShelvesIcon: true,
            ),
            EllipisIconView(
              key: Key("YourBooksListInLibEllipisKey$index"),
              color: BTM_SHEET_OPTION_ICON_COLOR,
              tabBookInfoBtn: () => tabBookInfoBtn(index,books),
            ),
          ],
        ),
      ),
    );
  }
}



class BookInLibGridView extends StatelessWidget {

  final int styleNo;
  final BookVO books;
  final Function onClick;
  final Key key;
  final Function(BookVO) sheetFun;

  BookInLibGridView({
    required this.styleNo,
    required this.key,
    required this.books,
    required this.onClick,
    required this.sheetFun,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_SMALL),
      child: Container(
        child: BookView(
          key: key,
          isInShelf: true,
          sheetFun: (){
            sheetFun(books);
          },
          isShowPrice: false,
          name: books.title ?? books.searchResult?.volumeInfo?.title ?? books.bookDetails?.first.title ?? "",
          price: books.price ?? books.bookDetails?.first.price ?? "",
          author: books.author ?? books.searchResult?.volumeInfo?.authors?.first ?? books.bookDetails?.first.author ?? "",
          image: books.bookImage ?? books.searchResult?.volumeInfo?.imageLinks?.thumbnail ?? IMAGE_CONSTANT_ONLINE,
          bookWidth: MediaQuery.of(context).size.width * 0.32,
          bookHeight: (styleNo == 2) ? MediaQuery.of(context).size.height / 4.6 : MediaQuery.of(context).size.height /5,
         
          SizeOfName: (styleNo == 2) ? TEXT_SMALL_1X :TEXT_SMALL_1X,
          isVisible: true,
          onClick: (){
              onClick();
          },
          ),
      ),
    );
  }
}