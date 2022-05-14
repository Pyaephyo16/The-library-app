import 'package:flutter/foundation.dart';
import 'package:the_library_app/data/models/book_model.dart';
import 'package:the_library_app/data/models/book_model_impl.dart';
import 'package:the_library_app/data/vos/overview/book_vo.dart';

class BookDetailBloc extends ChangeNotifier{

  BookModel bookModel = BookModelImpl();

BookVO? detailsInfo;
List<BookVO>? similarBooks;

  BookDetailBloc(BookVO book,{BookModel? model}){

    if(model != null){
      bookModel = model;
    }

      tapForDetail(book);
  }


  Future<BookVO> tapForDetail(BookVO book){
        detailsInfo = book;
        bookModel.searchBook(book.categoryForOverView ?? book.listName ?? book.searchResult?.volumeInfo?.categories?.first ?? "").then((value){
          value.forEach((element) {
            if(element.searchResult?.volumeInfo?.categories?.first == null){
            element.searchResult?.volumeInfo?.categories?.first = book.categoryForOverView ?? book.listName ?? "";
            }
          });
          similarBooks = value;
        //print("Book Detail check in detail page bloc ===========> ${similarBooks}");
          notifyListeners();
        });
        notifyListeners();
        return Future.value(book);
    }

     Future<BookVO> saveBookToCarousel(BookVO book){
        book.time = DateTime.now().toString();
        bookModel.putUserTapBook(book.title ?? book.searchResult?.volumeInfo?.title ?? book.bookDetails?.first.title ?? "",book);
        notifyListeners();
        print("Book Detail check ===========> ${book.title}");
        return Future.value(book);
    }

}