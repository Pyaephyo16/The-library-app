import 'package:the_library_app/data/vos/overview/book_vo.dart';
import 'package:the_library_app/data/vos/overview/result_vo.dart';
import 'package:the_library_app/persistance/abstraction_layer/overview_dao.dart';

import '../mock_data/mock_data.dart';

class OverViewDaoImplMock extends OverViewDao{

  Map<String,ResultVO> overViewBookDatabaseMock = {};


  @override
  void saveAllBookList(String date, ResultVO bookList) {
    overViewBookDatabaseMock[date] = bookList;
  }


  @override
  ResultVO? getAllBookList(String date) {
    return resultMockForTest();
  }

 @override
  Stream<void> getBookListEventStream() {
    return Stream<void>.value(null);
  }

  @override
  ResultVO? getAllBookListData(String date) {
    if(resultMockForTest() != null){
      return resultMockForTest();
    }
  }

  @override
  Stream<ResultVO?> getAllBookListStream(String date) {
    return Stream.value(resultMockForTest());
  }

}