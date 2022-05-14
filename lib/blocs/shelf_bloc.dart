import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:the_library_app/data/models/book_model.dart';
import 'package:the_library_app/data/models/book_model_impl.dart';
import 'package:the_library_app/data/vos/chip_vo.dart';
import 'package:the_library_app/data/vos/overview/book_vo.dart';
import 'package:the_library_app/data/vos/shelf_vo.dart';
import 'package:the_library_app/dummy/dummy_data.dart';
import 'package:the_library_app/persistance/abstraction_layer/shelf_list_dao.dart';
import 'package:the_library_app/persistance/daos/shelf_list_dao_impl.dart';

class ShelfBloc extends ChangeNotifier{

BookModel bookModel = BookModelImpl();

int gpValue = 1;
int sortStyle = 1;


  List<ChipVO> temp = [];
  List<String> test = [];
  List<String> currentBox = [];

int? shelfOptionValue;
List<ShelfVO>? shelfs;
List<BookVO>? booksInShelf;
 List<ChipVO>? chips;

  ShelfBloc(int userSelectIndex,{BookModel? model}){

    if(model != null){
      bookModel = model;
    }
      
      shelfs = bookModel.getAllShelfDb();
      booksInShelf = shelfs?[userSelectIndex].books;
      if(shelfs?[userSelectIndex].books?.length != 0){
          shelfs?[userSelectIndex].books?.forEach((element){
              test.add(element.categoryForOverView ?? element.listName ?? element.searchResult?.volumeInfo?.categories?.first ?? "");
          }); 
          temp.clear();
          test.toSet().toList().forEach((testData) {
                temp.add(
                ChipVO(
                  category: testData,
                  isSelected: false,
                )
              );
              });
        chips = temp;
        }
      notifyListeners();

  }



optionsForShelf(int? index){
    if(index != null){
        shelfOptionValue = index;
        notifyListeners();
    }
  }

  Future<String> renameShelfName(int userSelectIndex,String newName){
    ShelfVO temp = shelfs?[userSelectIndex] ?? ShelfVO.empty();
    temp.shelfName = newName;
    bookModel.createNewShelf(temp);

      shelfOptionValue = null;
      notifyListeners();
      return Future.value(shelfs?[userSelectIndex].shelfName);
  }

   Future<String> deleteShelf(int userSelectIndex){
      bookModel.deleteSingleShelfDatabase(shelfs?[userSelectIndex].id ?? "");
      notifyListeners();
       return Future.value("");
  }

    Future<int> chooseSort(int value,int userSelectIndex){
    gpValue = value;
    notifyListeners();
     if(gpValue == 1){
      if(booksInShelf != null){
        booksInShelf?.sort(((a, b) => a.time!.compareTo(b.time ?? "") ));
      notifyListeners();
      }
    }else if(gpValue == 2){
      if(booksInShelf != null){
        booksInShelf?.sort(((a, b) => (a.author ?? a.bookDetails?.first.author ?? a.searchResult?.volumeInfo?.authors?.first)!.compareTo(b.author ?? b.bookDetails?.first.author ?? b.searchResult?.volumeInfo?.authors?.first ?? "")));
      notifyListeners();
      }
    }else if(gpValue == 3){
     if(booksInShelf != null){
        booksInShelf?.sort(((a, b) => (a.title ?? a.bookDetails?.first.title ?? a.searchResult?.volumeInfo?.title)!.compareTo(b.title ?? b.bookDetails?.first.title ?? b.searchResult?.volumeInfo?.title ?? "")));
      notifyListeners();
     }
    }
    return Future.value(gpValue);
  }

   Future<int> listOrGridSort(int value){
    sortStyle = value;
    notifyListeners();
    print("gp value after insert ===========> $sortStyle");
    return Future.value(sortStyle);
  }


    TapFunction(int? i,int shelfIndex){
    List<ChipVO> data = chips?.mapIndexed((index,e){
      if(i == null){
        currentBox.clear();
        e.isSelected = false;
      }else if(index == i && e.isSelected == false){
         e.isSelected = true;
           currentBox.add(e.category ?? "");
       }else if(index == i && e.isSelected == true){
         e.isSelected = false;
         currentBox.remove(e.category);
         notifyListeners();
       }
       return e;
     }).toList() ?? [];

     data.sort(((a, b) => a.isSelected == true ? -1 : 1));
     chips = data;

      print("category select length ==============> ${currentBox.length}");
     List<BookVO> testing = bookModel.getSelectedShelf(currentBox,shelfIndex);
     booksInShelf = testing;

     print("Shelf length after choose chip ==============> ${shelfs?[shelfIndex].books?.length}");

     if(currentBox.isEmpty || currentBox.length == 0){
        shelfs = bookModel.getAllShelfDb();
        booksInShelf = shelfs?[shelfIndex].books;
        print("Shelf length all cancel ===============> ${booksInShelf?.length}");
      }

     notifyListeners();
  }


}