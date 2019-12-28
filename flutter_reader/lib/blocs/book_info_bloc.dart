import 'package:flutter_reader/beans/book_bean.dart';
import 'package:flutter_reader/beans/book_info_bean.dart';
import 'package:flutter_reader/beans/store_sex_bean.dart';
import 'package:flutter_reader/blocs/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class BookInfoBloc extends BaseBloc {
  //
  final _bookInfoFetcher = PublishSubject<BookInfoBean>();

  final _bookAddStateFetcher = PublishSubject<bool>();

  final BookSqlite _bookSqlite = BookSqlite();

  //监听
  Observable<bool> get addStoreState => _bookAddStateFetcher.stream;

  //监听
  Observable<BookInfoBean> get storeSexData => _bookInfoFetcher.stream;

  void fetchBookInfo(int bookId) async {
    BookInfoBean data = await netApi.fetchBookInfoData(bookId);
    if (!_bookInfoFetcher.isClosed) {

      _bookInfoFetcher.sink.add(data);
    }
  }

  void _changeAddState(bool value) {
    if (!_bookAddStateFetcher.isClosed) {
      _bookAddStateFetcher.sink.add(value);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _bookInfoFetcher?.close();
    _bookAddStateFetcher?.close();
  }

  void removeBook(int id) {
    _bookSqlite.delete(id).then((ret) {
      if (ret == 1) {
        _changeAddState(false);
      }
    });
  }

  void addBook(BookInfoBean _bookInfo) {
    BookBean book = BookBean();
    book.id = _bookInfo.data.id;
    book.name = _bookInfo.data.name;
    book.desc = _bookInfo.data.desc;
    book.img = _bookInfo.data.img;
    book.author = _bookInfo.data.author;
    book.updateTime = _bookInfo.data.lastTime;
    book.lastChapter = _bookInfo.data.lastChapter;
    book.lastChapterId = _bookInfo.data.lastChapterId.toString();
    book.cname = _bookInfo.data.cName;
    book.bookStatus = _bookInfo.data.bookStatus;
    _bookSqlite.insert(book).then((id) {
      if (id == _bookInfo.data.id) {
        _changeAddState(true);
      }
    });
  }

  void queryIsAdd(int id) {
    _bookSqlite.queryBookIsAdd(id).then((bool) {
      _changeAddState(bool);
    });
  }
}
