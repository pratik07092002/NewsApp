import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newsapp/api/networkservice.dart';
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

  FutureOr<void> _bookmarks(BookmarkClickEvent event, Emitter<HomeState> emit) async{


  }
}

class BookemarkedEvent {
}
