import 'package:flutter_test/flutter_test.dart';
import 'package:the_library_app/pages/shelf_page.dart';
import 'package:the_library_app/view_items/shelf_text_view.dart';

import 'test_data/test_data.dart';

Future<void> shelfPageTest(WidgetTester tester)async{

  await tester.tap(find.byKey(SHELVES_VIEW_SHELF_KEY));
  await tester.pumpAndSettle(Duration(seconds: 5));

  expect(find.byType(ShelfPage),findsOneWidget);
  expect(find.byType(ShelfDetailAppBarView),findsOneWidget);
  expect(find.byKey(SHELF_PAGE_YOUR_BOOKS_VIEW_KEY),findsOneWidget);
  expect(find.text(SHELF_ONE_NAME),findsOneWidget);
  expect(find.text(BOOKS_IN_SHELF),findsOneWidget);

      ///Sort By
    await tester.tap(find.byKey(YOUR_BOOKS_SORT_BY_KEY));
    await tester.pumpAndSettle(Duration(seconds: 10));
    await tester.tap(find.byKey(SHELF_PAGE_SORT_BY_TITLE_TEST_KEY));
    await tester.pumpAndSettle(Duration(seconds: 10));

    await tester.tap(find.byKey(YOUR_BOOKS_SORT_BY_KEY));
    await tester.pumpAndSettle(Duration(seconds: 10));
    await tester.tap(find.byKey(SHELF_PAGE_SORT_BY_AUTHOR_TEST_KEY));
    await tester.pumpAndSettle(Duration(seconds: 10));


    await tester.tap(find.byKey(YOUR_BOOKS_SORT_BY_KEY));
    await tester.pumpAndSettle(Duration(seconds: 10));
    await tester.tap(find.byKey(SHELF_PAGE_SORT_BY_RECENT_TEST_KEY));
    await tester.pumpAndSettle(Duration(seconds: 10));


      ///List or Grid Sort
    await tester.ensureVisible(find.byKey(YOUR_BOOKS_LIST_OR_GRID));
    await tester.tap(find.byKey(YOUR_BOOKS_LIST_OR_GRID));
    await tester.pumpAndSettle(Duration(seconds: 10));
    await tester.tap(find.byKey(SHELF_PAGE_GRID_MEDIUM_VIEW_BOOKS_SORT_KEY));
    await tester.pumpAndSettle(Duration(seconds: 10));

   
    await tester.ensureVisible(find.byKey(YOUR_BOOKS_LIST_OR_GRID));
    await tester.tap(find.byKey(YOUR_BOOKS_LIST_OR_GRID));
    await tester.pumpAndSettle(Duration(seconds: 10));
    await tester.tap(find.byKey(SHELF_PAGE_GRID_LARGE_VIEW_BOOKS_SORT_KEY));
    await tester.pumpAndSettle(Duration(seconds: 10));

   
    await tester.ensureVisible(find.byKey(YOUR_BOOKS_LIST_OR_GRID));
    await tester.tap(find.byKey(YOUR_BOOKS_LIST_OR_GRID));
    await tester.pumpAndSettle(Duration(seconds: 10));
    await tester.tap(find.byKey(SHELF_PAGE_LIST_VIEW_BOOKS_SORT_KEY));
    await tester.pumpAndSettle(Duration(seconds: 10));


    ///Filter by chip
    await tester.tap(find.byKey(YOUR_BOOKS_CHIP_COMBINE));
    await tester.pumpAndSettle(Duration(seconds: 5));

    expect(find.text(BOOK_NAME_FOR_TEST_TWO),findsOneWidget);
    expect(find.text(BOOK_TWO_AUTHOR),findsOneWidget);

    await tester.tap(find.byKey(YOUR_BOOKS_CHIP_HEADCOVER));
    await tester.pumpAndSettle(Duration(seconds: 5));

    expect(find.text(BOOK_NAME_FOR_TEST),findsOneWidget);
    expect(find.text(BOOK_ONE_AUTHOR),findsOneWidget);

    await tester.tap(find.byKey(YOUR_BOOKS_CHIP_COMBINE));
    await tester.pumpAndSettle(Duration(seconds: 5));

    await tester.tap(find.byKey(YOUR_BOOKS_CANCEL_ALL_CHIPS));
    await tester.pumpAndSettle(Duration(seconds: 5));

    expect(find.text(BOOK_NAME_FOR_TEST),findsOneWidget);
    expect(find.text(BOOK_ONE_AUTHOR),findsOneWidget);
    expect(find.text(BOOK_NAME_FOR_TEST_TWO),findsOneWidget);
    expect(find.text(BOOK_TWO_AUTHOR),findsOneWidget);


    ///Rename
    await tester.tap(find.byKey(SHELF_PAGE_POP_UP_MENU_BTN_KEY));
    await tester.pumpAndSettle(Duration(seconds: 5));

    await tester.tap(find.byKey(CALL_RENAME_KEY));
    await tester.pumpAndSettle(Duration(seconds: 5));

    expect(find.byType(ShelfTextView),findsOneWidget);

    await tester.enterText(find.byKey(RENAME_SHELF_NAME_TEXT_FIELD_KEY), NEW_NAME_FOR_SHELF);
    await tester.pumpAndSettle(Duration(seconds: 5));

    await tester.tap(find.byKey(RENAME_SHELF_CONFIRM_KEY));
    await tester.pumpAndSettle(Duration(seconds: 5));

    expect(find.text(NEW_NAME_FOR_SHELF),findsOneWidget);

    ///Delete Shelf
    await tester.tap(find.byKey(SHELF_PAGE_POP_UP_MENU_BTN_KEY));
    await tester.pumpAndSettle(Duration(seconds: 5));

    await tester.tap(find.byKey(DELETE_SHELF_KEY));
    await tester.pumpAndSettle(Duration(seconds: 5));

    await tester.tap(find.byKey(CONFIRM_DELETE_KEY));
    await tester.pumpAndSettle(Duration(seconds: 5));

    expect(find.text(NO_SHELFS_SHOW_TEXT), findsOneWidget);

}