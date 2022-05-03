import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:the_library_app/data/models/book_model.dart';
import 'package:the_library_app/data/models/book_model_impl.dart';
import 'package:the_library_app/data/vos/overview/book_list_vo.dart';
import 'package:the_library_app/data/vos/overview/book_vo.dart';
import 'package:the_library_app/data/vos/overview/result_vo.dart';
import 'package:the_library_app/data/vos/show_more/show_more_result_vo.dart';
import 'package:the_library_app/dummy/dummy_data.dart';

class HomePageBloc extends ChangeNotifier{

  BookModel bookModel = BookModelImpl();

int currentIndex = 0;
int tabIndex = 0;
int libTabIndex = 0;
int gpValue = 1;
int sortStyle = 1;

List<ChipVO> chips = chipData;

List<BookListVO>? bookLists;
ResultVO? results;
List<ShowMoreResultVO>? showMoreBooks;
int offset = 0;
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
        print("bookList database ==============> ${bookLists}");
      }).onError((error){
         print("Over View bloc section database error");
      });

    }

  Future<List<ShowMoreResultVO>> clickForMoreView(int index)async{
      String bookListName = bookLists?[index].listName ?? "";

      /// Show More
    //  return bookModel.showMoreBooks(bookListName,offset.toString(),results?.bestsellersDate ?? "", results?.publishedDate ?? "").then((value){
    //     showMoreBooks = value;
    //     notifyListeners();
    //     print("Show More database ==============> $showMoreBooks");
    //     return Future.value();
    //   }).catchError((error){
    //      print("Show More bloc section database error");
    //   });
    
    ///Show More Database
    await bookModel.showMoreBooksDatabase(bookListName,offset.toString(),results?.bestsellersDate ?? "", results?.publishedDate ?? "").listen((event) {
        showMoreBooks = event;
        notifyListeners();
        print("showMore books database ==============> ${showMoreBooks}");
    });
    // .onError((error){
    //    print("Show More bloc section database error");
    // });
    
        return Future.value(showMoreBooks);
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

   Future<int> chooseSort(int value){
    print("radio data ==================> $value");
    gpValue = value;
    notifyListeners();
    print("gp value after insert ===========> $gpValue");
    return Future.value(gpValue);
  }

     Future<int> listOrGridSort(int value){
    print("radio data ==================> $value");
    sortStyle = value;
    notifyListeners();
    print("gp value after insert ===========> $sortStyle");
    return Future.value(sortStyle);
  }

   TapFunction(int? i){
    List<ChipVO> data = chipData.mapIndexed((index,e){
       e.isSelected = false;
       if(index == i){
         e.isSelected = true;
         notifyListeners();
       }
       return e;
     }).toList();
     chips = data;
     notifyListeners();
     print("Chip Data ============> ${chips}");
  }




}