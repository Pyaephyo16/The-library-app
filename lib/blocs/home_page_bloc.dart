import 'package:flutter/foundation.dart';
import 'package:the_library_app/data/models/book_model.dart';
import 'package:the_library_app/data/models/book_model_impl.dart';
import 'package:the_library_app/data/vos/overview/book_vo.dart';

class HomePageBloc extends ChangeNotifier{

   BookModel bookModel = BookModelImpl();

int currentIndex = 0;
List<BookVO>? listForCarousel;

  HomePageBloc({BookModel? model}){

    if(model != null){
      bookModel = model;
    }

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

  userChooseTab(int index){
    currentIndex = index;
    notifyListeners();
  }

}