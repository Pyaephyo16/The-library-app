import 'package:the_library_app/data/vos/overview/book_vo.dart';
import 'package:the_library_app/persistance/abstraction_layer/book_list_for_carousel_dao.dart';

import '../mock_data/mock_data.dart';

class BookListForCarouselDaoImplMock extends BookListForCarouselDao{

 Map<String,BookVO> bookListForCarouselDatabaseMock = {};

   @override
  void saveUserTapBook(String name, BookVO book) {
    bookListForCarouselDatabaseMock[name] = book;
  }

  @override
  List<BookVO> getUserTapBookList() {
    return bookListForCarouselMockForTest();
  }


   @override
  Stream<void> getUserTapBookListEventStream() {
    return Stream<void>.value(null);
  }

  @override
  List<BookVO> getUserTapBookListData() {
    if(bookListForCarouselMockForTest() != null){
      return bookListForCarouselMockForTest();
    }else{
      return [];
    }
  }


  @override
  Stream<List<BookVO>> getUserTapBookListStream() {
    return Stream.value(bookListForCarouselMockForTest());
  }

   @override
  deleteBooksFromCarousel() {
    //No need to mock
  }

  @override
  List<BookVO> getSelectedBook(List<String> currentBox) {
    //no need to mock
    //return [];
    List<BookVO> temp = [];
    getUserTapBookList().forEach((element) {
        if(element.categoryForOverView == currentBox.first){
          temp.add(element);
        }
    });
    return temp;
  }

}