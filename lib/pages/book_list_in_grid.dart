import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_library_app/blocs/book_detail_bloc.dart';
import 'package:the_library_app/blocs/home_page_bloc.dart';
import 'package:the_library_app/blocs/search_page_bloc.dart';
import 'package:the_library_app/blocs/show_more_bloc.dart';
import 'package:the_library_app/blocs/your_books_bloc.dart';
import 'package:the_library_app/data/vos/overview/book_list_vo.dart';
import 'package:the_library_app/data/vos/overview/book_vo.dart';
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            SizedBox(height: MARGIN_OVER,),
            Selector<ShowMoreBloc,List<BookVO>>(
              selector: (context,bloc) => bloc.showMoreBooks ?? [],
              shouldRebuild: (previous,next) => previous != next,
              builder: (context,showMoreBooks,child) =>
              BookListTitleView(
                  title: (showMoreBooks == null || showMoreBooks.isEmpty) ? "" : showMoreBooks.first.listName ?? "",
                  padd: MARGIN_SMALL,
                  isListFromHome: true,
                  goToNext: (){},
              ),
            ),
            //Divider(color: BTM_SHEET_OPTION_ICON_COLOR,thickness: 1,),
            DivideLineView(thick: 0.2),
            Expanded(
              child: Container(
                child: Selector<YourBooksBloc,List<BookVO>>(
           selector: (context,bloc) => bloc.listForCarousel ?? [],
           shouldRebuild: (previous,next) => previous != next,
           builder: (context,listForCarousel,child) =>
                     Selector<ShowMoreBloc,List<BookVO>>(
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
                                 BookDetailBloc _bloc = Provider.of(context,listen: false);
                           _bloc.tapForDetail(showMoreBooks[index],listForCarousel).then((value){
                           navigateToNextScreen(context, BookDetailPage());
                           });
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
            ),
          ],
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




// class SearchPageBooks extends StatelessWidget {

//   final List<BookVO> filterList;
//   final Function onClick;

//   SearchPageBooks({
//     required this.filterList,
//     required this.onClick,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ListView.separated(
//       padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
//       //shrinkWrap: true,
//       //physics: NeverScrollableScrollPhysics(),
//       separatorBuilder: ((context, index) => DivideLineView(thick: 1,)),
//       itemCount: filterList.length,
//       itemBuilder: (context,index){
//           return Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//                 Expanded(
//                   flex: 1,
//                   child: SearchResultBookView()
//                   ),
//                   SizedBox(width: MARGIN_MEDIUM_2,),
//                   Expanded(
//                   flex: 2,
//                   child: SearchResultBookInfoView(
//                     name: filterList[index].title ?? ""
//                     ),
//                   ),
//             ],
//           );
//       },
//     );
//   }
// }

// class SearchResultBookInfoView extends StatelessWidget {
//   const SearchResultBookInfoView({
//     Key? key,
//     required this.name,
//   }) : super(key: key);

//   final String name;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//           SearchResultBookName(
//             name: name,
//             isTitle: true,
//             ),
//             SizedBox(height: MARGIN_PRE_SMALL,),
//              SearchResultBookName(
//             name: "Brian Rathbone",
//             isTitle: false,
//             ),
//             SizedBox(height: MARGIN_PRE_SMALL,),
//              SearchResultBookName(
//             name: "eBook 3.7 ★",
//             isTitle: false,
//             ),
//             SizedBox(height: MARGIN_PRE_SMALL,),
//              SearchResultBookName(
//             name: "Free",
//             isTitle: false,
//             ),
//       ],
//     );
//   }
// }

// class SearchResultBookView extends StatelessWidget {
//   const SearchResultBookView({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//                  width: BOOK_SIZE_IN_lIST_GRID_PAGE_CONTAINER_WIDTH_2,
//                  height: BOOK_SIZE_IN_lIST_GRID_PAGE_CONTAINER_HEIGHT_2,
//                  clipBehavior: Clip.antiAlias,
//                  decoration: BoxDecoration(
//      borderRadius: BorderRadius.all(Radius.circular(MARGIN_SMALL_1X)),
//                  ),
//                  margin: EdgeInsets.only(right: MARGIN_SMALL_1X),
//                  child: Image.network("https://s26162.pcdn.co/wp-content/uploads/2020/01/Sin-Eater-by-Megan-Campisi.jpg",
//                  fit: BoxFit.cover,),
//         );
//   }
// }



// class SearchResultBookName extends StatelessWidget {
  
//   final String name;
//   final bool isTitle;

//   SearchResultBookName({
//     required this.name,
//     required this.isTitle,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       name,
//    style: TextStyle(
//      fontSize: (isTitle) ? TEXT_MEDIUM : TEXT_SMALL_1X,
//      fontWeight: (isTitle) ? FontWeight.w400 : FontWeight.w400,
//     color: (isTitle) ? BTM_SHEET_OPTION_TEXT_COLOR: BTM_SHEET_OPTION_ICON_COLOR, 
//             ),
//     );
//   }
// }