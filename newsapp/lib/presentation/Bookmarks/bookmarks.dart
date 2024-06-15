import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/presentation/Bookmarks/bloc/article_bloc.dart';
import 'package:newsapp/presentation/Bookmarks/bloc/article_event.dart';
import 'package:newsapp/presentation/Bookmarks/bloc/article_state.dart';
import 'package:newsapp/presentation/NewsDetailsScreen/NewsDetailsScreen.dart';

class SavedArticlesScreen extends StatelessWidget {
  const SavedArticlesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ArticleBloc()..add(FetchArticles()),
      child: SavedArticlesScreenView(),
    );
  }
}

class SavedArticlesScreenView extends StatefulWidget {
  @override
  State<SavedArticlesScreenView> createState() => _SavedArticlesScreenViewState();
}

class _SavedArticlesScreenViewState extends State<SavedArticlesScreenView>  with SingleTickerProviderStateMixin{
 late AnimationController _animatedContainer ;

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animatedContainer = AnimationController(vsync: this , duration: Duration(seconds: 1 )  , reverseDuration: Duration(milliseconds: 600) );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ArticleBloc, ArticleState>(
        builder: (context, state) {
          if (state is ArticleLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ArticleLoaded) {
            final articles = state.articles;
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return ListTile(
                  title: Text(article.author != null ? article.author.toString() : "Author"),
                  subtitle: Text(
                              article.description != null ? article.description.toString() : "description",
                              overflow: TextOverflow.ellipsis,
                            ),
                  leading: article.urlToImage != null
                                ? Container(
                                    height: MediaQuery.of(context).size.width * 0.1,
                                    width: MediaQuery.of(context).size.height * 0.05,
                                    child: Image.network(article.urlToImage.toString()),
                                  )
                                : Container(
                                    height: MediaQuery.of(context).size.width * 0.1,
                                    width: MediaQuery.of(context).size.height * 0.05,
                                    color: Colors.grey,
                                  ),
                                  onTap: () => showModalBottomSheet(
                                    
                                context: context,
                                builder: (context) => Container(
                                  height: MediaQuery.of(context).size.height * 0.95,
                                  child: NewsDetails(
                                    url: article.url.toString(),
                                    date: article.publishedAt.toString(),
                                    author: article.author.toString(),
                                    title: article.title.toString(),
                                    desc: article.description.toString(),
                                    imageurl: article.urlToImage.toString(),
                                    content: article.content,
                                  ),
                                ),
                                isScrollControlled: true,
                                transitionAnimationController: _animatedContainer
                                
                              )
                );
              },
            );
          } else if (state is ArticleError) {
            return Center(
              child: Text('Error: ${state.error}'),
            );
          } else {
            return Text('Something went wrong...');
          }
        },
      ),
    );
  }
}
