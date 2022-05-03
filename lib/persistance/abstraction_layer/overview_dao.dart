import 'package:the_library_app/data/vos/overview/book_list_vo.dart';
import 'package:the_library_app/data/vos/overview/result_vo.dart';

abstract class OverViewDao{

  void saveAllBookList(String date,ResultVO bookList);
  ResultVO? getAllBookList(String date);

  Stream<void> getBookListEventStream();
  ResultVO? getAllBookListData(String date);
  Stream<ResultVO?> getAllBookListStream(String date);

}