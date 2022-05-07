import 'package:the_library_app/data/vos/overview/show_more_list_for_hive_vo.dart';
import 'package:the_library_app/data/vos/show_more/show_more_result_vo.dart';

abstract class ShowMoreDao{

  void saveAllShowMoreBooks(String date,ShowMoreListForHiveVO showMoreBooks);
  ShowMoreListForHiveVO? getAllShowMoreBooks(String date);

  Stream<void> getAllShowMoreBooksEventStream();
  ShowMoreListForHiveVO? getAllShowMoreBooksData(String date);
  Stream<ShowMoreListForHiveVO?> getAllShowMoreBooksStream(String date);

}