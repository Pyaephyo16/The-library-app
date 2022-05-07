import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:the_library_app/blocs/book_detail_bloc.dart';
import 'package:the_library_app/blocs/crate_shelf_page_bloc.dart';
import 'package:the_library_app/blocs/home_page_bloc.dart';
import 'package:the_library_app/blocs/search_page_bloc.dart';
import 'package:the_library_app/blocs/shelf_bloc.dart';
import 'package:the_library_app/blocs/show_more_bloc.dart';
import 'package:the_library_app/blocs/your_books_bloc.dart';
import 'package:the_library_app/data/vos/google_search/access_info_vo.dart';
import 'package:the_library_app/data/vos/google_search/epub_vo.dart';
import 'package:the_library_app/data/vos/google_search/image_links_vo.dart';
import 'package:the_library_app/data/vos/google_search/industry_identifier_vo.dart';
import 'package:the_library_app/data/vos/google_search/panelization_summary_vo.dart';
import 'package:the_library_app/data/vos/google_search/pdf_vo.dart';
import 'package:the_library_app/data/vos/google_search/reading_modes_vo.dart';
import 'package:the_library_app/data/vos/google_search/sale_info_vo.dart';
import 'package:the_library_app/data/vos/google_search/search_info_vo.dart';
import 'package:the_library_app/data/vos/google_search/search_result_vo.dart';
import 'package:the_library_app/data/vos/google_search/volume_info_vo.dart';
import 'package:the_library_app/data/vos/overview/book_list_vo.dart';
import 'package:the_library_app/data/vos/overview/book_vo.dart';
import 'package:the_library_app/data/vos/overview/buy_link_vo.dart';
import 'package:the_library_app/data/vos/overview/result_vo.dart';
import 'package:the_library_app/data/vos/overview/show_more_list_for_hive_vo.dart';
import 'package:the_library_app/data/vos/show_more/book_details_vo.dart';
import 'package:the_library_app/data/vos/show_more/isbns_vo.dart';
import 'package:the_library_app/data/vos/show_more/reviews_vo.dart';
import 'package:the_library_app/data/vos/show_more/show_more_result_vo.dart';
import 'package:the_library_app/pages/book_detail_page.dart';
import 'package:the_library_app/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:the_library_app/persistance/hive_constants.dart';

void main() async{

  await Hive.initFlutter();

  Hive.registerAdapter(BookListVOAdapter());
  Hive.registerAdapter(BookVOAdapter());
  Hive.registerAdapter(BuyLinkVOAdapter());
  Hive.registerAdapter(ResultVOAdapter());
  Hive.registerAdapter(BookDetailsVOAdapter());
  Hive.registerAdapter(IsbnsVOAdapter());
  Hive.registerAdapter(ReviewsVOAdapter());
  Hive.registerAdapter(ShowMoreListForHiveVOAdapter());
  Hive.registerAdapter(AccessInfoVOAdapter());
  Hive.registerAdapter(EpubVOAdapter());
  Hive.registerAdapter(ImageLinksVOAdapter());
  Hive.registerAdapter(IndustryIdentifierVOAdapter());
  Hive.registerAdapter(PanelizationSummaryVOAdapter());
  Hive.registerAdapter(PdfVOAdapter());
  Hive.registerAdapter(ReadingModesAdapter());
  Hive.registerAdapter(SaleInfoVOAdapter());
  Hive.registerAdapter(SearchInfoVOAdapter());
  Hive.registerAdapter(SearchResultVOAdapter());
  Hive.registerAdapter(VolumeInfoVOAdapter());

  await Hive.openBox<ResultVO>(BOX_NAME_RESULT_VO);
  await Hive.openBox<ShowMoreListForHiveVO>(BOX_NAME_SHOW_MORE_LIST_FOR_HIVE_VO);
  await Hive.openBox<BookVO>(BOX_NAME_BOOK_LIST_FOR_CAROUSEL);

  runApp(
    MyApp(),
    );
}

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CreateShelfPageBloc()),
        ChangeNotifierProvider(create: (context) => HomePageBloc()),
        ChangeNotifierProvider(create: (context) => SearchPageBloc()),
        ChangeNotifierProvider(create: (context) => BookDetailBloc()),
        ChangeNotifierProvider(create: (context) => ShowMoreBloc()),
        ChangeNotifierProvider(create: (context) => YourBooksBloc()),
        ChangeNotifierProvider(create: (context) => ShelfBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}

