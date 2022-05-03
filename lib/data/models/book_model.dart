import 'package:the_library_app/data/vos/overview/book_list_vo.dart';
import 'package:the_library_app/data/vos/overview/result_vo.dart';
import 'package:the_library_app/data/vos/show_more/show_more_result_vo.dart';

abstract class BookModel{

  ///NetWork
  Future<ResultVO?> overViewBooks(String publishedDate);
  Future<List<ShowMoreResultVO>?> showMoreBooks(String list,String offset,String bestSellersDate,String publishedDate);


  ///Database
  Stream<ResultVO?> overViewBooksDatabase(String publishedDate);
  Stream<List<ShowMoreResultVO>> showMoreBooksDatabase(String list,String offset,String bestSellersDate,String publishedDate);

}