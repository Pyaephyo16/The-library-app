import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:the_library_app/data/vos/overview/book_vo.dart';
import 'package:the_library_app/data/vos/shelf_vo.dart';
import 'package:the_library_app/persistance/abstraction_layer/shelf_list_dao.dart';
import 'package:the_library_app/persistance/hive_constants.dart';

class ShelfListDaoImpl extends ShelfListDao{

  static final ShelfListDaoImpl _singleton = ShelfListDaoImpl._internal();

  factory ShelfListDaoImpl(){
    return _singleton;
  }

  ShelfListDaoImpl._internal();


  @override
  void createShelf(ShelfVO shelf)async{
    await getShelfBox().put(shelf.id, shelf);
  }

  @override
  List<ShelfVO> getAllShelfs() {
    return getShelfBox().values.toList();
  }

  
  // @override
  // ShelfVO? getShelfById(String id) {
  //   return getShelfBox().get(id);
  // }

  @override
  void deleteSingleShelf(String id) {
    getShelfBox().delete(id);
  }

  //  @override
  // void deleteAllShelfs() {
  //   getShelfBox().clear();
  // }

  @override
  List<BookVO> getSelectedShelf(List<String> currentBox,int shelfIndex){
    List<BookVO> temp = [];
    List<ShelfVO> dataTest = getAllShelfs();
    currentBox.forEach((outer) {
     dataTest[shelfIndex].books?.forEach((element) {
            if((element.categoryForOverView ?? element.listName ?? element.searchResult?.volumeInfo?.categories?.first) == outer){
              temp.add(element);
            }
         });
    });

    return temp;
  }


  ///Reactive

  @override
  Stream<void> shelfsEventStream() {
    return getShelfBox().watch();
  }

  @override
  List<ShelfVO> getAllShelfsData() {
    if(getAllShelfs() != null && getAllShelfs().isNotEmpty){
      print("shelfs in databse ==============> ${getAllShelfs()}");
      return getAllShelfs();
    }else{
      return [];
    }
  }

  @override
  Stream<List<ShelfVO>> getAllShelfsStream() {
    return Stream.value(getAllShelfs());
  }

  // @override
  // ShelfVO? getShelfByIdData(String id) {
  //   if(getShelfById(id) != null){
  //     return getShelfById(id);
  //   }else{
  //     return ShelfVO.empty();
  //   }
  // }

  // @override
  // Stream<ShelfVO?> getShelfsByIdStream(String id) {
  //   return Stream.value(getShelfById(id));
  // }

  Box<ShelfVO> getShelfBox(){
    return Hive.box<ShelfVO>(BOX_NAME_SHELF_VO);
  }



 
}