import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_library_app/blocs/home_page_bloc.dart';
import 'package:the_library_app/blocs/search_page_bloc.dart';
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

class BookListInGrid extends StatelessWidget {

  final bool isFromSearchPage;
  final String searchText;

  BookListInGrid({
    required this.isFromSearchPage,
    required this.searchText,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: [
            Selector<HomePageBloc,List<ShowMoreResultVO>>(
              selector: (context,bloc) => bloc.showMoreBooks ?? [],
              shouldRebuild: (previous,next) => previous != next,
              builder: (context,showMoreBooks,child) =>
              BookListTitleView(
                  title: (isFromSearchPage) ? searchText : showMoreBooks.first.listName ?? "",
                  padd: 0,
                  isListFromHome: true,
                  goToNext: (){},
              ),
            ),
            Divider(color: BTM_SHEET_OPTION_ICON_COLOR,),
            Container(
              child:  (isFromSearchPage) ?
               Selector<SearchPageBloc,List<BookTestVO>>(
                 selector: (context,bloc) => bloc.filterList,
                 shouldRebuild: (previous,next) => previous != next,
                 builder: (context,filterList,child) =>
                  (filterList.length == 0) ? 
                    Center(child: Text("No result for \'${searchText}\'"),)
                  : 
                  SearchPageBooks(
                    filterList: filterList,
                    onClick: ()=> navigateToNextScreen(context, BookDetailPage(
                      userSelectBook: BookVO.empty(),
                      userSelectBookFromShowMore: ShowMoreResultVO.empty(),
                      isOverView: false,
                      )),
                  )
                 )
                :
                 Selector<HomePageBloc,List<ShowMoreResultVO>>(
              selector: (context,bloc) => bloc.showMoreBooks ?? [],
              shouldRebuild: (previous,next) => previous != next,
              builder: (context,showMoreBooks,child) =>
                    HomeAndDetailBooks(
                     onClick: (userSelectBookFromShowMore){
                       navigateToNextScreen(context, BookDetailPage(
                       userSelectBook: BookVO.empty(),
                       userSelectBookFromShowMore: userSelectBookFromShowMore,
                       isOverView: false,
                       ));
                     },
                      books: showMoreBooks,
                      ),
                 ),
            ),
          ],
        ),
    );
  }

    navigateToNextScreen(BuildContext context,Widget page) {
    return Navigator.push(context,
         MaterialPageRoute(builder: (BuildContext context) => page));
  }

}

class HomeAndDetailBooks extends StatelessWidget {
  
  final Function(ShowMoreResultVO) onClick;
  final List<ShowMoreResultVO> books;

  HomeAndDetailBooks({
    required this.onClick,
    required this.books,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2,vertical: MARGIN_MEDIUM_2),
                itemCount: books.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.5,
                ),
                 itemBuilder: (context,index){
                   return BookView(
                     name: books[index].bookDetails?.first.title ?? "",
                     price: books[index].bookDetails?.first.price ?? "",
                     image: IMAGE_CONSTANT,
                      bookWidth: BOOK_SIZE_IN_lIST_GRID_PAGE_CONTAINER_WIDTH,
                       bookHeight: BOOK_SIZE_IN_lIST_GRID_PAGE_CONTAINER_HEIGHT,
                        SizeOfName: TEXT_SMALL_1X,
                         isVisible: true,
                          onClick: (){
                             onClick(books[index]);
                          }
                          );
                 }
                 );
  }
}

class SearchPageBooks extends StatelessWidget {

  final List<BookTestVO> filterList;
  final Function onClick;

  SearchPageBooks({
    required this.filterList,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      separatorBuilder: ((context, index) => DivideLineView(thick: 1,)),
      itemCount: filterList.length,
      itemBuilder: (context,index){
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Expanded(
                  flex: 1,
                  child: SearchResultBookView()
                  ),
                  SizedBox(width: MARGIN_MEDIUM_2,),
                  Expanded(
                  flex: 2,
                  child: SearchResultBookInfoView(
                    name: filterList[index].title ?? ""
                    ),
                  ),
            ],
          );
      },
    );
  }
}

class SearchResultBookInfoView extends StatelessWidget {
  const SearchResultBookInfoView({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          SearchResultBookName(
            name: name,
            isTitle: true,
            ),
            SizedBox(height: MARGIN_PRE_SMALL,),
             SearchResultBookName(
            name: "Brian Rathbone",
            isTitle: false,
            ),
            SizedBox(height: MARGIN_PRE_SMALL,),
             SearchResultBookName(
            name: "eBook 3.7 ★",
            isTitle: false,
            ),
            SizedBox(height: MARGIN_PRE_SMALL,),
             SearchResultBookName(
            name: "Free",
            isTitle: false,
            ),
      ],
    );
  }
}

class SearchResultBookView extends StatelessWidget {
  const SearchResultBookView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
                 width: BOOK_SIZE_IN_lIST_GRID_PAGE_CONTAINER_WIDTH_2,
                 height: BOOK_SIZE_IN_lIST_GRID_PAGE_CONTAINER_HEIGHT_2,
                 clipBehavior: Clip.antiAlias,
                 decoration: BoxDecoration(
     borderRadius: BorderRadius.all(Radius.circular(MARGIN_SMALL_1X)),
                 ),
                 margin: EdgeInsets.only(right: MARGIN_SMALL_1X),
                 child: Image.network("https://s26162.pcdn.co/wp-content/uploads/2020/01/Sin-Eater-by-Megan-Campisi.jpg",
                 fit: BoxFit.cover,),
        );
  }
}

class DivideLineView extends StatelessWidget {
  
    final double thick;

    DivideLineView({
      required this.thick,
    });

  @override
  Widget build(BuildContext context) {
    return Container(height: thick,color:BTM_SHEET_OPTION_ICON_COLOR,margin: EdgeInsets.symmetric(vertical: 10),);
  }
}

class SearchResultBookName extends StatelessWidget {
  
  final String name;
  final bool isTitle;

  SearchResultBookName({
    required this.name,
    required this.isTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
   style: TextStyle(
     fontSize: (isTitle) ? TEXT_MEDIUM : TEXT_SMALL_1X,
     fontWeight: (isTitle) ? FontWeight.w400 : FontWeight.w400,
    color: (isTitle) ? BTM_SHEET_OPTION_TEXT_COLOR: BTM_SHEET_OPTION_ICON_COLOR, 
            ),
    );
  }
}