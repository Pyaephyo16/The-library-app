import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:the_library_app/blocs/shelf_bloc.dart';
import 'package:the_library_app/data/vos/chip_vo.dart';
import 'package:the_library_app/data/vos/overview/book_vo.dart';
import 'package:the_library_app/data/vos/shelf_vo.dart';
import 'package:the_library_app/pages/Views/your_books_view.dart';
import 'package:the_library_app/pages/book_detail_page.dart';
import 'package:the_library_app/pages/search_page.dart';
import 'package:the_library_app/resources/colors.dart';
import 'package:the_library_app/resources/constants.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/view_items/book_name_and_info_view.dart';
import 'package:the_library_app/view_items/divide_line_view.dart';
import 'package:the_library_app/view_items/option_button_view.dart';
import 'package:the_library_app/view_items/shelf_text_view.dart';
import 'package:the_library_app/widgets/shelf_creation_section.dart';

class ShelfPage extends StatelessWidget {

  final int userSelectIndex;

  ShelfPage({
    required this.userSelectIndex,
    });

  final TextEditingController newName = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {

    print("user select index ====================> $userSelectIndex");

    return ChangeNotifierProvider<ShelfBloc>.value(
      value : ShelfBloc(userSelectIndex),
      child: Scaffold(
        body: ListView(
          children: [
             Selector<ShelfBloc,List<ShelfVO>>(
              selector: (context,bloc) => bloc.shelfs ?? [],
              shouldRebuild: (previous,next) => previous != next,
              builder: (context,shelfs,child) =>
               ShelfDetailAppBarView(
                renameOrDelShelf: (index){
                  ShelfBloc _bloc = Provider.of(context,listen: false);
                  _bloc.optionsForShelf(index);
                },
                deleteShelf: (){
                  deleteShelfFun(
                    context,
                     shelfs,
                    delete: (){
                      ShelfBloc bloc = Provider.of(context,listen: false);
                      bloc.deleteShelf(userSelectIndex).then((value){
                        Navigator.pop(context);
                        Navigator.pop(context);
                      });
                    },
                    );
                },
                search: (){
                  navigateToNextScreen(context, SearchPage());
                },
                callRename: (){
                  newName.text = shelfs[userSelectIndex].shelfName ?? "";
                  FocusScope.of(context).requestFocus(focusNode);
                },
              ),
            ),
             Selector<ShelfBloc,List<ShelfVO>>(
              selector: (context,bloc) => bloc.shelfs ?? [],
              shouldRebuild: (previous,next) => previous != next,
              builder: (context,shelfs,child) =>
               Selector<ShelfBloc,int?>(
                selector: (context,bloc) => bloc.shelfOptionValue,
                shouldRebuild: (previous,next) => previous != next,
                builder: (context,shelfOptionValue,child) { 
                  return (shelfs.length < 1) ? 
                  Center(child: Text(EMPTY_TEXT),)
                  :
                  (shelfOptionValue == 0)  ? 
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                    child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                  CreateButton(
                    createBtn:  (){
                            if(formKey.currentState!.validate()){
              ShelfBloc bloc = Provider.of(context,listen: false);
                            bloc.renameShelfName(userSelectIndex, newName.text);
                      }
                       },
                    ),
                    ShelfTextView(
                      name: newName,
                       formKey: formKey,
                        isFocus: true,
                        focusNode: focusNode,
                        ),
              ],
            )
                  )
                  :
                   Padding(
                          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                       child: BookNameAndInfoView(
                         onClick: (){},
                      isSheet: false,
                      image: "",
                      title: shelfs[userSelectIndex].shelfName ?? "",
                      content: "${shelfs[userSelectIndex].books?.length} books",
                      isInShelf: true,
                                    ),
                                  );
                }
              ),
            ),
            Divider(color: BTM_SHEET_OPTION_ICON_COLOR,thickness: 1,),
            SizedBox(height: MARGIN_SMALL_1X,),
            Container(
              child:  Selector<ShelfBloc,int>(
                                selector: (context,bloc) => bloc.gpValue,
                                shouldRebuild: (previous,next) => previous != next,
                                builder: (context,gpValue,child) =>
                                Selector<ShelfBloc,List<ChipVO>>(
                                selector: (context,bloc) => bloc.chips ?? [],
                                shouldRebuild: (previous,next) => previous != next,
                                builder: (context,chips,child) =>
                                Selector<ShelfBloc,List<String>>(
                                selector: (context,bloc) => bloc.currentBox,
                                shouldRebuild: (previous,next) => previous != next,
                                builder: (context,currentBox,child) =>
                                   Selector<ShelfBloc,int>(
                                    selector: (context,bloc) => bloc.sortStyle,
                                    shouldRebuild: (previous,next) => previous != next,
                                     builder: (context,sortStyle,child) =>
                                     Selector<ShelfBloc,List<BookVO>>(
                                selector: (context,bloc) => bloc.booksInShelf ?? [],
                                shouldRebuild: (previous,next) => previous != next,
                                builder: (context,booksInShelf,child){
                                   return (booksInShelf.length == 0) 
                                            ?
                                            Center(child: Text("Empty"),) 
                                            :
                                       YourBooksView(
                                          currentBox: currentBox,
                                          listForCarousel: booksInShelf,
                                         chips: chips,
                                       gpValue: gpValue,
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
                                              ShelfBloc _bloc = Provider.of(context,listen: false);
                                                   _bloc.chooseSort(val,userSelectIndex).then((value) => Navigator.pop(context));
                                            },
                                            rd2: (val){
                                               ShelfBloc _bloc = Provider.of(context,listen: false);
                                                      _bloc.chooseSort(val,userSelectIndex).then((value) => Navigator.pop(context));
                                            },
                                            rd3: (val){
                                               ShelfBloc _bloc = Provider.of(context,listen: false);
                                                     _bloc.chooseSort(val,userSelectIndex).then((value) => Navigator.pop(context));
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
                                              ShelfBloc _bloc = Provider.of(context,listen: false);
                                                   _bloc.listOrGridSort(val).then((value) => Navigator.pop(context));
                                                    },
                                                     rd2: (val){
                                              ShelfBloc _bloc = Provider.of(context,listen: false);
                                                   _bloc.listOrGridSort(val).then((value) => Navigator.pop(context));
                                                     },
                                                      rd3: (val){
                                              ShelfBloc _bloc = Provider.of(context,listen: false);
                                                   _bloc.listOrGridSort(val).then((value) => Navigator.pop(context));
                                                      }
                                                      );
                                        },
                                        TapGenre: (indexFromGenre){
                                          ShelfBloc _bloc = Provider.of(context,listen: false);
                                          _bloc.TapFunction(indexFromGenre,userSelectIndex);
                                        },
                                        cancelGenre: (){
                                           ShelfBloc _bloc = Provider.of(context,listen: false);
                                          _bloc.TapFunction(null,userSelectIndex);
                                        },
                                        tabBookInfoBtn: (index,book){
                                             BookOptionBtmSheet(context,index,book);
                                        },
                                          sheetFun: (indexForSheet,book){
                                            BookOptionBtmSheet(context, indexForSheet,book);
                                          },
                                        onClick: (index){
                                          navigateToNextScreen(context, BookDetailPage(
                                            book: BookVO.empty(),
                                          ));
                                        },
                                        );
                                }
                                     ),
                                  ),
                                )
                                ),
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

  Future<dynamic> deleteShelfFun(BuildContext context, List<ShelfVO> shelfName,{required Function delete}) {
    return showDialog(
                  context: context,
                   builder: (conetxt){
                      return AlertDialog(
                          title: Text("Delete \'${shelfName[userSelectIndex].shelfName}\'?"),
                          content: Text(SHELF_DELETE_CONTENT),
                          actions: [
                           Row(
                             children: [
                               SizedBox(width: 6,),
                                Expanded(
                                  child: ButtonView(
                                       isGhostButton: true,
                                      title: CANCEL_TEXT,
                                  bgColor: Colors.transparent,
                                   onClick: (){
                                     Navigator.pop(context);
                                   },
                                   ),
                                ),
                                SizedBox(width: 6,),
                             Expanded(
                               child: ButtonView(
                                 isGhostButton: false,
                                  title: DELETE_TEXT,
                                   bgColor: CREATE_BUTTON_COLOR,
                                    onClick: (){
                                      delete();
                                    },
                                    ),
                             ),
                              SizedBox(width: MARGIN_PRE_SMALL,),
                             ],
                           )
                          ],
                      );
                   });
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
                                                onClick: () => print("todo"),
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
                       margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3,vertical: MARGIN_SMALL),
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

class ShelfDetailAppBarView extends StatelessWidget {

  final Function(int?) renameOrDelShelf;
  final Function deleteShelf;
  final Function search;
  final Function callRename;

  ShelfDetailAppBarView({
    required this.renameOrDelShelf,
    required this.deleteShelf,
    required this.search,
    required this.callRename,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
          IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
           icon: Icon(Icons.chevron_left_outlined,size: MARGIN_MEDIUM_4,color: BTM_SHEET_OPTION_ICON_COLOR,),
           ),
           Spacer(),
           IconButton(
            onPressed: (){
              search();
            },
           icon: Icon(Icons.search,size: MARGIN_MEDIUM_4,color: BTM_SHEET_OPTION_ICON_COLOR,),
           ),
    PopupMenuButton(
      onSelected: (int index){
          renameOrDelShelf(index);
                     if(index == 1){
              deleteShelf();
                     }
             
                     if(index == 0){
              callRename();
                     }
      },
      icon: FaIcon(FontAwesomeIcons.ellipsisVertical,color: BTM_SHEET_OPTION_ICON_COLOR,),iconSize: MARGIN_SIZE_FOR_ICON,
      itemBuilder: (context) =>[
        PopupMenuItem(
          child: Text(RENAME_SHELF_TEXT),
          value: 0,
          ),
          PopupMenuItem(
          child: Text(DELETE_SHELF_TEXT),
          value: 1,
          ),
      ]
      )
      ],
    );
  }
}