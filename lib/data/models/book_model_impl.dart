import 'package:stream_transform/stream_transform.dart';
import 'package:the_library_app/data/models/book_model.dart';
import 'package:the_library_app/data/vos/overview/book_list_vo.dart';
import 'package:the_library_app/data/vos/overview/book_vo.dart';
import 'package:the_library_app/data/vos/overview/result_vo.dart';
import 'package:the_library_app/data/vos/show_more/book_details_vo.dart';
import 'package:the_library_app/data/vos/show_more/show_more_result_vo.dart';
import 'package:the_library_app/network/app_constants.dart';
import 'package:the_library_app/network/data_agents/book_data_agent.dart';
import 'package:the_library_app/network/data_agents/retrofit_data_agent_impl.dart';
import 'package:the_library_app/persistance/abstraction_layer/overview_dao.dart';
import 'package:the_library_app/persistance/abstraction_layer/show_more_dao.dart';
import 'package:the_library_app/persistance/daos/overview_dao_impl.dart';
import 'package:collection/collection.dart';
import 'package:the_library_app/persistance/daos/show_more_dao_impl.dart';

class BookModelImpl extends BookModel{

  BookDataAgent dataAgent = RetrofitDataAgentImpl();

  ///Dao
  OverViewDao mOverView = OverViewDaoImpl();
  ShowMoreDao mShowMore = ShowMoreDaoImpl();

  static final BookModelImpl _singleton = BookModelImpl._internal();

  factory BookModelImpl(){
    return _singleton;
  }

  BookModelImpl._internal();

  ///Network

  @override
  Future<ResultVO?> overViewBooks(String publishedDate){
    print("Over View data layer ===============> $API_KEY_VALUE $publishedDate");
    return dataAgent.overViewBooks(API_KEY_VALUE, publishedDate).then((value){
          List<BookListVO> tempOuter = value?.lists?.map((outer){
              List<BookVO> tempInner = outer.books?.map((inner){
                  inner.time = "0";
                  return inner;
              }).toList() ?? [];
              return outer;
          }).toList() ?? [];
          mOverView.saveAllBookList(publishedDate,value ?? ResultVO.empty());
          return Future.value(value);
      }).catchError((error){
          print("Over View Data layer Error ==========> $error");
      });
  }

    @override
  Future<List<ShowMoreResultVO>?> showMoreBooks(String list, String offset, String bestSellersDate, String publishedDate) {
    print("Show more data Layer =================> $API_KEY_VALUE $list $offset $bestSellersDate $publishedDate");
    return dataAgent.showMoreBooks(API_KEY_VALUE, list, offset, bestSellersDate, publishedDate).then((value){
        List<ShowMoreResultVO> tempOuter = value?.map((dataOuter){
            List<BookDetailsVO> tempInner = dataOuter.bookDetails?.map((dataInner){
                dataInner.time = "0";
                return dataInner;
            }).toList() ?? [];
            return dataOuter;
        }).toList() ?? [];
        mShowMore.saveAllShowMoreBooks(value ?? []);
        return Future.value(value);
    }).catchError((error){
        print("Show more Data layer Error ==========> $error");
    });
  }

   
 


  ///Database

  @override
  Stream<ResultVO?> overViewBooksDatabase(String publishedDate){
    this.overViewBooks(publishedDate);
    return mOverView
      .getBookListEventStream()
      .startWith(mOverView.getAllBookListStream(publishedDate))
      .map((event) => mOverView.getAllBookListData(publishedDate));
  }

  @override
  Stream<List<ShowMoreResultVO>> showMoreBooksDatabase(String list,String offset,String bestSellersDate,String publishedDate) {
    this.showMoreBooks(list, offset, bestSellersDate, publishedDate);
    return mShowMore
      .getAllShowMoreBooksEventStream()
      .startWith(mShowMore.getAllShowMoreBooksStream())
      .map((event) => mShowMore.getAllShowMoreBooksData());
  }



  

}