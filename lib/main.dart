import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_library_app/blocs/crate_shelf_page_bloc.dart';
import 'package:the_library_app/blocs/home_page_bloc.dart';
import 'package:the_library_app/blocs/search_page_bloc.dart';
import 'package:the_library_app/pages/book_detail_page.dart';
import 'package:the_library_app/pages/home_page.dart';

void main() {
  runApp(
    MyApp(),
    );
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

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

