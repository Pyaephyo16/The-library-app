import 'package:the_library_app/data/vos/overview/show_more_list_for_hive_vo.dart';
import 'package:the_library_app/persistance/abstraction_layer/show_more_dao.dart';

import '../mock_data/mock_data.dart';

class ShowMoreDaoImplMock extends ShowMoreDao{

  Map<String,ShowMoreListForHiveVO> showMoreDatabaseMock = {};


   @override
  void saveAllShowMoreBooks(String date, ShowMoreListForHiveVO showMoreBooks) {
      showMoreDatabaseMock[date] = showMoreBooks;
  }

  @override
  ShowMoreListForHiveVO? getAllShowMoreBooks(String date) {
     return showMoreListForHiveMockForTest();
  }

  @override
  Stream<void> getAllShowMoreBooksEventStream() {
    return Stream<void>.value(null);
  }

  @override
  ShowMoreListForHiveVO? getAllShowMoreBooksData(String date) {
    if(showMoreListForHiveMockForTest() != null){
      return showMoreListForHiveMockForTest();
    }
  }


  @override
  Stream<ShowMoreListForHiveVO?> getAllShowMoreBooksStream(String date) {
    return Stream.value(showMoreListForHiveMockForTest());
  }

}