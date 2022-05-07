import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:the_library_app/blocs/book_detail_bloc.dart';
import 'package:the_library_app/blocs/home_page_bloc.dart';
import 'package:the_library_app/blocs/search_page_bloc.dart';
import 'package:the_library_app/blocs/your_books_bloc.dart';
import 'package:the_library_app/data/vos/overview/book_vo.dart';
import 'package:the_library_app/dummy/debouncer_class.dart';
import 'package:the_library_app/dummy/dummy_data.dart';
import 'package:the_library_app/pages/book_detail_page.dart';
import 'package:the_library_app/pages/book_list_in_grid.dart';
import 'package:the_library_app/resources/constants.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/view_items/book_name_and_info_view.dart';
import 'package:the_library_app/view_items/search_field_section.dart';
import 'package:the_library_app/widgets/book_list_title_and_serials_view.dart';

class SearchPage extends StatelessWidget {

  final TextEditingController searchText = TextEditingController();
 final _debouncer = Debouncer(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(
          children: [ 
            SizedBox(height: MARGIN_OVER),
            Padding(
        padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2,vertical: MARGIN_SMALL_1),
              child: SearchFieldSection(
                searchText: searchText,
                isSearchPage: true,
                prefixTouch: (){
                  Navigator.pop(context);
                },
               icon: Icon(Icons.chevron_left_outlined,size: MARGIN_MEDIUM_3X),
               typing: (str){
                 _debouncer.run(() {
                    SearchPageBloc bloc = Provider.of(context,listen: false);
                    bloc.searchFun(str,false);
                 });
               },
               submittedFun: (str){
                 _debouncer.run(() {
                     SearchPageBloc bloc = Provider.of(context,listen: false);
                     bloc.searchFun(str,true);
                 });
               },
                ),
            ),
            //SizedBox(height: MARGIN_MEDIUM_2,),
            Selector<YourBooksBloc,List<BookVO>>(
           selector: (context,bloc) => bloc.listForCarousel ?? [],
           shouldRebuild: (previous,next) => previous != next,
           builder: (context,listForCarousel,child) =>
               Selector<SearchPageBloc,List<BookVO>>(
                  selector: (context,bloc) => bloc.filterList,
                  shouldRebuild: (previous,next) => previous != next,
                  builder: (context,filterList,child) =>
                 Selector<SearchPageBloc,int>(
           selector: (context,bloc) => bloc.optionNumber,
           shouldRebuild: (previous,next) => previous != next,
           builder: (context,optionNumber,child) =>
                   Expanded(
                    child: 
                    (optionNumber == 0) ?
                      SarchFieldBottmIconView()
                    :
                    (optionNumber == 1) ? 
                   (filterList.length == 0) ?
                   Center(child: Text(NO_RESULT_TEXT),)
                   :
                     ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                    separatorBuilder: (BuildContext context,int index) => Divider(),
                          itemCount: filterList.length,
                        itemBuilder: (BuildContext context,int index){
                            return BookNameAndInfoView(
                              onClick: (){
                                BookDetailBloc _bloc = Provider.of(context,listen: false);
                                _bloc.tapForDetail(filterList[index],listForCarousel).then((value){
                                navigateToNextScreen(context, BookDetailPage());
                                });
                              },
                              isSheet: false,
                              image: filterList[index].searchResult?.volumeInfo?.imageLinks?.thumbnail ?? IMAGE_CONSTANT_ONLINE,
                               title: filterList[index].searchResult?.volumeInfo?.title ?? "",
                                content: filterList[index].searchResult?.volumeInfo?.authors?.first ?? "",
                                 isInShelf: false,
                                 );
                        },
                       )
                       :
                       (filterList.length == 0) ?
                       Center(child: Text(NO_RESULT_TEXT),)
                       :
                        Selector<SearchPageBloc,Map<String?,List<BookVO>>>(
           selector: (context,bloc) => bloc.data ?? {},
           shouldRebuild: (previous,next) => previous != next,
           builder: (context,data,child) =>
                          ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context,index){
                           return BookListTileAndSerialsView(
                             isShowPrice: false,
                             title: data.keys.elementAt(index).toString(),
                             books: data[data.keys.elementAt(index)] ?? [],
                             goToNext: (){},
                             onClick: (index){
                               BookDetailBloc _bloc = Provider.of(context,listen: false);
                                    _bloc.tapForDetail(filterList[index],listForCarousel).then((value){
                                    navigateToNextScreen(context, BookDetailPage());
                                    });
                             },
                             );
                            },
                          ),
                       )
                    ),
                 ),
              ),
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
}

class SarchFieldBottmIconView extends StatelessWidget {
  const SarchFieldBottmIconView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchSectionAndNameView(
            icon: FaIcon(FontAwesomeIcons.arrowTrendUp),
            title: "Top Selling",
          ),
          SearchSectionAndNameView(
            title: "New Releases",
            icon: FaIcon(FontAwesomeIcons.idBadge),
          ),
         SearchSectionAndNameView(
            icon: FaIcon(FontAwesomeIcons.shop),
            title: "Book Shop",
          ),
        ],
      ),
    );
  }
}

class SearchSectionAndNameView extends StatelessWidget {
 
  final String title;
  final FaIcon icon;

  SearchSectionAndNameView({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text(title),
    );
  }
}

