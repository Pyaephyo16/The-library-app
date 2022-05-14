import 'package:the_library_app/data/vos/overview/result_vo.dart';
import 'package:the_library_app/data/vos/google_search/search_result_vo.dart';
import 'package:the_library_app/network/data_agents/book_data_agent.dart';

import '../mock_data/mock_data.dart';

class RetrofitDataAgentImplMock extends BookDataAgent{

  @override
  Future<ResultVO?> overViewBooks(String apiKey, String publishedDate) {
    return Future.value(resultMockForTest());
  }

  @override
  Future<List<SearchResultVO>?> searchBookResult(String name) {
    return Future.value(searchResultVOMockForTest());
  }

  @override
  Future<List?> showMoreBooks(String apiKey, String list, String offset, String bestSellersDate, String publishedDate) {
    return Future.value([showMoreMockForTest(),1]);
  }



}