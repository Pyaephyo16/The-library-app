import 'package:flutter/foundation.dart';
import 'package:the_library_app/dummy/debouncer_class.dart';
import 'package:the_library_app/dummy/dummy_data.dart';

class SearchPageBloc extends ChangeNotifier{

List<BookVO> filterList = [];


  searchFun(String str){
    print("String =====================> $str");
     if(str!=null){
    List<BookVO> temp = [];
            temp = bookDummy.where((element){
             return element.title.toString().toLowerCase().contains(str.toLowerCase());
              }).toList();
              filterList = temp;
              print("filter list =============> ${filterList}");
             }
             notifyListeners();
  }

}