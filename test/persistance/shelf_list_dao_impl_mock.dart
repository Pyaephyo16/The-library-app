import 'package:the_library_app/data/vos/shelf_vo.dart';
import 'package:the_library_app/data/vos/overview/book_vo.dart';
import 'package:the_library_app/persistance/abstraction_layer/shelf_list_dao.dart';

import '../mock_data/mock_data.dart';

class ShelfListDaoImplMock extends ShelfListDao{

  Map<String,ShelfVO> shelfListDatabaseMock = {};

  @override
  void createShelf(ShelfVO shelf) {
    shelfListDatabaseMock[shelf.id ?? ""] = shelf;
  }

  @override
  List<ShelfVO> getAllShelfs() {
    return shelfListMockForTest();
  }

   @override
  Stream<void> shelfsEventStream() {
    return Stream<void>.value(null);
  }

  @override
  List<ShelfVO> getAllShelfsData() {
    if(shelfListMockForTest() != null){
      return shelfListMockForTest();
    }else{
      return [];
    }
  }

  @override
  Stream<List<ShelfVO>> getAllShelfsStream() {
    return Stream.value(shelfListMockForTest());
  }

  @override
  void deleteSingleShelf(String id){
    //no need to mock
  }

  @override
  List<BookVO> getSelectedShelf(List<String> currentBox, int shelfIndex) {
    //no need to mock
    //return [];
    List<BookVO> temp = [];
    List<ShelfVO> shelfs = getAllShelfs();
    shelfs[shelfIndex].books?.forEach((element) {
        if(element.categoryForOverView == currentBox.first){
          temp.add(element);
        }
    });
    return temp;
  }

}