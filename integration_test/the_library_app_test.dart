import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:integration_test/integration_test.dart';
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
import 'package:the_library_app/data/vos/shelf_vo.dart';
import 'package:the_library_app/data/vos/show_more/book_details_vo.dart';
import 'package:the_library_app/data/vos/show_more/isbns_vo.dart';
import 'package:the_library_app/data/vos/show_more/reviews_vo.dart';
import 'package:the_library_app/main.dart';
import 'package:the_library_app/pages/Views/audiobook_view.dart';
import 'package:the_library_app/pages/Views/ebooks_view.dart';
import 'package:the_library_app/pages/Views/shelves_view.dart';
import 'package:the_library_app/pages/book_detail_page.dart';
import 'package:the_library_app/pages/home_page.dart';
import 'package:the_library_app/pages/tabs/home_tab.dart';
import 'package:the_library_app/persistance/hive_constants.dart';
import 'package:the_library_app/view_items/search_field_section.dart';

import 'book_put_to_carousel_test.dart';
import 'books_sort_in_your_books_view.dart';
import 'create_new_shelf.dart';
import 'search_book.dart';
import 'shelf_page_test.dart';
import 'test_data/test_data.dart';

void main()async{

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  
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
  Hive.registerAdapter(ShelfVOAdapter());

  await Hive.openBox<ResultVO>(BOX_NAME_RESULT_VO);
  await Hive.openBox<ShowMoreListForHiveVO>(BOX_NAME_SHOW_MORE_LIST_FOR_HIVE_VO);
  await Hive.openBox<BookVO>(BOX_NAME_BOOK_LIST_FOR_CAROUSEL);
  await Hive.openBox<ShelfVO>(BOX_NAME_SHELF_VO);


  testWidgets("The library app test", (WidgetTester tester)async{

      await tester.pumpWidget(MyApp());
      await Future.delayed(Duration(seconds: 2));

      await tester.pumpAndSettle(Duration(seconds: 5));

    ///Home Page
    expect(find.byType(HomePage),findsOneWidget);
    expect(find.byKey(HOME_PAGE_SEARCH_BAR_KEY), findsOneWidget);
    expect(find.byKey(HOME_PAGE_BOTTOM_NAVIGATION_BAR),findsOneWidget);

    ///Home Tab
    expect(find.byType(HomeTab),findsOneWidget);
    expect(find.byType(NoBookViewInCarousel), findsOneWidget);
    expect(find.byKey(HOMETAB_TAB_BAR), findsOneWidget);
    expect(find.byType(EbooksView), findsOneWidget);

    expect(find.text(EBOOK_LIST_TITLE_NAME), findsOneWidget);
    expect(find.text(BOOK_NAME_FOR_TEST),findsWidgets);

    await bookPutToCarouselTest(tester);
    
    await booksSortInYourBooksView(tester);

    await createNewShelf(tester);

    await shelfPageTest(tester);

   await searchBook(tester);

  });

}