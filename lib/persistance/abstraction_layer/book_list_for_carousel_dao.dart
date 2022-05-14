import 'package:the_library_app/data/vos/overview/book_vo.dart';

abstract class BookListForCarouselDao{

  void saveUserTapBook(String name,BookVO book);
  List<BookVO> getUserTapBookList();
  //BookVO? getUserTapSingleBook(String name);
  List<BookVO> getSelectedBook(List<String> currentBox);

  Stream<void> getUserTapBookListEventStream();
  List<BookVO> getUserTapBookListData();
  Stream<List<BookVO>> getUserTapBookListStream();
  //BookVO? getUserTapSingleBookData(String name);
  //Stream<BookVO?> getUserTapSingleBookStream(String name);
  deleteBooksFromCarousel();

}