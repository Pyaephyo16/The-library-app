import 'package:the_library_app/data/models/book_model.dart';
import 'package:the_library_app/data/vos/shelf_vo.dart';
import 'package:the_library_app/data/vos/overview/show_more_list_for_hive_vo.dart';
import 'package:the_library_app/data/vos/overview/result_vo.dart';
import 'package:the_library_app/data/vos/overview/book_vo.dart';

import '../mock_data/mock_data.dart';

class BookModelImplMock extends BookModel{

  

  @override
  Future<ResultVO?> overViewBooks(String publishedDate) {
    return Future.value(resultMockForTest());
  }

    @override
  Future<List<BookVO>> searchBook(String name) {
    print("work on it");
    return Future.value([searBookMock()]);
  }

  @override
  Future<List<BookVO>?> showMoreBooks(String list, String offset, String bestSellersDate, String publishedDate) {
    return Future.value(showMoreMockForTest());
  }

    @override
  void putUserTapBook(String name, BookVO book) {
    // no need to mock
  }

  @override
  void createNewShelf(ShelfVO shelf) {
    // no need to mock
  }

  @override
  List<BookVO> getSelectedBook(List<String> currentBox) {
    if(currentBox.length != 0){
      return bookListForCarouselMockForTest();
    }else{
      return bookListForCarouselMockForTest();
    }
  }

  @override
  List<BookVO> getSelectedShelf(List<String> currentBox, int shelfIndex) {
    if(currentBox.length != 0){
      return shelfListMockForTest()[shelfIndex].books ?? [];
    }else{
      return [];
    }
  }

 

  @override
  Stream<ResultVO?> overViewBooksDatabase(String publishedDate) {
    return Stream.value(
      resultMockForTest(),
    );
  }


  @override
  Stream<ShowMoreListForHiveVO?> showMoreBooksDatabase(String list, String offset, String bestSellersDate, String publishedDate) {
    return Stream.value(
        showMoreListForHiveMockForTest(),
    );
  }

   @override
  Stream<List<BookVO>> getUserTapBookDatabase() {
    return Stream.value(
      bookListForCarouselMockForTest(),
    );
  }

   @override
  Stream<List<ShelfVO>> getAllShelfsDatabase() {
    return Stream.value(
      shelfListMockForTest(),
    );
  }
  
  @override
  List<ShelfVO> getAllShelfDb() {
   return shelfListMockForTest();
  }

  @override
  void deleteBooksFromCarouselDatabase() {
    // no need to mock
  }

  @override
  void deleteSingleShelfDatabase(String id) {
    // no need to mock
  }


 


}