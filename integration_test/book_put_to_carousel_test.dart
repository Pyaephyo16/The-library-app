import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_library_app/pages/book_detail_page.dart';
import 'package:the_library_app/pages/book_list_in_grid.dart';
import 'package:the_library_app/pages/tabs/home_tab.dart';
import 'package:the_library_app/resources/constants.dart';
import 'package:the_library_app/view_items/book_list_title_view.dart';

import 'test_data/test_data.dart';

Future<void> bookPutToCarouselTest(WidgetTester tester)async{


    await tester.tap(find.byKey(EBOOK_0_1_KEY));
    await tester.pumpAndSettle(Duration(seconds: 5));

    expect(find.byType(BookDetailPage), findsOneWidget);
    expect(find.byType(AppBarView), findsOneWidget);
    expect(find.byType(BookTitleAndCoverView), findsOneWidget);
    expect(find.byType(BookDetail), findsOneWidget);
    expect(find.byType(ButtonRowView), findsOneWidget);
    expect(find.byType(SwitchButtonView), findsOneWidget);
    expect(find.byType(AboutTheBookView), findsWidgets);
    expect(find.text(BOOK_NAME_FOR_TEST), findsOneWidget);
    expect(find.text(BOOK_ONE_AUTHOR),findsOneWidget);
    expect(find.byKey(DETAIL_PAGE_BOOK_LIST_TITLE_AND_SERIAL), findsOneWidget);

    await tester.tap(find.byKey(DETAIL_PAGE_POP_ICON_KEY));
    await tester.pumpAndSettle(Duration(seconds: 5));

    expect(find.byType(CarouselBookView), findsOneWidget);
    expect(find.byKey(EBOOK_0_1_KEY), findsWidgets);

    //await tester.drag(find.byKey(EBOOK_3_1_KEY), Offset(307.0, 1996.2));
    await tester.dragUntilVisible(find.byKey(EBOOK_3_1_KEY), find.byKey(EBOOK_3_1_KEY),  Offset(307.0, 1996.2));
    await tester.pumpAndSettle(Duration(seconds: 5));

    expect(find.text(EBOOK_LIST_TITLE_NAME_TWO), findsOneWidget);
    expect(find.text(BOOK_NAME_FOR_TEST_TWO), findsOneWidget);

    await tester.tap(find.byKey(EBOOK_3_1_KEY));
    await tester.pumpAndSettle(Duration(seconds: 5));

    expect(find.text(BOOK_NAME_FOR_TEST_TWO), findsOneWidget);
    expect(find.text(BOOK_TWO_AUTHOR),findsOneWidget);

    await tester.tap(find.byKey(DETAIL_PAGE_POP_ICON_KEY));
    await tester.pumpAndSettle(Duration(seconds: 5));

    await tester.tap(find.byKey(LIBRARY_TAB_ICON_KEY));
    await tester.pumpAndSettle(Duration(seconds: 5));

    expect(find.byKey(YOUR_BOOKS_VIEW_KEY), findsOneWidget);
    expect(find.text(BOOK_NAME_FOR_TEST), findsOneWidget);
    expect(find.text(BOOK_ONE_AUTHOR),findsOneWidget);
    expect(find.text(BOOK_NAME_FOR_TEST_TWO), findsOneWidget);
    expect(find.text(BOOK_TWO_AUTHOR),findsOneWidget);

    await tester.tap(find.byKey(HOME_TAB_ICON_KEY));
    await tester.pumpAndSettle(Duration(seconds: 5));

    expect(find.byType(CarouselBookView), findsOneWidget);

    // await tester.tap(find.byKey(SHOW_MORE_BUTTON_KEY));
    // await tester.pumpAndSettle(Duration(seconds: 5));
    // expect(find.byType(BookListInGrid), findsOneWidget);
    // expect(find.byType(BookListTitleView), findsOneWidget);
    // expect(find.text(BOOK_NAME_FOR_TEST_THREE), findsOneWidget);
    // await tester.tap(find.byKey(POP_FROM_SHOW_MORE));
    // await tester.pumpAndSettle(Duration(seconds: 5));

}