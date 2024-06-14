import 'package:equatable/equatable.dart';
import 'package:newsapp/model/article.dart';

abstract class ArticleState extends Equatable {
  const ArticleState();

  @override
  List<Object> get props => [];
}

class ArticleLoading extends ArticleState {}

class ArticleLoaded extends ArticleState {
  final List<Article> articles;

  const ArticleLoaded({required this.articles});

  @override
  List<Object> get props => [articles];
}

class ArticleError extends ArticleState {
  final String error;

  const ArticleError(this.error);

  @override
  List<Object> get props => [error];
}
