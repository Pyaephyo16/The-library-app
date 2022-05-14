import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_library_app/blocs/book_detail_bloc.dart';
import 'package:the_library_app/blocs/home_tab_bloc.dart';
import 'package:the_library_app/blocs/search_page_bloc.dart';
import 'package:the_library_app/blocs/show_more_bloc.dart';
import 'package:the_library_app/blocs/library_tab_bloc.dart';
import 'package:the_library_app/data/vos/overview/book_list_vo.dart';
import 'package:the_library_app/data/vos/overview/book_vo.dart';
import 'package:the_library_app/data/vos/overview/result_vo.dart';
import 'package:the_library_app/data/vos/show_more/show_more_result_vo.dart';
import 'package:the_library_app/dummy/dummy_data.dart';
import 'package:the_library_app/pages/book_detail_page.dart';
import 'package:the_library_app/pages/search_page.dart';
import 'package:the_library_app/resources/colors.dart';
import 'package:the_library_app/resources/constants.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/view_items/book_list_title_view.dart';
import 'package:the_library_app/view_items/book_view.dart';
import 'package:the_library_app/view_items/divide_line_view.dart';
import 'package:the_library_app/widgets/show_more_book_section.dart';

class BookListInGrid extends StatelessWidget {

 final int index;
 final ResultVO result;

  BookListInGrid({
    required this.index,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return 
    ChangeNotifierProvider<ShowMoreBloc>.value(
      value: ShowMoreBloc(index,result),
      // ChangeNotifierProvider<ShowMoreBloc>(
      //   create: (context) =>  ShowMoreBloc(index,result),
      child: Scaffold(
          body: Column(
            children: [
              SizedBox(height: MARGIN_OVER,),
              Selector<ShowMoreBloc,List<BookVO>>(
                selector: (context,bloc) => bloc.showMoreBooks ?? [],
                shouldRebuild: (previous,next) => previous != next,
                builder: (context,showMoreBooks,child) =>
                BookListTitleView(
                    indexO: -1,
                    title: (showMoreBooks == null || showMoreBooks.isEmpty) ? "" : showMoreBooks.first.listName ?? "",
                    padd: MARGIN_SMALL,
                    isListFromHome: true,
                    goToNext: (){},
                ),
              ),
              DivideLineView(thick: 0.2),
              Expanded(
                child: Container(
                  child: Selector<ShowMoreBloc,List<BookVO>>(
                                     selector: (context,bloc) => bloc.showMoreBooks ?? [],
                                     shouldRebuild: (previous,next) => previous != next,
                                     builder: (context,showMoreBooks,child) =>
                        (showMoreBooks.isEmpty || showMoreBooks == null) ?
                        Center(child: Text(NO_RESULT_TEXT),)
                        : 
                         ShowMoreBookSection(
                            itemCount: showMoreBooks.length,
                            numResult: showMoreBooks.first.numResults ?? 0,
                            itemBuilder: (context,index){
                            return BookView(
                              key: Key("ShowMoreBook$index"),
                              isShowPrice: true,
                              isInShelf: false,
                              sheetFun: (){},
                           name: showMoreBooks[index].bookDetails?.first.title ?? "",
                           price: showMoreBooks[index].bookDetails?.first.price ?? "",
                           author: showMoreBooks[index].bookDetails?.first.author ?? "",
                           image: showMoreBooks[index].bookImage ?? IMAGE_CONSTANT_ONLINE,
                            bookWidth: BOOK_SIZE_IN_lIST_GRID_PAGE_CONTAINER_WIDTH,
                             bookHeight: BOOK_SIZE_IN_lIST_GRID_PAGE_CONTAINER_HEIGHT,
                              SizeOfName: TEXT_SMALL_1X,
                               isVisible: true,
                                onClick: (){
                                ShowMoreBloc bloc = Provider.of(context,listen: false);
                                bloc.saveBookToCarousel(showMoreBooks[index]).then((value) => 
                                navigateToNextScreen(context, BookDetailPage(
                                  book: showMoreBooks[index],
                                  )));
                                }
                                );
                           },
                           moreBooksFun: (){
                              if((showMoreBooks.first.numResults ?? 0) > 20){
                                ShowMoreBloc bloc = Provider.of(context,listen: false);
                              bloc.clickForMoreViewNextPage();
                              }else{
                         SnackBarView(context,NOW_MORE_BOOKS);
                              }
                           },
                            ),
                       ),
                ),
              ),
            ],
          ),
      ),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> SnackBarView(BuildContext context,String text) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text(text,),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          )
        ),
      )
    );
  }


    navigateToNextScreen(BuildContext context,Widget page) {
    return Navigator.push(context,
         MaterialPageRoute(builder: (BuildContext context) => page));
  }

}
