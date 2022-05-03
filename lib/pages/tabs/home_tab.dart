import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:the_library_app/blocs/home_page_bloc.dart';
import 'package:the_library_app/data/vos/overview/book_list_vo.dart';
import 'package:the_library_app/data/vos/overview/book_vo.dart';
import 'package:the_library_app/data/vos/show_more/show_more_result_vo.dart';
import 'package:the_library_app/dummy/dummy_data.dart';
import 'package:the_library_app/pages/book_detail_page.dart';
import 'package:the_library_app/pages/book_list_in_grid.dart';
import 'package:the_library_app/resources/colors.dart';
import 'package:the_library_app/resources/constants.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/view_items/book_list_title_view.dart';
import 'package:the_library_app/view_items/book_name_and_info_view.dart';
import 'package:the_library_app/view_items/option_button_view.dart';
import 'package:the_library_app/widgets/book_list_title_and_serials_view.dart';
import 'package:the_library_app/widgets/book_view_for_carousel.dart';

class HomeTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MARGIN_MEDIUM_2),
      child: ListView(
        children: [
          SizedBox(height: MARGIN_OVER_EXTRA_2,),
         CarouselBookView(
           bookListForCarousel: bookListForCarousel,
           menuFun: (index){
             BookOptionBtmSheet(context, index);
           },
         ),
         SizedBox(height: MARGIN_FOR_CAROUSEL,),
         DefaultTabController(
           length: 2,
            child: Selector<HomePageBloc,int>(
              selector: (context,bloc) => bloc.tabIndex,
              shouldRebuild: (previous,next) => previous != next,
              builder: (context,tabIndex,child) =>
               TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: CREATE_BUTTON_COLOR,
                unselectedLabelColor: BOOK_EXTRA_DATA_CONTENT_COLOR,
                onTap: (index){
                  HomePageBloc _bloc = Provider.of(context,listen: false);
                  _bloc.userChooseBookTypeIndex(index);
                },
                tabs: [
                  Tab(child: Text(TAB_EBOOK,
                  style: TextStyle(
                    fontSize: TEXT_SMALL_1X,
                  ),
                  ),),
                  Tab(child: Text(TAB_AUDIOBOOK,
                  style: TextStyle(
                    fontSize: TEXT_SMALL_1X,
                  ),
                  ),),
              ],),
            ),
            ),
            SizedBox(height: MARGIN_MEDIUM_2,),
            Selector<HomePageBloc,int>(
              selector: (context,bloc) => bloc.tabIndex,
              shouldRebuild: (pre,next) => pre != next,
              builder: (context,tabIndex,child) =>
               Selector<HomePageBloc,List<BookListVO>>(
                 selector: (context,bloc) => bloc.bookLists ?? [],
                 shouldRebuild: (previous,next) => previous != next,
                 builder: (context,bookList,child) =>
                  Container(
                  width: MediaQuery.of(context).size.width,
                  child: (tabIndex==0) ?
                   EbooksView(
                     bookList: bookList,
                     onClick: (userSelectBook) =>
                        navigateToNextScreen(context,BookDetailPage(
                          userSelectBook: userSelectBook,
                          userSelectBookFromShowMore: ShowMoreResultVO.empty(),
                          isOverView: true,
                          )),
                      goToNext: (index){
                        HomePageBloc _bloc = Provider.of(context,listen: false);
                        _bloc.clickForMoreView(index).then((value){
                           navigateToNextScreen(context,BookListInGrid(
                          searchText: "",
                          isFromSearchPage: false,
                        ));
                        });
                      },
                   ) 
                   : 
                   AudioBooksView(
                     onClick: (userSelectBookIndex) =>
                        navigateToNextScreen(context,BookDetailPage(
                          userSelectBook: BookVO.empty(),
                          userSelectBookFromShowMore: ShowMoreResultVO.empty(),
                          isOverView: false,
                          )),
                        goToNext: (){
                        navigateToNextScreen(context,BookListInGrid(
                          searchText: "Recent Price Drops",
                          isFromSearchPage: false,
                        ));
                      },
                   ),
                             ),
               ),
            )
        ],
      ),
    );
  }

    navigateToNextScreen(BuildContext context,Widget page) {
    return Navigator.push(context,
         MaterialPageRoute(builder: (BuildContext context) => page));
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
                                         padding: const EdgeInsets.symmetric(vertical: MARGIN_PRE_SMALL,horizontal: MARGIN_MEDIUM_2),
                                         child: BookNameAndInfoView(
                                           isSheet: true,
                                           title: bookDummy[index].title ?? "",
                                           content: bookDummy[index].content ?? "",
                                           isInShelf: false,
                                         ),
                                       ),
                                       DivideLineView(thick: 1,),
                                          Column(
                                           mainAxisSize: MainAxisSize.min,
                                           children: [
                                             OptionButtonView(
                                               title: BOOK_OPTION_DOWNLOAD,
                                                icon: Icon(Icons.download_outlined,size: BTM_SHEET_ICON_SIZE,color: BTM_SHEET_OPTION_ICON_COLOR,), 
                                                onClick: () => print("todo"),
                                                isInSheet: true,
                                                ),
                                                SizedBox(height: MARGIN_MEDIUM_2,),
                                                OptionButtonView(
                                                  isInSheet: true,
                                               title: BOOK_OPTION_DELETEFROMLIBRARY,
                                                icon: Icon(Icons.delete_outline_rounded,size: BTM_SHEET_ICON_SIZE,color: BTM_SHEET_OPTION_ICON_COLOR,), 
                                                onClick: () => print("todo"),
                                                ),
                                                SizedBox(height: MARGIN_MEDIUM_2,),
                                                OptionButtonView(
                                                  isInSheet: true,
                                               title: BOOK_OPTION_MARKASFINISHED,
                                                icon: Icon(Icons.check,size: BTM_SHEET_ICON_SIZE,color: BTM_SHEET_OPTION_ICON_COLOR,), 
                                                onClick: () => print("todo"),
                                                ),
                                                SizedBox(height: MARGIN_MEDIUM_2,),
                                                OptionButtonView(
                                                  isInSheet: true,
                                               title: BOOK_OPTION_ADDTOSHELF,
                                                icon: Icon(Icons.add,size: BTM_SHEET_ICON_SIZE,color: BTM_SHEET_OPTION_ICON_COLOR,), 
                                                onClick: () => print("todo"),
                                                ),
                                                SizedBox(height: MARGIN_MEDIUM_2,),
                                                OptionButtonView(
                                                  isInSheet: true,
                                               title: BOOK_OPTION_ABOUTTHISBOOK,
                                                icon: Icon(Icons.book,size: BTM_SHEET_ICON_SIZE,color: BTM_SHEET_OPTION_ICON_COLOR,), 
                                                onClick: () => print("todo"),
                                                ),
                                                SizedBox(height: MARGIN_MEDIUM_2,),
                                           ],
                                         ),
                                     ],
                                   );
                                       }
                                       );
  }
}

class CarouselBookView extends StatelessWidget {
  
  final List<Widget> bookListForCarousel;
  final Function(int) menuFun;

  CarouselBookView({
    required this.bookListForCarousel,
    required this.menuFun,
    });

  @override
  Widget build(BuildContext context) {
    // return CarouselSlider(
    //    items: bookListForCarousel,
    //    options: CarouselOptions(
    //       height: CAROUSEL_HEIGHT,
    //       aspectRatio: 16/9,
    //       viewportFraction: 0.6,
    //       initialPage: 0,
    //       enableInfiniteScroll: false,
    //       reverse: false,
    //       autoPlay: false,
    //       enlargeCenterPage: true,
    //       scrollDirection: Axis.horizontal,
    //    ),
    //  );
    return CarouselSlider.builder(
        itemCount: bookListCarouselImage.length,
        itemBuilder: (BuildContext context,int index,int pageViewIndex){
          return BookViewForCarousel(
    image: bookListCarouselImage[index],
    isSample: false,
    menuFun: (){
      menuFun(index);
    },
  );
        },
       options: CarouselOptions(
          height: CAROUSEL_HEIGHT,
          aspectRatio: 16/9,
          viewportFraction: 0.6,
          initialPage: 0,
          enableInfiniteScroll: false,
          reverse: false,
          autoPlay: false,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
       ),
    );
  }
}

class EbooksView extends StatelessWidget {

  final List<BookListVO> bookList;
  final Function(BookVO) onClick;
  final Function(int) goToNext;

  EbooksView({
    required this.bookList,
    required this.onClick,
    required this.goToNext,
  });

  @override
  Widget build(BuildContext context) {
    // return Column(
    //   mainAxisSize: MainAxisSize.min,
    //   children: [
    //     BookListTileAndSerialsView(
    //       title: EBOOK_LIST_TITLE_1,
    //       onClick: () => onClick(),
    //       goToNext: (){
    //         goToNext();
    //       },
    //     ),
    //     BookListTileAndSerialsView(
    //       title: EBOOK_LIST_TITLE_2,
    //      onClick: () => onClick(),
    //      goToNext: (){
    //         goToNext();
    //       },
    //     ),
    //     BookListTileAndSerialsView(
    //       title: EBOOK_LIST_TITLE_3,
    //       onClick: () => onClick(),
    //       goToNext: (){
    //         goToNext();
    //       },
    //     ),
    //   ],
    // );
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: bookList.length,
      itemBuilder: (BuildContext context,int indexO){
        return BookListTileAndSerialsView(
          title: bookList[indexO].listName ?? "",
          books: bookList[indexO].books ?? [],
           onClick: (userSelectBookIndex){
             onClick(bookList[indexO].books?[userSelectBookIndex] ?? BookVO.empty());
           },
            goToNext:()=> goToNext(indexO),
            );
      },
    );
  }

 

}

class AudioBooksView extends StatelessWidget {
  final Function(int) onClick;
  final Function goToNext;

  AudioBooksView({
    required this.onClick,
    required this.goToNext,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
       mainAxisSize: MainAxisSize.min,
      children: [
        BookListTileAndSerialsView(
          books: [],
          title: AUDIOBOOK_LIST_TITLE_1,
          onClick: (userSelectBookIndex) => onClick(userSelectBookIndex),
          goToNext: (){
            goToNext();
          },
          ),
          BookListTileAndSerialsView(
            books: [],
          title: AUDIOBOOK_LIST_TITLE_2,
          onClick: (userSelectBookIndex) => onClick(userSelectBookIndex),
          goToNext: (){
            goToNext();
          },
          ),
          BookListTileAndSerialsView(
            books: [],
          title: AUDIOBOOK_LIST_TITLE_3,
          onClick: (userSelectBookIndex) => onClick(userSelectBookIndex),
          goToNext: (){
            goToNext();
          },
          ),
      ],
    );
  }

     
}


