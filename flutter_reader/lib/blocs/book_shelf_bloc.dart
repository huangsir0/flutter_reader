import 'package:flutter_reader/beans/book_bean.dart';
import 'package:flutter_reader/blocs/base_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class BookShelfBloc extends BaseBloc {
  final _bookShelfFetcher = PublishSubject<List<BookBean>>();

  BookSqlite _bookSqlite = new BookSqlite();

  //监听
  Observable<List<BookBean>> get bookShelf => _bookShelfFetcher.stream;

  void fetcherBooks() async {
    _bookSqlite.queryAll().then((books) {
      if (null != books) {
        if (!_bookShelfFetcher.isClosed) {
          _bookShelfFetcher.sink.add(books);
        }
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _bookShelfFetcher.close();
    _bookSqlite.close();
  }

  void updateBook(int bookId) {
    netApi.fetchBookInfoData(bookId).then((_bookInfo) {
      if (_bookInfo != null) {
        _bookSqlite.getBook(_bookInfo.data.id).then((book) {
          BookBean _book = BookBean();
          _book.id = _bookInfo.data.id;
          _book.position = book.position;
          _book.name = _bookInfo.data.name;
          _book.desc = _bookInfo.data.desc;
          _book.img = _bookInfo.data.img;
          _book.author = _bookInfo.data.author;
          _book.updateTime = _bookInfo.data.lastTime;
          _book.lastChapter = _bookInfo.data.lastChapter;
          _book.lastChapterId = _bookInfo.data.lastChapterId.toString();
          _book.cname = _bookInfo.data.cName.toString();
          _book.bookStatus = _bookInfo.data.bookStatus.toString();
          _bookSqlite.update(_book).then((ret) {});
        });
      }
    });
  }

  void deleteBook(int bookId) {
    _bookSqlite.delete(bookId);
  }
}
