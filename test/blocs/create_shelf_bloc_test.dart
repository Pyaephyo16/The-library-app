import 'package:flutter_test/flutter_test.dart';
import 'package:the_library_app/blocs/crate_shelf_page_bloc.dart';

import '../models/book_model_impl_mock.dart';

void main(){

  group("Create shelf bloc test",(){

    CreateShelfPageBloc? createBloc;

    setUp((){
      createBloc = CreateShelfPageBloc(model: BookModelImplMock());
    });


  });

}