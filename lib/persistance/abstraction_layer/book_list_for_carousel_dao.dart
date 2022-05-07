import 'package:the_library_app/data/vos/overview/book_vo.dart';

abstract class BookListForCarouselDao{

  void saveUserTapBook(String name,BookVO book);
  List<BookVO> getUserTapBookList();

  Stream<void> getUserTapBookListEventStream();
  List<BookVO> getUserTapBookListData();
  Stream<List<BookVO>> getUserTapBookListStream();
  deleteBooksFromCarousel();

}