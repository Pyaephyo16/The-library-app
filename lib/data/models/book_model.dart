import 'package:the_library_app/data/vos/overview/book_list_vo.dart';
import 'package:the_library_app/data/vos/overview/book_vo.dart';
import 'package:the_library_app/data/vos/overview/result_vo.dart';
import 'package:the_library_app/data/vos/overview/show_more_list_for_hive_vo.dart';
import 'package:the_library_app/data/vos/show_more/show_more_result_vo.dart';

abstract class BookModel{

  ///NetWork
  Future<ResultVO?> overViewBooks(String publishedDate);
  Future<List<BookVO>?> showMoreBooks(String list,String offset,String bestSellersDate,String publishedDate);
  void putUserTapBook(String name,BookVO book);
  Future<List<BookVO>> searchBook(String name);


  ///Database
  Stream<ResultVO?> overViewBooksDatabase(String publishedDate);
  Stream<ShowMoreListForHiveVO?> showMoreBooksDatabase(String list,String offset,String bestSellersDate,String publishedDate);
  Stream<List<BookVO>> getUserTapBookDatabase();
  void deleteBooksFromCarouselDatabase();

}