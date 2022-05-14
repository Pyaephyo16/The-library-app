import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_library_app/pages/Views/shelves_view.dart';

import 'test_data/test_data.dart';

Future<void> booksSortInYourBooksView(WidgetTester tester)async{

    await tester.tap(find.byKey(LIBRARY_TAB_ICON_KEY));
    await tester.pumpAndSettle(Duration(seconds: 5));

    expect(find.byKey(LIBRARY_TAB_TABBAR_KEY),findsOneWidget);
    expect(find.byKey(YOUR_BOOKS_VIEW_KEY), findsOneWidget);

    ///Sort By
    await tester.tap(find.byKey(YOUR_BOOKS_SORT_BY_KEY));
    await tester.pumpAndSettle(Duration(seconds: 10));
    await tester.tap(find.byKey(YOUR_BOOKS_SORT_BY_TITLE_KEY));
    await tester.pumpAndSettle(Duration(seconds: 10));


    await tester.tap(find.byKey(YOUR_BOOKS_SORT_BY_KEY));
    await tester.pumpAndSettle(Duration(seconds: 10));
    await tester.tap(find.byKey(YOUR_BOOKS_SORT_BY_AUTHOR_KEY));
    await tester.pumpAndSettle(Duration(seconds: 10));


    await tester.tap(find.byKey(YOUR_BOOKS_SORT_BY_KEY));
    await tester.pumpAndSettle(Duration(seconds: 10));
    await tester.tap(find.byKey(YOUR_BOOKS_SORT_BY_RECENT_KEY));
    await tester.pumpAndSettle(Duration(seconds: 10));


    ///List or Grid Sort
    await tester.ensureVisible(find.byKey(YOUR_BOOKS_LIST_OR_GRID));
    await tester.tap(find.byKey(YOUR_BOOKS_LIST_OR_GRID));
    await tester.pumpAndSettle(Duration(seconds: 15));
    await tester.tap(find.byKey(YOUR_BOOKS_BTM_GRID_MEDIUM));
    await tester.pumpAndSettle(Duration(seconds: 15));

   
    await tester.ensureVisible(find.byKey(YOUR_BOOKS_LIST_OR_GRID));
    await tester.tap(find.byKey(YOUR_BOOKS_LIST_OR_GRID));
    await tester.pumpAndSettle(Duration(seconds: 15));
    await tester.tap(find.byKey(YOUR_BOOKS_BTM_GRID_LARGE));
    await tester.pumpAndSettle(Duration(seconds: 15));

   
    await tester.ensureVisible(find.byKey(YOUR_BOOKS_LIST_OR_GRID));
    await tester.tap(find.byKey(YOUR_BOOKS_LIST_OR_GRID));
    await tester.pumpAndSettle(Duration(seconds: 15));
    await tester.tap(find.byKey(YOUR_BOOKS_BTM_LIST));
    await tester.pumpAndSettle(Duration(seconds: 15));

    ///Filter by chip
    await tester.tap(find.byKey(YOUR_BOOKS_CHIP_COMBINE));
    await tester.pumpAndSettle(Duration(seconds: 5));

    expect(find.text(BOOK_NAME_FOR_TEST),findsOneWidget);
    expect(find.text(BOOK_ONE_AUTHOR),findsOneWidget);

    await tester.tap(find.byKey(YOUR_BOOKS_CHIP_HEADCOVER));
    await tester.pumpAndSettle(Duration(seconds: 5));

    expect(find.text(BOOK_NAME_FOR_TEST_TWO),findsOneWidget);
    expect(find.text(BOOK_TWO_AUTHOR),findsOneWidget);

    await tester.tap(find.byKey(YOUR_BOOKS_CHIP_COMBINE));
    await tester.pumpAndSettle(Duration(seconds: 5));

    await tester.tap(find.byKey(YOUR_BOOKS_CANCEL_ALL_CHIPS));
    await tester.pumpAndSettle(Duration(seconds: 5));

    expect(find.text(BOOK_NAME_FOR_TEST),findsOneWidget);
    expect(find.text(BOOK_ONE_AUTHOR),findsOneWidget);
    expect(find.text(BOOK_NAME_FOR_TEST_TWO),findsOneWidget);
    expect(find.text(BOOK_TWO_AUTHOR),findsOneWidget);

}