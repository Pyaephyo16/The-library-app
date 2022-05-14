import 'package:flutter_test/flutter_test.dart';
import 'package:the_library_app/blocs/add_to_shelf_bloc.dart';

import '../mock_data/mock_data.dart';
import '../models/book_model_impl_mock.dart';

void main(){

  group("Add to shelf bloc test",(){

    AddToShelfBloc? addBloc;

    setUp((){
      addBloc = AddToShelfBloc(model: BookModelImplMock());
    });


    test("get all shelfs from database test",(){
      expect(
        addBloc?.shelfs,
         shelfListMockForTest(),
         );
    });

  });

}