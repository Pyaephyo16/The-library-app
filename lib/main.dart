import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:the_library_app/blocs/crate_shelf_page_bloc.dart';
import 'package:the_library_app/blocs/home_page_bloc.dart';
import 'package:the_library_app/blocs/search_page_bloc.dart';
import 'package:the_library_app/data/vos/overview/book_list_vo.dart';
import 'package:the_library_app/data/vos/overview/book_vo.dart';
import 'package:the_library_app/data/vos/overview/buy_link_vo.dart';
import 'package:the_library_app/data/vos/overview/result_vo.dart';
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
  Hive.registerAdapter(ShowMoreResultVOAdapter());

  await Hive.openBox<ResultVO>(BOX_NAME_RESULT_VO);
  await Hive.openBox<ShowMoreResultVO>(BOX_NAME_SHOW_MORE_RESULT_VO);

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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}

