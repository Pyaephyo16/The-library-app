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

  // @override
  // BookVO? getUserTapSingleBook(String name) {
  //   return getUserTapBookListBox().get(name);
  // }

   @override
  deleteBooksFromCarousel() {
    getUserTapBookListBox().clear();
  }

  @override
  List<BookVO> getSelectedBook(List<String> currentBox){
      List<BookVO> temp = [];
      currentBox.forEach((outer) {
        getUserTapBookList().forEach((inner) { 
          if((inner.categoryForOverView ?? inner.listName ?? inner.searchResult?.volumeInfo?.categories?.first) == outer){
              temp.add(inner);
          }
        });
      });
      return temp;
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

    

  // @override
  // BookVO? getUserTapSingleBookData(String name) {
  //   if(getUserTapSingleBook(name) != null){
  //     return getUserTapSingleBook(name);
  //   }else{
  //     print("empty single book");
  //     return BookVO.empty();
  //   }
  // }

  // @override
  // Stream<BookVO?> getUserTapSingleBookStream(String name) {
  //   return Stream.value(getUserTapSingleBook(name));
  // }

  

  Box<BookVO> getUserTapBookListBox(){
    return Hive.box<BookVO>(BOX_NAME_BOOK_LIST_FOR_CAROUSEL);
  }



 

}