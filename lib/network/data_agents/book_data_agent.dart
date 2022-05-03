import 'package:the_library_app/data/vos/overview/book_list_vo.dart';
import 'package:the_library_app/data/vos/overview/result_vo.dart';
import 'package:the_library_app/data/vos/show_more/show_more_result_vo.dart';

abstract class BookDataAgent{

  Future<ResultVO?> overViewBooks(String apiKey,String publishedDate);
  Future<List<ShowMoreResultVO>?> showMoreBooks(String apiKey,String list,String offset,String bestSellersDate,String publishedDate);

}