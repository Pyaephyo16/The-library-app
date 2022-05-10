import 'package:stream_transform/stream_transform.dart';
import 'package:the_library_app/data/models/book_model.dart';
import 'package:the_library_app/data/vos/overview/book_list_vo.dart';
import 'package:the_library_app/data/vos/overview/book_vo.dart';
import 'package:the_library_app/data/vos/overview/result_vo.dart';
import 'package:the_library_app/data/vos/overview/show_more_list_for_hive_vo.dart';
import 'package:the_library_app/data/vos/shelf_vo.dart';
import 'package:the_library_app/data/vos/show_more/book_details_vo.dart';
import 'package:the_library_app/data/vos/show_more/show_more_result_vo.dart';
import 'package:the_library_app/network/app_constants.dart';
import 'package:the_library_app/network/data_agents/book_data_agent.dart';
import 'package:the_library_app/network/data_agents/retrofit_data_agent_impl.dart';
import 'package:the_library_app/persistance/abstraction_layer/book_list_for_carousel_dao.dart';
import 'package:the_library_app/persistance/abstraction_layer/overview_dao.dart';
import 'package:the_library_app/persistance/abstraction_layer/shelf_list_dao.dart';
import 'package:the_library_app/persistance/abstraction_layer/show_more_dao.dart';
import 'package:the_library_app/persistance/daos/book_list_for_carousel_dao_impl.dart';
import 'package:the_library_app/persistance/daos/overview_dao_impl.dart';
import 'package:collection/collection.dart';
import 'package:the_library_app/persistance/daos/shelf_list_dao_impl.dart';
import 'package:the_library_app/persistance/daos/show_more_dao_impl.dart';

class BookModelImpl extends BookModel{

  BookDataAgent dataAgent = RetrofitDataAgentImpl();

  ///Dao
  OverViewDao mOverView = OverViewDaoImpl();
  ShowMoreDao mShowMore = ShowMoreDaoImpl();
  BookListForCarouselDao mBookListCarousel = BookListForCarouselDaoImpl();
  ShelfListDao mShelf = ShelfListDaoImpl();

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
          List<BookListVO> tempOuter = value?.lists?.mapIndexed((indexOuter,outer){
              List<BookVO> tempInner = outer.books?.mapIndexed((indexInner,inner){
                  inner.time = "0";
                  inner.categoryForOverView = value.lists?[indexOuter].listName;
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
  Future<List<BookVO>?> showMoreBooks(String list, String offset, String bestSellersDate, String publishedDate) {
    print("Show more data Layer =================> $API_KEY_VALUE $list $offset $bestSellersDate $publishedDate");
    return dataAgent.showMoreBooks(API_KEY_VALUE, list, offset, bestSellersDate, publishedDate).then((value){
          List<BookVO> dataForBook = value?.first ?? [];
          dataForBook.forEach((element) {
              element.numResults = value?[1];
              print("Num result check ====================> ${value?[1]}");
          });
        List<BookVO> tempOuter = dataForBook.map((dataOuter){
                dataOuter.time = "0";
            List<BookDetailsVO> tempInner = dataOuter.bookDetails?.map((dataInner){
                dataInner.time = "0";
                return dataInner;
            }).toList() ?? [];
            return dataOuter;
        }).toList();

        ShowMoreListForHiveVO listData = ShowMoreListForHiveVO(bookList: tempOuter);
        mShowMore.saveAllShowMoreBooks(publishedDate,listData);
        return Future.value(tempOuter);
    }).catchError((error){
        print("Show more Data layer Error ==========> $error");
    });
  }

  
  @override
  void putUserTapBook(String name, BookVO book) {
    mBookListCarousel.saveUserTapBook(name, book);
  }

  @override
  List<BookVO> getSelectedBook(List<String> currentBox){
    return mBookListCarousel.getSelectedBook(currentBox);
  }

  @override
  List<BookVO> getSelectedShelf(List<String> currentBox,int shelfIndex){
    return mShelf.getSelectedShelf(currentBox,shelfIndex);
  }

  
  @override
  Future<List<BookVO>> searchBook(String name) {
    print("Search data layer ==========> $name");
    List<BookVO> temp = [];
   return dataAgent.searchBookResult(name).then((value){
      value?.forEach((element) {
        temp.add(BookVO(searchResult: element));
      });
      return Future.value(temp);
    }).catchError((error){
       print("Search Data layer Error ==========> $error");
    });
  }

  
  @override
  void createNewShelf(ShelfVO shelf) {
    print("save shelf data to database =============> ${shelf}");
    mShelf.createShelf(shelf);
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
  Stream<ShowMoreListForHiveVO?> showMoreBooksDatabase(String list,String offset,String bestSellersDate,String publishedDate) {
    this.showMoreBooks(list, offset, bestSellersDate, publishedDate);
    return mShowMore
      .getAllShowMoreBooksEventStream()
      .startWith(mShowMore.getAllShowMoreBooksStream(publishedDate))
      .map((event) => mShowMore.getAllShowMoreBooksData(publishedDate));
  }

  @override
  Stream<List<BookVO>> getUserTapBookDatabase() {
    return mBookListCarousel
    .getUserTapBookListEventStream()
    .startWith(mBookListCarousel.getUserTapBookListStream())
    .map((event) => mBookListCarousel.getUserTapBookListData());
  }

  @override
  Stream<BookVO?> getUserTapSingleBookDatabase(String name){
    return mBookListCarousel
    .getUserTapBookListEventStream()
    .startWith(mBookListCarousel.getUserTapSingleBookStream(name))
    .map((event) => mBookListCarousel.getUserTapSingleBookData(name));
  }

  @override
  void deleteBooksFromCarouselDatabase() {
    mBookListCarousel.deleteBooksFromCarousel();
  }


  @override
  void deleteSingleShelfDatabase(String id) {
    mShelf.deleteSingleShelf(id);
  }

  @override
  Stream<List<ShelfVO>> getAllShelfsDatabase(){
    return mShelf.
    shelfsEventStream()
    .startWith(mShelf.getAllShelfsStream())
    .map((event) => mShelf.getAllShelfsData());
  }

  @override
  List<ShelfVO> getAllShelfDb(){
    return mShelf.getAllShelfs();
  }

  
  // @override
  // Stream<ShelfVO?> getSingleShelfDatabase(String id) {
  //   return mShelf.
  //   shelfsEventStream()
  //   .startWith(mShelf.getShelfsByIdStream(id))
  //   .map((event) => mShelf.getShelfByIdData(id));
  // }


  @override
  void deleteAllShelfsDatabase() {
    mShelf.deleteAllShelfs();
  }


}