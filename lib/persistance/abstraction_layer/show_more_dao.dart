import 'package:the_library_app/data/vos/show_more/show_more_result_vo.dart';

abstract class ShowMoreDao{

  void saveAllShowMoreBooks(List<ShowMoreResultVO> showMoreBooks);
  List<ShowMoreResultVO> getAllShowMoreBooks();

  Stream<void> getAllShowMoreBooksEventStream();
  List<ShowMoreResultVO> getAllShowMoreBooksData();
  Stream<List<ShowMoreResultVO>> getAllShowMoreBooksStream();

}