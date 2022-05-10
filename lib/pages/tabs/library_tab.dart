import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:the_library_app/blocs/book_detail_bloc.dart';
import 'package:the_library_app/blocs/crate_shelf_page_bloc.dart';
import 'package:the_library_app/blocs/home_page_bloc.dart';
import 'package:the_library_app/blocs/library_tab_bloc.dart';
import 'package:the_library_app/data/vos/chip_vo.dart';
import 'package:the_library_app/data/vos/overview/book_list_vo.dart';
import 'package:the_library_app/data/vos/overview/book_vo.dart';
import 'package:the_library_app/data/vos/shelf_vo.dart';
import 'package:the_library_app/data/vos/show_more/show_more_result_vo.dart';
import 'package:the_library_app/dummy/dummy_data.dart';
import 'package:the_library_app/pages/Views/shelves_view.dart';
import 'package:the_library_app/pages/Views/your_books_view.dart';
import 'package:the_library_app/pages/add_to_shelf_page.dart';
import 'package:the_library_app/pages/book_detail_page.dart';
import 'package:the_library_app/pages/book_list_in_grid.dart';
import 'package:the_library_app/pages/create_shelf_page.dart';
import 'package:the_library_app/pages/shelf_page.dart';
import 'package:the_library_app/resources/colors.dart';
import 'package:the_library_app/resources/constants.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/view_items/book_name_and_info_view.dart';
import 'package:the_library_app/view_items/book_view.dart';
import 'package:the_library_app/view_items/check_icon_view.dart';
import 'package:the_library_app/view_items/divide_line_view.dart';
import 'package:the_library_app/view_items/ellipis_icon_view.dart';
import 'package:the_library_app/view_items/option_button_view.dart';
import 'package:the_library_app/widgets/book_list_title_and_serials_view.dart';
import 'package:the_library_app/widgets/book_view_for_carousel.dart';

class LibraryTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LibraryTabBloc>.value(
     value: LibraryTabBloc(),
      child: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Positioned.fill(
              child: ListView(
                children: [
                  SizedBox(height: MARGIN_MEDIUM_2,),
                  DefaultTabController(
                    length: 2, 
                    child: Selector<LibraryTabBloc,int>(
                            selector: (context,bloc) => bloc.libTabIndex,
                            shouldRebuild: (previous,next) => previous != next,
                            builder: (context,libTabIndex,child) =>
                       TabBar(
                              indicatorSize: TabBarIndicatorSize.label,
                              labelColor: CREATE_BUTTON_COLOR,
                              unselectedLabelColor: BOOK_EXTRA_DATA_CONTENT_COLOR,
                            tabs: [
                              Tab(child: Text(YOUR_BOOKS,
                              style: TextStyle(
                            fontSize: TEXT_SMALL_1X,
                          ),
                              ),),
                              Tab(child: Text(SHELVES,
                              style: TextStyle(
                            fontSize: TEXT_SMALL_1X,
                          ),
                              ),),
                            ],
                            onTap: (index){
                              LibraryTabBloc bloc = Provider.of(context,listen: false);
                              bloc.libChooseTab(index);
                            },
                          ),
                    ),
                    ),
                    Divider(color:SAMPLE_BACKGROUND_COLOR,),
                    SizedBox(height: MARGIN_SMALL_1X,),
                    Column(
                    mainAxisSize: MainAxisSize.min,
                      children: [ 
                            // Builder(
                            //   builder: (context) {
                            //     return ElevatedButton(
                            //       onPressed: (){
                            //         LibraryTabBloc bloc = Provider.of(context,listen: false);
                            //         bloc.deleteAllShelfsDatabase();
                            //       }, 
                            //       child: Text("delete all shelfs"),
                            //       );
                            //   }
                            // ),
                          Selector<LibraryTabBloc,int>(
                            selector: (context,bloc) => bloc.libTabIndex,
                            shouldRebuild: (previous,next) => previous != next,
                            builder: (context,libTabIndex,child) {
                             return Container(
                            child: (libTabIndex == 0) ?
                                  Selector<LibraryTabBloc,int>(
                                    selector: (context,bloc) => bloc.gpValue,
                                    shouldRebuild: (previous,next) => previous != next,
                                    builder: (context,gpValue,child) =>
                                    Selector<LibraryTabBloc,List<ChipVO>>(
                                    selector: (context,bloc) => bloc.chips ?? [],
                                    shouldRebuild: (previous,next) => previous != next,
                                    builder: (context,chips,child) =>
                                       Selector<LibraryTabBloc,List<String>>(
                                    selector: (context,bloc) => bloc.currentBox,
                                    shouldRebuild: (previous,next) => previous != next,
                                    builder: (context,currentBox,child) =>
                                      Selector<LibraryTabBloc,int>(
                                            selector: (context,bloc) => bloc.sortStyle,
                                             shouldRebuild: (previous,next) => previous != next,
                                           builder: (context,sortStyle,child) =>
                               Selector<LibraryTabBloc,List<BookVO>>(
                                          selector: (context,bloc) => bloc.listForCarousel ?? [],
                                        shouldRebuild: (previous,next) => previous != next,
                                      builder: (context,listForCarousel,child) =>
                                        (listForCarousel.isEmpty || listForCarousel == null) 
                                        ?
                                        Center(child: Text("Empty"),) 
                                        :
                                           YourBooksView(
                                               chips: chips,
                                               currentBox: currentBox,
                                               gpValue: gpValue,
                                               listForCarousel: listForCarousel,
                                               sortStyle: sortStyle,
                                              ChooseTab: (gpValue){
                                                BtmSheet(
                                                  context,
                                                   gpValue,
                                                  title: BTM_SHEET_TITLE,
                                                  rd1Text: BTM_RD_1,
                                                  rd2Text: BTM_RD_2,
                                                  rd3Text: BTM_RD_3,
                                                  rd1: (val){
                                                    LibraryTabBloc _bloc = Provider.of(context,listen: false);
                                                         _bloc.chooseSort(val).then((value) => Navigator.pop(context));
                                                  },
                                                  rd2: (val){
                                                     LibraryTabBloc _bloc = Provider.of(context,listen: false);
                                                            _bloc.chooseSort(val).then((value) => Navigator.pop(context));
                                                  },
                                                  rd3: (val){
                                                     LibraryTabBloc _bloc = Provider.of(context,listen: false);
                                                           _bloc.chooseSort(val).then((value) => Navigator.pop(context));
                                                  }
                                                 );
                                              },
                                              onChooseStyle: (sortStyle){
                                                  BtmSheet(
                                                    context,
                                                     sortStyle,
                                                      title: BTM_SHEET_SORT_TITLE,
                                                       rd1Text: BTM_RD_SORT_1,
                                                        rd2Text: BTM_RD_SORT_2,
                                                         rd3Text: BTM_RD_SORT_3,
                                                          rd1: (val){
                                                    LibraryTabBloc _bloc = Provider.of(context,listen: false);
                                                         _bloc.listOrGridSort(val).then((value) => Navigator.pop(context));
                                                          },
                                                           rd2: (val){
                                                    LibraryTabBloc _bloc = Provider.of(context,listen: false);
                                                         _bloc.listOrGridSort(val).then((value) => Navigator.pop(context));
                                                           },
                                                            rd3: (val){
                                                    LibraryTabBloc _bloc = Provider.of(context,listen: false);
                                                         _bloc.listOrGridSort(val).then((value) => Navigator.pop(context));
                                                            }
                                                            );
                                              },
                                              TapGenre: (index){
                                                LibraryTabBloc _bloc = Provider.of(context,listen: false);
                                                _bloc.TapFunction(index);
                                              },
                                              cancelGenre: (){
                                                 LibraryTabBloc _bloc = Provider.of(context,listen: false);
                                                _bloc.TapFunction(null);
                                              },
                                              tabBookInfoBtn: (index,book){
                                                     BookOptionBtmSheet(context,index,book);
                                              },
                                              sheetFun: (index,book){
                                                BookOptionBtmSheet(context,index, book);
                                              },
                                              onClick: (book){
                                                // BookDetailBloc bloc = Provider.of(context,listen: false);
                                                // bloc.tapFromYourBookViewToDetail(book).then((value){
                                                //   navigateToNextScreen(context, BookDetailPage());
                                                // });
                                                navigateToNextScreen(context, BookDetailPage(
                                                  book: book,
                                                ));
                                              },
                                              ),
                                            ),
                                         ),
                                      ),
                                    )
                                    )
                                :
                               Selector<LibraryTabBloc,List<ShelfVO>>(
                                  selector: (context,bloc) => bloc.shelfs ?? [],
                                  shouldRebuild: (previous,next) => previous != next,
                                  builder: (context,shelfs,child) =>
                                (shelfs.length < 1) ?
                                Center(child: Text(EMPTY_TEXT),)
                                :
                                 ShelvesView(
                                   shelfs: shelfs,
                                   image: IMAGE_CONSTANT_ONLINE,
                                    goToShelf: (index) =>
                                    navigateToNextScreen(context,ShelfPage(userSelectIndex: index)),
                                  ),
                                )
                               );
                            },
                          )
                      ],
                    ),
                ],
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Selector<LibraryTabBloc,int>(
              selector: (context,bloc) => bloc.libTabIndex,
               shouldRebuild: (previous,next) => previous != next,
              builder: (context,libTabIndex,child) =>
              (libTabIndex == 1) ? GestureDetector(
                onTap: (){
                  navigateToNextScreen(context, CreateShelfPage());
                },
                child: Container(
                    width: CREATE_SHELF_BUTTON__WIDTH,
                    height: CREATE_SHELF_BUTTON_HEIGHT,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.all(Radius.circular(22)),
                     color: CREATE_BUTTON_COLOR,
                   ),
                   child: Center(child: ShelfCreateBtnTextView(),),
                  ),
              ) 
                : Container()
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> navigateToNextScreen(BuildContext context,Widget pageWidget) {
    return Navigator.push(context,
                       MaterialPageRoute(builder: (BuildContext context) => pageWidget));
  }

  Future<dynamic> BookOptionBtmSheet(BuildContext context,int index,BookVO book) {
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
                                           onClick: (){},
                                           isSheet: true,
                                           image: book.bookImage ?? book.searchResult?.volumeInfo?.imageLinks?.thumbnail ?? IMAGE_CONSTANT_ONLINE,
                                           title: book.title ?? book.searchResult?.volumeInfo?.title ?? book.bookDetails?.first.title ?? "",
                                           content: book.author ??  book.searchResult?.volumeInfo?.authors?.first ?? book.bookDetails?.first.author ?? "",
                                           isInShelf: false,
                                         ),
                                       ),
                                       DivideLineView(thick: 1,),
                                          Column(
                                           mainAxisSize: MainAxisSize.min,
                                           children: [
                                             OptionButtonView(
                                               isInSheet: true,
                                               title: BOOK_OPTION_DOWNLOAD,
                                                icon: Icon(Icons.download_outlined,size: BTM_SHEET_ICON_SIZE,color: BTM_SHEET_OPTION_ICON_COLOR,), 
                                                onClick: () => print("todo"),
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
                                                onClick: () =>  navigateToNextScreen(context, AddToShelfPage(userSelectBook: book)),
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

  

  Future<dynamic> BtmSheet(BuildContext context, int gpValue,
  {required String title,
  required String rd1Text,
  required String rd2Text,
  required String rd3Text,
    required Function(int) rd1,
    required Function(int) rd2,
    required Function(int) rd3,
  }) {
    return showModalBottomSheet(
           context: context,
             builder: (_){
               return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                        Container(
                      margin: const EdgeInsets.symmetric(vertical: MARGIN_PRE_SMALL,horizontal: MARGIN_MEDIUM_3),
                       child: Text(title,
                          style: TextStyle(
                          color: Colors.black,
                            fontSize: TEXT_MEDIUM,
                       fontWeight: FontWeight.w700,
                      ),  
                     ),
                       ),
                 Divider(thickness: 1,),
                 Column(
                       mainAxisSize: MainAxisSize.min,
                       children: [
                      ListTile(
                           leading: Radio(
                  groupValue: gpValue,
                     value: 1,
                    onChanged: (int? val){
                    rd1(val ?? 1);
                    }
                    ),
                   title: Text(rd1Text,
                  style: TextStyle(
                    color: Colors.black,
                   fontWeight: FontWeight.w400,
             ),
             ),
            ),
                  ListTile(
           leading: Radio(
                   groupValue: gpValue,
                       value: 2,
        onChanged: (int? val){
             rd2(val ?? 2);
             }
            ),
             title: Text(rd2Text,
                  style: TextStyle(
                      color: Colors.black,
                   fontWeight: FontWeight.w400,
                       ),
                  ),
                 ),
                 ListTile(
               leading: Radio(
                 groupValue: gpValue,
               value: 3,
             onChanged: (int? val){
               rd3(val ?? 3);
                }
              ),
             title: Text(rd3Text,
               style: TextStyle(
                       color: Colors.black,
                       fontWeight: FontWeight.w400,
                     ),
                    ),
                   ),
            ],
          ),
        ],
      );
     }
     );
  }
}










