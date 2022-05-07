import 'package:flutter/foundation.dart';
import 'package:the_library_app/data/models/book_model.dart';
import 'package:the_library_app/data/models/book_model_impl.dart';
import 'package:the_library_app/data/vos/overview/book_vo.dart';

class BookDetailBloc extends ChangeNotifier{

  BookModel bookModel = BookModelImpl();

BookVO? detailsInfo;
List<BookVO>? listForCarousel;
List<BookVO>? similarBooks;
int order = 0;


  Future<BookVO> tapForDetail(BookVO book,List<BookVO> list){
        listForCarousel = list;
        book.time = DateTime.now().toString();
        detailsInfo = book;
         if(listForCarousel?.length != 0 && listForCarousel != null){
         order = listForCarousel?.last.order ?? 0;
        }
        order++;
        detailsInfo?.order = order;
        print("List name check ==============> ${book}");
        bookModel.searchBook(book.title ?? book.bookDetails?.first.title ?? book.searchResult?.volumeInfo?.title ?? "").then((value){
          similarBooks = value;
          notifyListeners();
        });
        bookModel.putUserTapBook(detailsInfo?.title ?? detailsInfo?.searchResult?.volumeInfo?.title ?? detailsInfo?.bookDetails?.first.title ?? "",detailsInfo ?? BookVO.empty());
        notifyListeners();
        print("Book Detail check ===========> ${book.title}");
        return Future.value(book);
    }


    Future<BookVO> tapFromYourBookViewToDetail(BookVO book){
      detailsInfo = book;
      notifyListeners();
      return Future.value(detailsInfo);
    }

}