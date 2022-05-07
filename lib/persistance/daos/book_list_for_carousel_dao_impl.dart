import 'package:hive/hive.dart';
import 'package:the_library_app/data/vos/overview/book_vo.dart';
import 'package:the_library_app/persistance/abstraction_layer/book_list_for_carousel_dao.dart';
import 'package:the_library_app/persistance/hive_constants.dart';

class BookListForCarouselDaoImpl extends BookListForCarouselDao{

  static final BookListForCarouselDaoImpl _singleton = BookListForCarouselDaoImpl._internal();

  factory BookListForCarouselDaoImpl(){
    return _singleton;
  }

  BookListForCarouselDaoImpl._internal();

    @override
  void saveUserTapBook(String name,BookVO book)async {
    await getUserTapBookListBox().put(name,book);
  }


  @override
  List<BookVO> getUserTapBookList() {
    return getUserTapBookListBox().values.toList();
  }

   @override
  deleteBooksFromCarousel() {
    getUserTapBookListBox().clear();
  }


  //Reactive

  @override
  Stream<void> getUserTapBookListEventStream() {
    return getUserTapBookListBox().watch();
  }

    @override
  List<BookVO> getUserTapBookListData() {
    if(getUserTapBookList().isNotEmpty && getUserTapBookList() != null){
        return getUserTapBookList();
    }else{
      return [];
    }
  }

  @override
  Stream<List<BookVO>> getUserTapBookListStream() {
    return Stream.value(getUserTapBookList());
  }

  

  Box<BookVO> getUserTapBookListBox(){
    return Hive.box<BookVO>(BOX_NAME_BOOK_LIST_FOR_CAROUSEL);
  }

 

}