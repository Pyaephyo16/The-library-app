import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_library_app/pages/search_page.dart';
import 'package:the_library_app/view_items/book_name_and_info_view.dart';

import 'test_data/test_data.dart';

Future<void> searchBook(WidgetTester tester)async{

  await tester.tap(find.byKey(HOME_PAGE_SEARCH_BAR_KEY));
  await tester.pumpAndSettle();

  expect(find.byType(SearchPage),findsOneWidget);
  expect(find.byKey(SEARCH_PAGE_SEARCH_BAR_KEY),findsOneWidget);
  expect(find.byType(SarchFieldBottmIconView),findsOneWidget);

  await tester.enterText(find.byKey(SEARCH_BOOK_KEY), SEARCH_NAME);
  await tester.pumpAndSettle(Duration(seconds: 5));

  expect(find.byType(BookNameAndInfoView),findsWidgets);
  expect(find.text(SEARCH_ENGINE_BOOK_NAME_ONE),findsWidgets);
  expect(find.text(SEARCH_ENGINE_BOOK_AHTHOR_ONE),findsWidgets);
  expect(find.text(SEARCH_ENGINE_BOOK_NAME_TWO),findsOneWidget);

  await tester.testTextInput.receiveAction(TextInputAction.done);
  await tester.sendKeyDownEvent(LogicalKeyboardKey.enter);
  await tester.pumpAndSettle(Duration(seconds: 5));

   expect(find.byKey(SEARCH_RESULT_SHOW_KEY),findsWidgets);
   expect(find.text(SEARCH_RESULT_FIRST_LIST_TITLE),findsOneWidget);
   expect(find.text(SEARCH_RESULT_SECOND_LIST_TITLE),findsWidgets);

}