import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:the_library_app/data/models/book_model.dart';
import 'package:the_library_app/data/models/book_model_impl.dart';
import 'package:the_library_app/data/vos/overview/book_list_vo.dart';
import 'package:the_library_app/data/vos/overview/book_vo.dart';
import 'package:the_library_app/data/vos/overview/result_vo.dart';
import 'package:the_library_app/data/vos/overview/show_more_list_for_hive_vo.dart';
import 'package:the_library_app/data/vos/show_more/show_more_result_vo.dart';
import 'package:the_library_app/dummy/dummy_data.dart';

class HomePageBloc extends ChangeNotifier{

  BookModel bookModel = BookModelImpl();

int currentIndex = 0;
int tabIndex = 0;
int libTabIndex = 0;


List<BookListVO>? bookLists;
ResultVO? results;
String date = DateFormat("yyyy-MM-dd").format(DateTime.now());

    HomePageBloc(){

      ///OverView
      // bookModel.overViewBooks(date).then((value){
      //   bookLists = value;
      //   notifyListeners();
      //   print("bookList ==============> $bookLists");
      // }).catchError((error){
      //     print("Over View bloc section error");
      // });

      ///OverView Database
      bookModel.overViewBooksDatabase(date).listen((event) {
        bookLists = event?.lists;
        results = event;
        notifyListeners();
        //print("bookList database ==============> ${bookLists}");
      }).onError((error){
         print("Over View bloc section database error");
      });

    }


  libChooseTab(int index){
      libTabIndex = index;
      notifyListeners();
  }

  userChooseTab(int index){
      currentIndex = index;
      libTabIndex = 0;
      notifyListeners();
  }

  userChooseBookTypeIndex(int index){
    tabIndex = index;
    notifyListeners();
  }

}