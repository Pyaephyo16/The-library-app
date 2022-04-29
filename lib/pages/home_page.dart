import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:the_library_app/blocs/crate_shelf_page_bloc.dart';
import 'package:the_library_app/blocs/home_page_bloc.dart';
import 'package:the_library_app/pages/create_shelf_page.dart';
import 'package:the_library_app/pages/search_page.dart';
import 'package:the_library_app/pages/tabs/home_tab.dart';
import 'package:the_library_app/pages/tabs/library_tab.dart';
import 'package:the_library_app/resources/colors.dart';
import 'package:the_library_app/resources/constants.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/view_items/search_field_section.dart';

class HomePage extends StatelessWidget {

  List<Widget> pageList = [
   HomeTab(),
   LibraryTab(),
  ];

  final TextEditingController search = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
            Positioned.fill(
              child: Selector<HomePageBloc,int>(
        selector: (context,bloc) => bloc.currentIndex,
        shouldRebuild: (previous,next) => previous != next,
        builder: (context,currentIndex,child) =>
                 pageList[currentIndex],
                ),
              ),

            Positioned(
              top: 66,
              left: 16,
              right: 16,
              child: GestureDetector(
                onTap: (){
                  navigateToNextScreen(context, SearchPage());
                },
                child: SearchFieldSection(
                  searchText: search,
                  isSearchPage: false,
                  prefixTouch: (){},
                  icon: Icon(Icons.search,size: MARGIN_MEDIUM_3X),
                  typing: (str){},
                ),
              ),
              ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton:
       Selector<HomePageBloc,int>(
                      selector: (context,bloc) => bloc.libTabIndex,
                      shouldRebuild: (previous,next) => previous != next,
                      builder: (context,libTabIndex,child) {
        return (libTabIndex == 1) ? FloatingActionButton.extended(
          onPressed:(){
            navigateToNextScreen(context, CreateShelfPage());
          },
          label: ShelfCreateBtnTextView(),
          ) : Container();
                      },
      ),
      bottomNavigationBar: Selector<HomePageBloc,int>(
        selector: (context,bloc) => bloc.currentIndex,
        shouldRebuild: (previous,next) => previous != next,
        builder: (context,currentIndex,child) =>
         BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: NAVIGATION_BAR_HOME_TEXT),
            BottomNavigationBarItem(icon: Icon(Icons.library_add),label: NAVIGATION_BAR_LIBRARY_TEXT),
          ],
          currentIndex: currentIndex,
          onTap: (index){
            HomePageBloc _bloc = Provider.of(context,listen: false);
            _bloc.userChooseTab(index);
          },
          ),
      ),
    );
  }

  Future<dynamic> navigateToNextScreen(BuildContext context,Widget pageWidget) {
    return Navigator.push(context,
                       MaterialPageRoute(builder: (BuildContext context) => pageWidget));
  }
}





