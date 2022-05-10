import 'package:the_library_app/data/vos/overview/book_vo.dart';
import 'package:the_library_app/data/vos/shelf_vo.dart';

abstract class ShelfListDao{

  void createShelf(ShelfVO shelf);
  List<ShelfVO> getAllShelfs();
  List<BookVO> getSelectedShelf(List<String> currentBox,int shelfIndex);
  void deleteSingleShelf(String id);
  void deleteAllShelfs();
  Stream<void> shelfsEventStream();
  List<ShelfVO> getAllShelfsData();
  Stream<List<ShelfVO>> getAllShelfsStream();

}