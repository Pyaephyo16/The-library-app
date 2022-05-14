import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:the_library_app/blocs/crate_shelf_page_bloc.dart';
import 'package:the_library_app/blocs/home_page_bloc.dart';
import 'package:the_library_app/blocs/home_tab_bloc.dart';
import 'package:the_library_app/data/vos/overview/book_vo.dart';
import 'package:the_library_app/pages/Views/shelves_view.dart';
import 'package:the_library_app/pages/create_shelf_page.dart';
import 'package:the_library_app/pages/search_page.dart';
import 'package:the_library_app/pages/tabs/home_tab.dart';
import 'package:the_library_app/pages/tabs/library_tab.dart';
import 'package:the_library_app/resources/colors.dart';
import 'package:the_library_app/resources/constants.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/view_items/search_field_section.dart';

class HomePage extends StatelessWidget {

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // List<Widget> pageList = [
  //   HomeTab(),
  //   LibraryTab(scaffoldKey: ,),
  // ];

  final TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageBloc>.value(
      value: HomePageBloc(),
      // ChangeNotifierProvider<HomePageBloc>(
      //     create: (context) => HomePageBloc(),
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          toolbarHeight: 80,
          title: Selector<HomePageBloc, int>(
                selector: (context, bloc) => bloc.currentIndex,
                shouldRebuild: (previous, next) => previous != next,
                builder: (context, currentIndex, child){ 
                  print("search field section do timess ============================================");
              return Padding(
                padding: const EdgeInsets.only(top: MARGIN_FOR_TEXT_FIELD),
                child: GestureDetector(
                  onTap: () {
                    navigateToNextScreen(context,SearchPage());
                  },
                  child: SearchFieldSection(
                    key: Key("HomePageSearchBar"),
                    searchText: search,
                    isSearchPage: false,
                    prefixTouch: () {},
                    icon: Icon(Icons.search, size: MARGIN_MEDIUM_3X),
                    typing: (str) {},
                    submittedFun: (str) {},
                  ),
                ),
                      );
             }
            ),
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: Selector<HomePageBloc, int>(
                selector: (context, bloc) => bloc.currentIndex,
                shouldRebuild: (previous, next) => previous != next,
                builder: (context, currentIndex, child) =>
                    //pageList[currentIndex],
                    (currentIndex == 0) ? HomeTab() : LibraryTab(scaffoldKey: scaffoldKey)
              ),
            ),
          ],
        ),
        bottomNavigationBar: Selector<HomePageBloc, int>(
          selector: (context, bloc) => bloc.currentIndex,
          shouldRebuild: (previous, next) => previous != next,
          builder: (context, currentIndex, child) => BottomNavigationBar(
            key: Key("HomePageBottomNavigationBar"),
            selectedItemColor: CREATE_BUTTON_COLOR,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  key: Key("HomeTabIcon"),
                  size: MARGIN_MEDIUM_4,
                ),
                label: NAVIGATION_BAR_HOME_TEXT,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.library_add,
                  key: Key("LibTabIcon"),
                  size: MARGIN_MEDIUM_4,
                ),
                label: NAVIGATION_BAR_LIBRARY_TEXT,
              ),
            ],
            currentIndex: currentIndex,
            onTap: (index) {
              HomePageBloc _bloc = Provider.of(context, listen: false);
              _bloc.userChooseTab(index);
            },
          ),
        ),
      ),
    );
  }

  Future<dynamic> navigateToNextScreen(
      BuildContext context, Widget pageWidget) {
    return Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => pageWidget));
  }
}
