import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:the_library_app/data/models/book_model.dart';
import 'package:the_library_app/data/models/book_model_impl.dart';
import 'package:the_library_app/data/vos/overview/book_vo.dart';
import 'package:the_library_app/dummy/dummy_data.dart';

class YourBooksBloc extends ChangeNotifier{

  BookModel bookModel = BookModelImpl();

int gpValue = 1;
int sortStyle = 1;

List<ChipVO> chips = chipData;

 List<BookVO>? listForCarousel;


 YourBooksBloc(){

        bookModel.getUserTapBookDatabase().listen((event) {
          listForCarousel = event;
          listForCarousel?.sort((a, b) => (a.order ?? 0) > (b.order ?? 0) ? 1 : -1,);
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

  Future<int> chooseSort(int value){
    gpValue = value;
    notifyListeners();
    if(gpValue == 1){
      if(listForCarousel != null){
        listForCarousel?.sort(((a, b) => a.time!.compareTo(b.time ?? "") ));
      notifyListeners();
      }
    }else if(gpValue == 2){
      if(listForCarousel != null){
        listForCarousel?.sort(((a, b) => (a.author ?? a.bookDetails?.first.author ?? a.searchResult?.volumeInfo?.authors?.first)!.compareTo(b.author ?? b.bookDetails?.first.author ?? b.searchResult?.volumeInfo?.authors?.first ?? "")));
      notifyListeners();
      }
    }else if(gpValue == 3){
     if(listForCarousel != null){
        listForCarousel?.sort(((a, b) => (a.title ?? a.bookDetails?.first.title ?? a.searchResult?.volumeInfo?.title)!.compareTo(b.title ?? b.bookDetails?.first.title ?? b.searchResult?.volumeInfo?.title ?? "")));
      notifyListeners();
     }
    }
    print("gp value after insert ===========> $gpValue");
    return Future.value(gpValue);
  }

    Future<int> listOrGridSort(int value){
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