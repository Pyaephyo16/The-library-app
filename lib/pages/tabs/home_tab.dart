import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:the_library_app/blocs/book_detail_bloc.dart';
import 'package:the_library_app/blocs/home_tab_bloc.dart';
import 'package:the_library_app/blocs/show_more_bloc.dart';
import 'package:the_library_app/blocs/library_tab_bloc.dart';
import 'package:the_library_app/data/vos/overview/book_list_vo.dart';
import 'package:the_library_app/data/vos/overview/book_vo.dart';
import 'package:the_library_app/data/vos/overview/result_vo.dart';
import 'package:the_library_app/data/vos/show_more/show_more_result_vo.dart';
import 'package:the_library_app/dummy/dummy_data.dart';
import 'package:the_library_app/pages/Views/audiobook_view.dart';
import 'package:the_library_app/pages/Views/ebooks_view.dart';
import 'package:the_library_app/pages/add_to_shelf_page.dart';
import 'package:the_library_app/pages/book_detail_page.dart';
import 'package:the_library_app/pages/book_list_in_grid.dart';
import 'package:the_library_app/resources/colors.dart';
import 'package:the_library_app/resources/constants.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/view_items/book_list_title_view.dart';
import 'package:the_library_app/view_items/book_name_and_info_view.dart';
import 'package:the_library_app/view_items/divide_line_view.dart';
import 'package:the_library_app/view_items/option_button_view.dart';
import 'package:the_library_app/widgets/book_list_title_and_serials_view.dart';
import 'package:the_library_app/widgets/book_view_for_carousel.dart';

class HomeTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return
     ChangeNotifierProvider<HomeTabBloc>.value(
      value: HomeTabBloc(),
      // ChangeNotifierProvider<HomePageBloc>(
      //   create: (context) => HomePageBloc(),
      child: Container(
          color: Colors.white,
          child: ListView(
            children: [
              SizedBox(height: MARGIN_OVER),
             Selector<HomeTabBloc,List<BookVO>>(
               selector: (context,bloc) => bloc.listForCarousel ?? [],
               shouldRebuild: (previous,next) => previous != next,
               builder: (context,listForCarousel,child) =>
               (listForCarousel.isEmpty || listForCarousel == null) 
               ?
               NoBookViewInCarousel(
                 title: NO_BOOKS_TEXT,
               )
               :
                CarouselBookView(
                  key: Key("CarouselKey"),
                 bookListForCarousel: listForCarousel.reversed.toList(),
                 menuFun: (book){
                   BookOptionBtmSheet(context,book);
                 },
               ),
             ),
              // SizedBox(height: MARGIN_FOR_CAROUSEL,),
              // ElevatedButton(
              //   onPressed: (){
              //     HomePageBloc _bloc = Provider.of(context,listen: false);
              //     _bloc.deleteFromCarouselBook();
              //   },
              //  child: Text("Delete From Carousel"),
              //  ),
             SizedBox(height: MARGIN_FOR_CAROUSEL,),
             DefaultTabController(
               length: 2,
                child: Selector<HomeTabBloc,int>(
                  selector: (context,bloc) => bloc.tabIndex,
                  shouldRebuild: (previous,next) => previous != next,
                  builder: (context,tabIndex,child) =>
                   TabBar(
                     key: Key("HometabTabBar"),
                    indicatorSize: TabBarIndicatorSize.label,
                    labelColor: CREATE_BUTTON_COLOR,
                    unselectedLabelColor: BOOK_EXTRA_DATA_CONTENT_COLOR,
                    onTap: (index){
                      HomeTabBloc _bloc = Provider.of(context,listen: false);
                      _bloc.userChooseBookTypeIndex(index);
                    },
                    tabs: [
                      Tab(
                        key: Key("EbookKey"),
                        child: Text(TAB_EBOOK,
                      style: TextStyle(
                        fontSize: TEXT_SMALL_1X,
                      ),
                      ),),
                      Tab(
                        key: Key("AudiobookKey"),
                        child: Text(TAB_AUDIOBOOK,
                      style: TextStyle(
                        fontSize: TEXT_SMALL_1X,
                      ),
                      ),),
                  ],),
                ),
                ),
                SizedBox(height: MARGIN_MEDIUM_2,),
                Selector<HomeTabBloc,int>(
                  selector: (context,bloc) => bloc.tabIndex,
                  shouldRebuild: (pre,next) => pre != next,
                  builder: (context,tabIndex,child) =>
                   Selector<HomeTabBloc,ResultVO>(
                     selector: (context,bloc) => bloc.results ?? ResultVO.empty(),
                     shouldRebuild: (previous,next) => previous != next,
                     builder: (context,result,child) =>
                      Selector<HomeTabBloc,List<BookVO>>(
               selector: (context,bloc) => bloc.listForCarousel ?? [],
               shouldRebuild: (previous,next) => previous != next,
               builder: (context,listForCarousel,child) =>
                         Container(
                        width: MediaQuery.of(context).size.width,
                        child: (tabIndex==0) ?
                         EbooksView(
                           bookList: result.lists ?? [],
                           onClick: (book){
                            HomeTabBloc bloc = Provider.of(context,listen: false);
                            bloc.saveBookToCarousel(book).then((value) => 
                            navigateToNextScreen(context, BookDetailPage( book: book,)));
                            
                           },
                            goToNext: (index){
                              navigateToNextScreen(context,BookListInGrid(
                                index: index,
                                result: result,
                              ));
                            },
                         ) 
                         : 
                         AudioBooksView(
                           onClick: (userSelectBookIndex) =>
                              navigateToNextScreen(context,BookDetailPage(
                                book: BookVO.empty(),
                              )),
                              goToNext: (){
                              navigateToNextScreen(context,BookListInGrid(
                                index: 0,
                                result: ResultVO.empty(),
                              ));
                            },
                         ),
                                   ),
                      ),
                   ),
                )
            ],
          ),
        ),
    );
  }

    navigateToNextScreen(BuildContext context,Widget page) {
    return Navigator.push(context,
         MaterialPageRoute(builder: (BuildContext context) => page));
  }

    Future<dynamic> BookOptionBtmSheet(BuildContext BtmOptionSheetcontext,BookVO book) {
    return showModalBottomSheet(
                      context: BtmOptionSheetcontext,
                          builder: (_){
                                return Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     mainAxisSize: MainAxisSize.min,
                                     children: [
                                       Padding(
                                         padding: const EdgeInsets.symmetric(vertical: MARGIN_PRE_SMALL,horizontal: MARGIN_MEDIUM_2),
                                         child: BookNameAndInfoView(
                                           onClick: (){},
                                           isSheet: true,
                                           image: book.bookImage ?? book.searchResult?.volumeInfo?.imageLinks?.thumbnail ?? IMAGE_CONSTANT_ONLINE,
                                           title: book.title ?? book.searchResult?.volumeInfo?.title ?? book.bookDetails?.first.title ?? "",
                                           content: book.author ?? book.searchResult?.volumeInfo?.authors?.first ?? book.bookDetails?.first.author ?? "",
                                           isInShelf: false,
                                         ),
                                       ),
                                       DivideLineView(thick: 1,),
                                          Column(
                                           mainAxisSize: MainAxisSize.min,
                                           children: [
                                             OptionButtonView(
                                               key: Key("homeTabOption1"),
                                               title: BOOK_OPTION_DOWNLOAD,
                                                icon: Icon(Icons.download_outlined,size: BTM_SHEET_ICON_SIZE,color: BTM_SHEET_OPTION_ICON_COLOR,), 
                                                onClick: () => print("todo"),
                                                isInSheet: true,
                                                ),
                                                SizedBox(height: MARGIN_MEDIUM_2,),
                                                OptionButtonView(
                                                  key: Key("homeTabOption2"),
                                                  isInSheet: true,
                                               title: BOOK_OPTION_DELETEFROMLIBRARY,
                                                icon: Icon(Icons.delete_outline_rounded,size: BTM_SHEET_ICON_SIZE,color: BTM_SHEET_OPTION_ICON_COLOR,), 
                                                onClick: () => print("todo"),
                                                ),
                                                SizedBox(height: MARGIN_MEDIUM_2,),
                                                OptionButtonView(
                                                  key: Key("homeTabOption3"),
                                                  isInSheet: true,
                                               title: BOOK_OPTION_MARKASFINISHED,
                                                icon: Icon(Icons.check,size: BTM_SHEET_ICON_SIZE,color: BTM_SHEET_OPTION_ICON_COLOR,), 
                                                onClick: () => print("todo"),
                                                ),
                                                SizedBox(height: MARGIN_MEDIUM_2,),
                                                OptionButtonView(
                                                   key: Key("homeTabOption4"),
                                                  isInSheet: true,
                                               title: BOOK_OPTION_ADDTOSHELF,
                                                icon: Icon(Icons.add,size: BTM_SHEET_ICON_SIZE,color: BTM_SHEET_OPTION_ICON_COLOR,), 
                                                onClick: () => navigateToNextScreen(BtmOptionSheetcontext, AddToShelfPage(userSelectBook: book)),
                                                ),
                                                SizedBox(height: MARGIN_MEDIUM_2,),
                                                OptionButtonView(
                                                   key: Key("homeTabOption5"),
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

class NoBookViewInCarousel extends StatelessWidget {
  const NoBookViewInCarousel({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title,
      style: TextStyle(
        color: CREATE_BUTTON_COLOR,
        fontSize: TEXT_MEDIUM,
      ),
      ),);
  }
}

class CarouselBookView extends StatelessWidget {
  
  final List<BookVO> bookListForCarousel;
  final Function(BookVO) menuFun;
  final Key key;

  CarouselBookView({
    required this.key,
    required this.bookListForCarousel,
    required this.menuFun,
    });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: bookListForCarousel.length,
        itemBuilder: (BuildContext context,int index,int pageViewIndex){
          return BookViewForCarousel(
    image: bookListForCarousel[index].bookImage ?? bookListForCarousel[index].searchResult?.volumeInfo?.imageLinks?.thumbnail  ?? IMAGE_CONSTANT_ONLINE,
    isSample: false,
    menuFun: (){
      menuFun(bookListForCarousel[index]);
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




