import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:the_library_app/dummy/dummy_data.dart';

class CreateShelfPageBloc extends ChangeNotifier{


List<ShelfVO> shelfsName = shelfs;
int? length;

  Future<String> newShelf(String name){
      ShelfVO data = ShelfVO(title: name, content: "5 books", isSelected: false);
      List<ShelfVO> temp = [];
      shelfsName.forEach((element){
        temp.add(element);
      });
      temp.add(data);
      shelfsName = temp;
      notifyListeners();
    return Future.value(shelfsName.last.title);
  }


  // optionsForShelf(int? index){
  //   if(index != null){
  //       shelfOptionValue = index;
  //       notifyListeners();
  //   }
  // }

//  Future<String> renameShelfName(int index,String newName){

//     List<ShelfVO> data = shelfsName.mapIndexed((int i,shelf){
//           if(i == index){
//             shelf.title = newName;
//           }
//           return shelf;
//     }).toList();
//     shelfsName = data;
//       shelfOptionValue = null;
//       notifyListeners();
//       return Future.value(shelfsName[index].title);
//   }

  // Future<String> deleteShelf(int index){
  //     List<ShelfVO> temp = [];
  //     shelfsName.forEach((element) {
  //       temp.add(element);
  //     });
  //     temp.removeAt(index);
  //     shelfsName = temp;
  //     notifyListeners();
  //      return Future.value("");
  // }



}