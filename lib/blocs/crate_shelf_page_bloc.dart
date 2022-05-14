import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:the_library_app/data/models/book_model.dart';
import 'package:the_library_app/data/models/book_model_impl.dart';
import 'package:the_library_app/data/vos/overview/book_vo.dart';
import 'package:the_library_app/data/vos/shelf_vo.dart';
import 'package:the_library_app/dummy/dummy_data.dart';

class CreateShelfPageBloc extends ChangeNotifier{

  BookModel bookModel = BookModelImpl();

  CreateShelfPageBloc({BookModel? model}){
    if(model != null){
      bookModel = model;
    }
  }


String dateForId = DateTime.now().toString();

  Future<String> newShelf(String name){
      ShelfVO data = ShelfVO(id: dateForId,shelfName: name,books: []);

      //Create Shelf
      bookModel.createNewShelf(data);

      notifyListeners();
    return Future.value(dateForId);
  }


}