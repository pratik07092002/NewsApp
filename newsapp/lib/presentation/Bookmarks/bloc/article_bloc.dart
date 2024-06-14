import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:newsapp/model/article.dart';
import 'package:newsapp/presentation/Bookmarks/bloc/article_event.dart';
import 'package:newsapp/presentation/Bookmarks/bloc/article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
    final _articles = <Article>[];

  ArticleBloc() : super(ArticleLoading()) {
    on<FetchArticles>(_onFetchArticles);
  }

  Future<void> _onFetchArticles(FetchArticles event, Emitter<ArticleState> emit) async {
    emit(ArticleLoading());
    try {
      await Future.delayed(Duration(seconds: 2));
     final box = await Hive.openBox<Article>('articles');
        _articles.clear();
        _articles.addAll(box.values);
        emit(ArticleLoaded(articles: _articles));
    } catch (e) {
      emit(ArticleError(e.toString()));
    }
  }
}
