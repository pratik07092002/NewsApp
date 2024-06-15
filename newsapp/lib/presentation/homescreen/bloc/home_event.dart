part of 'home_bloc.dart';

class HomeEvent  extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HomeUpdateEvent extends HomeEvent{}

class SearchTextEvent extends HomeEvent{
 final String SearchText;

  SearchTextEvent({required this.SearchText});
}
class BookmarkedEvent extends HomeEvent {
  final String articleIndex;

   BookmarkedEvent({required this.articleIndex});

  @override
  List<Object> get props => [articleIndex];
}

class BookmarkClickEvent extends HomeEvent{
   final String? author;
  final String? title;
  final String? desc;
  final String imageurl;
  final String? content;
  final String? url;
  final String? date;

  BookmarkClickEvent({required this.author, required this.title, required this.desc, required this.imageurl, required this.content, required this.url, required this.date});
}
class LoadBookmarksEvent extends HomeEvent{}