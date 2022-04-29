import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:the_library_app/blocs/home_page_bloc.dart';
import 'package:the_library_app/dummy/dummy_data.dart';
import 'package:the_library_app/pages/book_detail_page.dart';
import 'package:the_library_app/resources/colors.dart';
import 'package:the_library_app/resources/constants.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/view_items/book_list_title_view.dart';
import 'package:the_library_app/widgets/book_list_title_and_serials_view.dart';

class HomeTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          SizedBox(height:MARGIN_OVER_EXTRA,),
         CarouselBookView(
           bookListForCarousel: bookListForCarousel,
         ),
         DefaultTabController(
           length: 2,
            child: Selector<HomePageBloc,int>(
              selector: (context,bloc) => bloc.tabIndex,
              shouldRebuild: (previous,next) => previous != next,
              builder: (context,tabIndex,child) =>
               TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: Colors.blue,
                unselectedLabelColor: BOOK_EXTRA_DATA_CONTENT_COLOR,
                onTap: (index){
                  HomePageBloc _bloc = Provider.of(context,listen: false);
                  _bloc.userChooseBookTypeIndex(index);
                },
                tabs: [
                  Tab(child: Text(TAB_EBOOK),),
                  Tab(child: Text(TAB_AUDIOBOOK),),
              ],),
            ),
            ),
            Selector<HomePageBloc,int>(
              selector: (context,bloc) => bloc.tabIndex,
              shouldRebuild: (pre,next) => pre != next,
              builder: (context,tabIndex,child) =>
               Container(
                width: MediaQuery.of(context).size.width,
                child: (tabIndex==0) ?
                 EbooksView(
                   onClick: () =>
                      navigateToNextScreen(context),
                 ) 
                 : 
                 AudioBooksView(
                   onClick: () =>
                      navigateToNextScreen(context),
                 ),
              ),
            )
        ],
      ),
    );
  }

    navigateToNextScreen(BuildContext context) {
    return Navigator.push(context,
         MaterialPageRoute(builder: (BuildContext context) => BookDetailPage()));
  }
}

class CarouselBookView extends StatelessWidget {
  
  final List<Widget> bookListForCarousel;

  CarouselBookView({required this.bookListForCarousel});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
       items: bookListForCarousel,
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

  final Function onClick;

  EbooksView({
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BookListTileAndSerialsView(
          title: EBOOK_LIST_TITLE_1,
          onClick: () => onClick(),
        ),
        BookListTileAndSerialsView(
          title: EBOOK_LIST_TITLE_2,
         onClick: () => onClick(),
        ),
        BookListTileAndSerialsView(
          title: EBOOK_LIST_TITLE_3,
          onClick: () => onClick(),
        ),
      ],
    );
  }

 

}

class AudioBooksView extends StatelessWidget {
  final Function onClick;

  AudioBooksView({
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
       mainAxisSize: MainAxisSize.min,
      children: [
        BookListTileAndSerialsView(
          title: AUDIOBOOK_LIST_TITLE_1,
          onClick: () => onClick(),
          ),
          BookListTileAndSerialsView(
          title: AUDIOBOOK_LIST_TITLE_2,
          onClick: () => onClick(),
          ),
          BookListTileAndSerialsView(
          title: AUDIOBOOK_LIST_TITLE_3,
          onClick: () => onClick(),
          ),
      ],
    );
  }

     
}


