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

class HomeTabBloc extends ChangeNotifier{

  BookModel bookModel = BookModelImpl();

//int currentIndex = 0;
int tabIndex = 0;



List<BookListVO>? bookLists;
ResultVO? results;
List<BookVO>? listForCarousel;
String date = DateFormat("yyyy-MM-dd").format(DateTime.now());

    HomeTabBloc({BookModel? bmodel}){

      if(bmodel != null){
        bookModel = bmodel;
      }

      ///OverView Database
      bookModel.overViewBooksDatabase(date).listen((event) {
        bookLists = event?.lists;
        results = event;
        notifyListeners();
        //print("bookList database ==============> ${bookLists}");
      }).onError((error){
         print("Over View bloc section database error");
      });

        ///get List For carousel
        bookModel.getUserTapBookDatabase().listen((event) {
          listForCarousel = event;
           listForCarousel?.sort(((a, b) => a.time!.compareTo(b.time ?? "") ));
          notifyListeners();
          print("User Tap Book List length Database ==============> ${listForCarousel?.length}");
          print("User Tap Book List Database ==============> ${listForCarousel}");
      }).onError((error){
        print("User Tap Book list section database error");
      });

    }

     void deleteFromCarouselBook(){
      bookModel.deleteBooksFromCarouselDatabase();
    }  




  // userChooseTab(int index){
  //   currentIndex = index;
  //   notifyListeners();
  // }


  userChooseBookTypeIndex(int index){
    tabIndex = index;
    notifyListeners();
  }


  Future<BookVO> saveBookToCarousel(BookVO book){
        book.time = DateTime.now().toString();
        bookModel.putUserTapBook(book.title ?? book.searchResult?.volumeInfo?.title ?? book.bookDetails?.first.title ?? "",book);
        notifyListeners();
        print("Book Detail check ===========> ${book.title}");
        return Future.value(book);
    }

}