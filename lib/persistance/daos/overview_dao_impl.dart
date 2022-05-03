import 'package:hive/hive.dart';
import 'package:the_library_app/data/vos/overview/book_list_vo.dart';
import 'package:the_library_app/data/vos/overview/result_vo.dart';
import 'package:the_library_app/persistance/abstraction_layer/overview_dao.dart';
import 'package:the_library_app/persistance/hive_constants.dart';

class OverViewDaoImpl extends OverViewDao{

  static final OverViewDaoImpl _singleton = OverViewDaoImpl._internal();

  factory OverViewDaoImpl(){
    return _singleton;
  }

    OverViewDaoImpl._internal();

      @override
  void saveAllBookList(String date,ResultVO bookList)async {
    // Map<int,BookListVO> bookListForMap = Map.fromIterable(
    //   bookList,
    //    key: (element) => element.listId,
    //    value: (element) => element,
    // );
    // await getOverViewBox().putAll(bookListForMap);
    await getOverViewBox().put(date, bookList);
  }

  @override
  ResultVO? getAllBookList(String date) {
      //return getOverViewBox().values.toList();
      return getOverViewBox().get(date);
  }


  ///Reactive
    
  @override
  Stream<void> getBookListEventStream() {
    return getOverViewBox().watch();
  }


  @override
  ResultVO? getAllBookListData(String date) {
    if(getAllBookList(date) != null ){
      print("Overview booklist output from database ==============> ${getAllBookList(date)}");
      return getAllBookList(date);
    }else{
      return ResultVO.empty();
    }
  }

  @override
  Stream<ResultVO?> getAllBookListStream(String date) {
    return Stream.value(getAllBookList(date));
  }

  Box<ResultVO> getOverViewBox(){
    return Hive.box<ResultVO>(BOX_NAME_RESULT_VO);
  }

}