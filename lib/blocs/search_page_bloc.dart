import 'package:flutter/foundation.dart';
import 'package:the_library_app/dummy/debouncer_class.dart';
import 'package:the_library_app/dummy/dummy_data.dart';

class SearchPageBloc extends ChangeNotifier{

List<BookTestVO> filterList = [];


  Future<String> searchFun(String str){
    print("String =====================> $str");
     if(str!=null){
    List<BookTestVO> temp = [];
            temp = bookDummy.where((element){
             return element.title.toString().toLowerCase().contains(str.toLowerCase());
              }).toList();
              filterList = temp;
              print("filter list =============> ${filterList}");
             }
             notifyListeners();
             return Future.value("sth");
  }

}