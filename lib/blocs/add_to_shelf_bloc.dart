import 'package:flutter/foundation.dart';
import 'package:the_library_app/data/models/book_model.dart';
import 'package:the_library_app/data/models/book_model_impl.dart';
import 'package:the_library_app/data/vos/overview/book_vo.dart';
import 'package:the_library_app/data/vos/shelf_vo.dart';

class AddToShelfBloc extends ChangeNotifier{

BookModel bookModel = BookModelImpl();

List<ShelfVO>? shelfs;

  AddToShelfBloc({BookModel? model}){

    if(model != null){
      bookModel = model;
    }

    bookModel.getAllShelfsDatabase().listen((event) {
        shelfs = event;
        notifyListeners();
    });

  }

  Future<BookVO> saveToShelf(int index,BookVO book){
    List<ShelfVO> temp = shelfs ?? [];
    temp[index].books?.add(book);
    bookModel.createNewShelf(temp[index]);
    return Future.value(book);
  }

}