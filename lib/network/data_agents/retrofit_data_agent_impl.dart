import 'package:dio/dio.dart';
import 'package:the_library_app/data/vos/google_search/search_result_vo.dart';
import 'package:the_library_app/data/vos/overview/book_list_vo.dart';
import 'package:the_library_app/data/vos/overview/book_vo.dart';
import 'package:the_library_app/data/vos/overview/result_vo.dart';
import 'package:the_library_app/data/vos/show_more/show_more_result_vo.dart';
import 'package:the_library_app/network/app_constants.dart';
import 'package:the_library_app/network/data_agents/book_data_agent.dart';
import 'package:the_library_app/network/search_api.dart';
import 'package:the_library_app/network/the_book_api.dart';

class RetrofitDataAgentImpl extends BookDataAgent{

  late TheBookApi bApi;
  late SearchApi sApi;

  static final RetrofitDataAgentImpl _singleton = RetrofitDataAgentImpl._internal();

  factory RetrofitDataAgentImpl(){
    return _singleton;
  }

  RetrofitDataAgentImpl._internal(){
      final dio = Dio();
      
      dio.options = BaseOptions(
        headers: {
          HEADER_ACCEPT: APPLICATION_JSON,
          HEADER_CONTENT_TYPE: APPLICATION_JSON,
      }
      );

    bApi = TheBookApi(dio);
    sApi = SearchApi(dio);
  }

  @override
  Future<ResultVO?> overViewBooks(String apiKey, String publishedDate){
    print("Over View network Layer =================> $apiKey $publishedDate");
    return bApi.overViewBooks(apiKey, publishedDate)
    .asStream()
    .map((event) => event.results)
    .first;
  }

  @override
  Future<List<dynamic>?> showMoreBooks(String apiKey, String list, String offset, String bestSellersDate, String publishedDate) {
    print("Show more network Layer =================> $apiKey $list $offset $bestSellersDate $publishedDate");
    return bApi.showMoreBooks(apiKey, list, offset, bestSellersDate, publishedDate)
    .asStream()
    .map((event) => [event.result,event.numResults])
    .first;
  }

  @override
  Future<List<SearchResultVO>?> searchBookResult(String name) {
     print("Search network Layer =================> $name");
    return sApi.searchBookResult(name)
    .asStream()
    .map((event) => event.items)
    .first;
  }

}