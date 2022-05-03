import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:the_library_app/network/app_constants.dart';
import 'package:the_library_app/network/response/overview_response.dart';
import 'package:the_library_app/network/response/show_more_response.dart';

part 'the_book_api.g.dart';

@RestApi(baseUrl: BASE_URL)
abstract class TheBookApi{

 factory TheBookApi(Dio dio) = _TheBookApi;

    @GET(END_POINT_OVERVIEW)
    Future<OverViewResponse> overViewBooks(
      @Query(API_KEY) String apiKey,
      @Query(PUBLISHED_DATE) String publishedDate,
    );

    @GET(END_POINT_VIEW_MORE)
    Future<ShowMoreResponse> showMoreBooks(
      @Query(API_KEY) String apiKey,
      @Query(LIST) String list,
      @Query(OFFSET) String offset,
      @Query(BESTSELLERS_DATE) String bestSellersDate,
      @Query(PUBLISHED_DATE) String publishedDate,
    );

}