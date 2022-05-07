import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:the_library_app/data/models/book_model.dart';
import 'package:the_library_app/data/models/book_model_impl.dart';
import 'package:the_library_app/data/vos/overview/book_list_vo.dart';
import 'package:the_library_app/data/vos/overview/book_vo.dart';
import 'package:the_library_app/data/vos/overview/result_vo.dart';

class ShowMoreBloc extends ChangeNotifier{

  BookModel bookModel = BookModelImpl();

  int offset = 0;
  String? bookListName;
    String? bestSellerDate;
  String? publishedDate;
  List<BookVO>? showMoreBooks;





    Future<String> clickForMoreView(int index,ResultVO result){
      offset = 0;
       bookListName =result.lists?[index].listName ?? "";
       bestSellerDate = result.bestsellersDate ?? "";
       publishedDate = result.publishedDate ?? "";

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
     bookModel.showMoreBooksDatabase(bookListName ?? "",offset.toString(),result.bestsellersDate ?? "", result.publishedDate ?? "").listen((event) {
        showMoreBooks = event?.bookList ?? [];
        notifyListeners();
        print("showMore books database ==============> ${showMoreBooks?.first.bookImage}");
    }).onError((error){
       print("Show More bloc section database error");
    });
      return Future.value(bookListName);
    }

  

      Future<String> clickForMoreViewNextPage(){
        offset +=20;
    ///Show More Database
     bookModel.showMoreBooksDatabase(bookListName ?? "",offset.toString(),bestSellerDate ?? "",publishedDate ?? "").listen((event) {
        showMoreBooks = event?.bookList ?? [];
        notifyListeners();
        print("showMore books Next Page database ==============> ${showMoreBooks}");
    }).onError((error){
       print("Show More bloc section database error");
    });
      return Future.value(bookListName);
    }

}