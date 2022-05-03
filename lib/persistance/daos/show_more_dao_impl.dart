import 'package:hive/hive.dart';
import 'package:the_library_app/data/vos/show_more/show_more_result_vo.dart';
import 'package:the_library_app/persistance/abstraction_layer/show_more_dao.dart';
import 'package:the_library_app/persistance/hive_constants.dart';

class ShowMoreDaoImpl extends ShowMoreDao{

  static final ShowMoreDaoImpl _singleton = ShowMoreDaoImpl._internal();

  factory ShowMoreDaoImpl(){
    return _singleton;
  }

  ShowMoreDaoImpl._internal();

  
  @override
  void saveAllShowMoreBooks(List<ShowMoreResultVO> showMoreBooks)async {
    Map<int,ShowMoreResultVO> mapData = Map.fromIterable(
        showMoreBooks,
        key: (book) => book.rank,
        value: (book) => book,
    );
  await getShowMoreBox().putAll(mapData);
  }

  @override
  List<ShowMoreResultVO> getAllShowMoreBooks() {
    return getShowMoreBox().values.toList();
  }

  ///Reactive

  @override
  Stream<void> getAllShowMoreBooksEventStream() {
    return getShowMoreBox().watch();
  }

  @override
  Stream<List<ShowMoreResultVO>> getAllShowMoreBooksStream() {
    return Stream.value(getAllShowMoreBooks());
  }

    @override
  List<ShowMoreResultVO> getAllShowMoreBooksData() {
    if(getAllShowMoreBooks() != null && getAllShowMoreBooks().isNotEmpty){
       print("Show More  output from database ==============> ${getAllShowMoreBooks()}");
        return getAllShowMoreBooks();
    }else{
      return [];
    }
  }

  Box<ShowMoreResultVO> getShowMoreBox(){
    return Hive.box<ShowMoreResultVO>(BOX_NAME_SHOW_MORE_RESULT_VO);
  }

}