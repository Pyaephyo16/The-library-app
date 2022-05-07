import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:the_library_app/data/models/book_model.dart';
import 'package:the_library_app/data/models/book_model_impl.dart';
import 'package:the_library_app/dummy/dummy_data.dart';

class ShelfBloc extends ChangeNotifier{

BookModel bookModel = BookModelImpl();

int? shelfOptionValue;
List<ShelfVO> shelfsName = shelfs;



optionsForShelf(int? index){
    if(index != null){
        shelfOptionValue = index;
        notifyListeners();
    }
  }

  Future<String> renameShelfName(int index,String newName){

    List<ShelfVO> data = shelfsName.mapIndexed((int i,shelf){
          if(i == index){
            shelf.title = newName;
          }
          return shelf;
    }).toList();
    shelfsName = data;
      shelfOptionValue = null;
      notifyListeners();
      return Future.value(shelfsName[index].title);
  }

   Future<String> deleteShelf(int index){
      List<ShelfVO> temp = [];
      shelfsName.forEach((element) {
        temp.add(element);
      });
      temp.removeAt(index);
      shelfsName = temp;
      notifyListeners();
       return Future.value("");
  }


}