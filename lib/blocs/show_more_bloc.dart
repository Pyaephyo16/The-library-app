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


  ShowMoreBloc(int index,ResultVO result,{BookModel? model}){

    if(model != null){
      bookModel = model;
    }

    clickForMoreView(index, result);
  }


    Future<String> clickForMoreView(int index,ResultVO result){
      offset = 0;
       bookListName =result.lists?[index].listName ?? "";
       bestSellerDate = result.bestsellersDate ?? "";
       publishedDate = result.publishedDate ?? "";

    ///Show More Database
     bookModel.showMoreBooksDatabase(bookListName ?? "",offset.toString(),result.bestsellersDate ?? "", result.publishedDate ?? "").listen((event) {
        showMoreBooks = event?.bookList ?? [];
        notifyListeners();
        print("showMore books database ==============> ${showMoreBooks}");
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

  ///Save show more books to carousel
     Future<BookVO> saveBookToCarousel(BookVO book){
        book.time = DateTime.now().toString();
        bookModel.putUserTapBook(book.title ?? book.searchResult?.volumeInfo?.title ?? book.bookDetails?.first.title ?? "",book);
        notifyListeners();
        print("Book Detail check ===========> ${book.title}");
        return Future.value(book);
    }

}