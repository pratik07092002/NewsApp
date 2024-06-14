import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:newsapp/model/article.dart';
import 'package:newsapp/presentation/NewsDetailsScreen/NewsDetailsScreen.dart';
import 'package:newsapp/presentation/homescreen/bloc/home_bloc.dart';
import 'package:newsapp/utils/status.dart';
import 'package:newsapp/widgets/customtextform.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(HomeUpdateEvent()),
      child: HomePageView(),
    );
  }
}

class HomePageView extends StatefulWidget {
  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  TextEditingController _searchcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          switch (state.Status) {
            case Statuss.failure:
              return Center(child: Text(state.Message));
            case Statuss.loading:
              return Center(child: CircularProgressIndicator());
            case Statuss.success:
              final articles = state.UpdatedList.isEmpty
                  ? state.OriginalList.expand((model) => model.articles!).toList()
                  : state.UpdatedList.expand((model) => model.articles!).toList();

              return Column(
                children: [
                  CustomTextForm(
                    hinttext: "Search News",
                    prefixicon: Icon(Icons.search),
                    obscure: false,
                    controller: _searchcontroller,
                    onChanged: (value) => context.read<HomeBloc>().add(
                          SearchTextEvent(SearchText: value),
                        ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        final article = articles[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(article.author != null ? article.author.toString() : "Author"),
                            subtitle: Text(
                              article.description != null ? article.description.toString() : "description",
                              overflow: TextOverflow.ellipsis,
                            ),
                            leading: article.urlToImage != null
                                ? Container(
                                    height: MediaQuery.of(context).size.width * 0.1,
                                    width: MediaQuery.of(context).size.height * 0.08,
                                    child: Image.network(article.urlToImage.toString()),
                                  )
                                : Container(
                                    height: MediaQuery.of(context).size.width * 0.1,
                                    width: MediaQuery.of(context).size.height * 0.08,
                                    color: Colors.grey,
                                  ),
                            trailing: IconButton(
                              onPressed: () async {
  final hiveArticle = Article(
    author: article.author,
    title: article.title,
    description: article.description,
    url: article.url,
    urlToImage: article.urlToImage,
    publishedAt: article.publishedAt,
    content: article.content,
  );

  final box = await Hive.openBox<Article>('articles');
  await box.add(hiveArticle);

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Article bookmarked!'),
    ),
  );
                              },
                              icon: Icon(Icons.bookmark, color: Colors.red),
                            ),
                            onTap: () {
                              showModalBottomSheet(
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
                                    content: article.description.toString(),
                                  ),
                                ),
                                isScrollControlled: true,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            default:
              return Container();
          }
        },
      ),
    );
  }
}

