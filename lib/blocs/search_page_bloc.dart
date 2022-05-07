import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:the_library_app/data/models/book_model.dart';
import 'package:the_library_app/data/models/book_model_impl.dart';
import 'package:the_library_app/data/vos/overview/book_vo.dart';
import 'package:the_library_app/dummy/debouncer_class.dart';
import 'package:the_library_app/dummy/dummy_data.dart';

class SearchPageBloc extends ChangeNotifier{

  BookModel bookModel = BookModelImpl();

List<BookVO> filterList = [];
int optionNumber = 0;
Map<String,List<BookVO>>? data;


  Future<String> searchFun(String str,bool isSubmit){
      if(str.isEmpty){
        optionNumber = 0;
        notifyListeners();
      }else if(isSubmit == false){
        optionNumber = 1;
        notifyListeners();
      }else if(isSubmit == true){
        optionNumber = 2;
       data = groupBy(filterList,(BookVO book) => book.searchResult?.volumeInfo?.categories?.first ?? str);
         print("Group by check ============> ${data}");
        notifyListeners();
      }

     if(str!=null && str.isNotEmpty){
    List<BookVO> temp = [];
      bookModel.searchBook(str).then((value){
         temp = value.where((element){
             return element.searchResult?.volumeInfo?.title.toString().toLowerCase().contains(str.toLowerCase()) ?? false;
              }).toList();
              filterList = temp;
         notifyListeners();
         print("filter list =============> ${filterList}");
      });
     }
       notifyListeners();
    return Future.value("sth");
  }


}