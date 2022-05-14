import 'package:flutter_test/flutter_test.dart';
import 'package:the_library_app/data/models/book_model.dart';
import 'package:the_library_app/data/models/book_model_impl.dart';
import 'package:the_library_app/data/vos/overview/book_vo.dart';
import 'package:the_library_app/data/vos/overview/show_more_list_for_hive_vo.dart';
import 'package:the_library_app/data/vos/show_more/book_details_vo.dart';

import '../mock_data/mock_data.dart';
import '../network/retrofit_data_agent_impl_mock.dart';
import '../persistance/book_list_for_carousel_dao_impl_mock.dart';
import '../persistance/over_dao_impl_mock.dart';
import '../persistance/shelf_list_dao_impl_mock.dart';
import '../persistance/show_more_dao_impl_mock.dart';

void main(){

  group("Book Model Impl Test",(){

    var bookModel = BookModelImpl();

    setUp((){
      bookModel.setDaosAndDataAgent(
        OverViewDaoImplMock(),
        ShowMoreDaoImplMock(),
        BookListForCarouselDaoImplMock(),
        ShelfListDaoImplMock(),
        RetrofitDataAgentImplMock(),
     );
    });


    test("Overview books test",(){
      expect(
        bookModel.overViewBooksDatabase("2022-05-11"),
         emits(
           resultMockForTest(),
         )
         );
    });


    test("Show more books test",(){
      expect(
        bookModel.showMoreBooksDatabase("Combined Print and E-Book Fiction","0", "2022-04-30", "2022-05-11"), 
        emits(
          showMoreListForHiveMockForTest(),
        )
      );
    });



    test("User Tap book put to Carousel database test",(){
      bookModel.putUserTapBook("IT ENDS WITH US",putBookToCarouselDatabase());
      Future.delayed(Duration(seconds: 3));
      expect(
        bookModel.getUserTapBookDatabase(),
        emits(
           bookListForCarouselMockForTest(),
        )
         );
    });


    test("Create shelf test",(){
        bookModel.createNewShelf(createShelfToDatabase());
        Future.delayed(Duration(seconds: 3));
        expect(
          bookModel.getAllShelfsDatabase(),
           emits(
            shelfListMockForTest(),
           )
        );
        expect(
          bookModel.getAllShelfDb(),
            [createShelfToDatabase()],
           );
    });


    test("Search book test",(){
      expect(
        bookModel.searchBook("flutter"),
         completion(
           equals(
            [
              searBookMock(),
            ]
           )
         )
         );
    });


    test("User selected book in carousel List test",(){
        expect(
          bookModel.getSelectedBook(["Combined Print and E-Book Fiction"]),
           [
             BookVO(
          numResults: 0,
         ageGroup: "",
         amazonProductUrl: "",
         articleChapterLink: "",
         author: "Colleen Hoover",
         bookImage: "https://storage.googleapis.com/du-prd/books/images/9781501110375.jpg",
         bookImageWidth: 319,
         bookImageHeight: 495,
         bookReviewLink: "",
         contributor: "by Colleen Hoover",
         contributorNote: "",
         createdDate: "2022-05-04 22:04:26",
         description: "A battered wife raised in a violent home attempts to halt the cycle of abuse.",
         firstChapterLink: "",
         price: "0.00",
         primaryIsbn10: "1501110365",
         primaryIsbn13: "9781501110368",
         bookUri: "nyt://book/e2a3545e-e9cb-5828-9d97-50a798a0e4f6",
         publisher: "Atria",
         rank: 1,
         rankLastWeek: 3,
         sundayReviewLink: "",
         title: "IT ENDS WITH US",
         updatedDate: "2022-05-04 22:09:03",
         weeksOnList: 46,
         buyLinks: [],
         categoryForOverView: "Combined Print and E-Book Fiction",
         time: "0",
         listName: null,
         displayName: null,
         bestsellersDate: null,
         publishedDate: null,
         asterisk: null,
         dagger: null,
         isbns: null,
         bookDetails: null,
         reviews: null,
         searchResult: null,
       ),
           ],
           );
    });


    test("user select book in shelf test",(){
      expect(
        bookModel.getSelectedShelf(["Combined Print and E-Book Fiction"], 0),
         [
            BookVO(
          numResults: 0,
         ageGroup: "",
         amazonProductUrl: "",
         articleChapterLink: "",
         author: "Colleen Hoover",
         bookImage: "https://storage.googleapis.com/du-prd/books/images/9781501110375.jpg",
         bookImageWidth: 319,
         bookImageHeight: 495,
         bookReviewLink: "",
         contributor: "by Colleen Hoover",
         contributorNote: "",
         createdDate: "2022-05-04 22:04:26",
         description: "A battered wife raised in a violent home attempts to halt the cycle of abuse.",
         firstChapterLink: "",
         price: "0.00",
         primaryIsbn10: "1501110365",
         primaryIsbn13: "9781501110368",
         bookUri: "nyt://book/e2a3545e-e9cb-5828-9d97-50a798a0e4f6",
         publisher: "Atria",
         rank: 1,
         rankLastWeek: 3,
         sundayReviewLink: "",
         title: "IT ENDS WITH US",
         updatedDate: "2022-05-04 22:09:03",
         weeksOnList: 46,
         buyLinks: [],
         categoryForOverView: "Combined Print and E-Book Fiction",
         time: "0",
         listName: null,
         displayName: null,
         bestsellersDate: null,
         publishedDate: null,
         asterisk: null,
         dagger: null,
         isbns: null,
         bookDetails: null,
         reviews: null,
         searchResult: null,
       ),
         ]
         );
    });


  });

}