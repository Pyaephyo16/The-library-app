import 'package:flutter_test/flutter_test.dart';
import 'package:the_library_app/pages/Views/shelves_view.dart';
import 'package:the_library_app/pages/add_to_shelf_page.dart';
import 'package:the_library_app/pages/create_shelf_page.dart';
import 'package:the_library_app/widgets/shelf_creation_section.dart';

import 'test_data/test_data.dart';

Future<void> createNewShelf(WidgetTester tester)async{

    await tester.tap(find.byKey(SHELVES_TAB_KEY));
    await tester.pumpAndSettle(Duration(seconds: 5));

    expect(find.text(NO_SHELFS_SHOW_TEXT), findsOneWidget);
    expect(find.byType(ShelfCreateBtnTextView),findsOneWidget);

    await tester.tap(find.byType(ShelfCreateBtnTextView));
    await tester.pumpAndSettle(Duration(seconds: 5));

    expect(find.byType(CreateShelfPage),findsOneWidget);
    expect(find.byType(shelfCreateSection),findsOneWidget);

    await tester.enterText(find.byKey(CREATE_SHELF_KEY), SHELF_ONE_NAME);
    await tester.pumpAndSettle(Duration(seconds: 5));

    await tester.tap(find.byKey(CREATE_SHELF_CONFIRM_KEY));
    await tester.pumpAndSettle(Duration(seconds: 5));

    expect(find.byType(ShelvesView), findsOneWidget);
    expect(find.text(SHELF_ONE_NAME),findsOneWidget);

    await tester.tap(find.byKey(YOUR_BOOKS_TAB_KEY));
    await tester.pumpAndSettle(Duration(seconds: 15));

     ///Book one add
    await tester.tap(find.byKey(YOUR_BOOKS_LIST_ELLIPIS_KEY_ONE));
    await tester.pumpAndSettle(Duration(seconds: 15));
    
    await Future.delayed(Duration(seconds: 6));
    await tester.ensureVisible(find.byKey(LIB_TAB_OPTION_4_KEY));
    await tester.tap(find.byKey(LIB_TAB_OPTION_4_KEY));
    await tester.pumpAndSettle(Duration(seconds: 5));

    expect(find.byType(AddToShelfPage),findsOneWidget);
    expect(find.text(ADD_TO_SHELF_TITLE_TEXT),findsOneWidget);

    await tester.tap(find.byKey(ADD_TO_SHELF_KEY));
    await tester.pumpAndSettle(Duration(seconds: 5));

    ///Book two add
    await tester.tap(find.byKey(YOUR_BOOKS_LIST_ELLIPIS_KEY_TWO));
    await tester.pumpAndSettle(Duration(seconds: 15));

    await Future.delayed(Duration(seconds: 6));
    await tester.ensureVisible(find.byKey(LIB_TAB_OPTION_4_KEY));
    await tester.tap(find.byKey(LIB_TAB_OPTION_4_KEY));
    await tester.pumpAndSettle(Duration(seconds: 5));

    expect(find.byType(AddToShelfPage),findsOneWidget);
    expect(find.text(ADD_TO_SHELF_TITLE_TEXT),findsOneWidget);

    await tester.tap(find.byKey(ADD_TO_SHELF_KEY));
    await tester.pumpAndSettle(Duration(seconds: 5));

    await tester.tap(find.byKey(SHELVES_TAB_KEY));
    await tester.pumpAndSettle(Duration(seconds: 5));

    expect(find.text(BOOKS_IN_SHELF),findsOneWidget);



}