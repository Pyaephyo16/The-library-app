import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:the_library_app/network/app_constants.dart';
import 'package:the_library_app/network/response/google_search_response.dart';

part 'search_api.g.dart';

@RestApi(baseUrl: SEARCH_BASE_URL)
abstract class SearchApi{

  factory SearchApi(Dio dio) = _SearchApi;

  @GET(END_POINT_SEARCH)
  Future<GoogleSearchResponse> searchBookResult(
    @Query(NAME) String name,
  );

}