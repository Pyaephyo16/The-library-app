import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:the_library_app/blocs/search_page_bloc.dart';
import 'package:the_library_app/dummy/debouncer_class.dart';
import 'package:the_library_app/dummy/dummy_data.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/view_items/book_name_and_info_view.dart';
import 'package:the_library_app/view_items/search_field_section.dart';

class SearchPage extends StatelessWidget {

  final TextEditingController searchText = TextEditingController();
 final _debouncer = Debouncer(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: Column(
            children: [ 
              SearchFieldSection(
                searchText: searchText,
                isSearchPage: true,
                prefixTouch: (){
                  Navigator.pop(context);
                },
               icon: Icon(Icons.chevron_left_outlined,size: MARGIN_MEDIUM_3X),
               typing: (str){
                 _debouncer.run(() {
                    SearchPageBloc bloc = Provider.of(context,listen: false);
                    bloc.searchFun(str);
                 });
               },
                ),
                SizedBox(height: MARGIN_SMALL_1X,),
              Selector<SearchPageBloc,List<BookVO>>(
                  selector: (context,bloc) => bloc.filterList,
                  shouldRebuild: (previous,next) => previous != next,
                  builder: (context,filterList,child) =>
                 Expanded(
                  child: 
                  (searchText.text.isEmpty) ?
                    SarchFieldBottmIconView()
                  : 
                     ListView.separated(
                       separatorBuilder: (BuildContext context,int index) => Divider(),
                        itemCount: filterList.length,
                      itemBuilder: (BuildContext context,int index){
                          return BookNameAndInfoView(
                            isSheet: true,
                             title: filterList[index].title ?? "",
                              content: filterList[index].content ?? "",
                               isInShelf: false,
                               );
                      },
                        ),
                  ),
              ),
            ],
          ),
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
    return Column(
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

