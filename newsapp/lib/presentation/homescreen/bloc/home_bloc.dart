import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:newsapp/api/networkservice.dart';
import 'package:newsapp/model/article.dart';
import 'package:newsapp/model/articlemod.dart';
import 'package:newsapp/utils/status.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  NetworkService networkservice = NetworkService();

  HomeBloc() : super(HomeState()) {
    on<HomeUpdateEvent>(_fetchdata);
    on<SearchTextEvent>(_searchNews);
    on<BookmarkClickEvent>(_bookmarks );
    on<LoadBookmarksEvent>(_loadBookmarks);
  }

  FutureOr<void> _fetchdata(HomeEvent event, Emitter<HomeState> emit) async {
    emit(state.CopyWith(statussi: Statuss.loading));
    try {
      print("Fetching data...");

      final value = await networkservice.fetchHeadlinesApi();
      print("Fetched value: $value");

      emit(state.CopyWith(
        OriginalListi: value,
        statussi: Statuss.success,
        msgi: "Successfully updated list",
      ));
    } catch (error) {
      print("Error occurred: $error");

      emit(state.CopyWith(
        statussi: Statuss.failure,
        msgi: "Error occurred",
      ));
    }
  }

  FutureOr<void> _searchNews(SearchTextEvent event, Emitter<HomeState> emit) async {
    List<ArticleModel> updatedList = state.OriginalList.map((articleModel) {
      List<Articles> filteredArticles = articleModel.articles!.where((article) {
        return (article.title?.toLowerCase().contains(event.SearchText.toLowerCase()) ?? false) ||
               (article.author?.toLowerCase().contains(event.SearchText.toLowerCase()) ?? false) ||
               (article.description?.toLowerCase().contains(event.SearchText.toLowerCase()) ?? false) ||
               (article.content?.toLowerCase().contains(event.SearchText.toLowerCase()) ?? false);
      }).toList();

      return ArticleModel(
        status: articleModel.status,
        totalResults: articleModel.totalResults,
        articles: filteredArticles,

      
      );
    }).where((articleModel) => articleModel.articles!.isNotEmpty).toList();

    emit(state.CopyWith(
      UpdatedListi: updatedList,
      statussi: Statuss.success,
      msgi: "Search results updated",
    ));
  }
 Future<void> _loadBookmarks(LoadBookmarksEvent event, Emitter<HomeState> emit) async {
    final box = await Hive.openBox<Article>('articles');
    final Map<String, bool> bookmarkedArticles = {};

    for (var article in box.values) {
      bookmarkedArticles[article.url!] = true;
    }

    emit(state.CopyWith(bookmarkedArticles: bookmarkedArticles, statussi: Statuss.loaded));
  }
 FutureOr<void> _bookmarks(BookmarkClickEvent event, Emitter<HomeState> emit) async {
  final box = await Hive.openBox<Article>('articles');
  bool checkurl = box.values.any((element) => element.url == event.url);

  print("box data: ${box.get(1)}");

  if (!checkurl) {
    // Article does not exist, add it
    final hiveArticle = Article(
      author: event.author,
      title: event.title,
      description: event.desc,
      url: event.url,
      urlToImage: event.imageurl,
      publishedAt: event.date,
      content: event.content,
    );
    await box.add(hiveArticle);
    print("Hive Article: ${hiveArticle}");
    
    final newBookmarkedArticles = Map<String, bool>.from(state.bookmarkedArticles)
      ..[event.url.toString()] = true;

    emit(state.CopyWith(bookmarkedArticles: newBookmarkedArticles));
  } else {
    // Article exists, remove it
    final key = box.keys.firstWhere(
      (key) => box.get(key)?.url == event.url,
      orElse: () => -1,
    );
    print("Key is: ${key}");
    if (key != -1) {
      await box.delete(key);
    }
    
    final newBookmarkedArticles = Map<String, bool>.from(state.bookmarkedArticles)
      ..[event.url.toString()] = false;

    emit(state.CopyWith(bookmarkedArticles: newBookmarkedArticles));
  }
}

}

