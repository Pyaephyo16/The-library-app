import 'package:hive/hive.dart';
import 'package:the_library_app/data/vos/overview/show_more_list_for_hive_vo.dart';
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
  void saveAllShowMoreBooks(String date,ShowMoreListForHiveVO showMoreBooks)async {
    await getShowMoreBox().put(date,showMoreBooks);
  }

  @override
  ShowMoreListForHiveVO? getAllShowMoreBooks(String date) {
    return getShowMoreBox().get(date);
  }

  ///Reactive

  @override
  Stream<void> getAllShowMoreBooksEventStream() {
    return getShowMoreBox().watch();
  }

  @override
  Stream<ShowMoreListForHiveVO?> getAllShowMoreBooksStream(String date) {
    return Stream.value(getAllShowMoreBooks(date));
  }

    @override
  ShowMoreListForHiveVO? getAllShowMoreBooksData(String date) {
    if(getAllShowMoreBooks(date) != null){
      return getAllShowMoreBooks(date);
    }else{
      return ShowMoreListForHiveVO.empty();
    }
  }

  Box<ShowMoreListForHiveVO> getShowMoreBox(){
    return Hive.box<ShowMoreListForHiveVO>(BOX_NAME_SHOW_MORE_LIST_FOR_HIVE_VO);
  }

}