part of 'home_bloc.dart';

class HomeState extends Equatable{
 final Statuss Status;
 final List<ArticleModel> OriginalList;
 final List<ArticleModel> UpdatedList;
 final String Message;
final Map<dynamic, bool> bookmarkedArticles; 
final bool isBookmarked;

  HomeState({
    this.Status = Statuss.loading ,
      this.OriginalList = const [],
       this.Message = " " ,
        this.UpdatedList = const [] ,
         this.bookmarkedArticles = const {} , 
         this.isBookmarked = false});

  HomeState CopyWith({Statuss? statussi , List<ArticleModel>? UpdatedListi , String? msgi , List<ArticleModel>? OriginalListi ,
   Map<dynamic, bool>? bookmarkedArticles  , bool? isbookmarked}){
    return HomeState(
      Message: msgi?? this.Message , 
      OriginalList: OriginalListi ?? this.OriginalList , 
      Status: statussi ?? this.Status , 
      UpdatedList: UpdatedListi ?? this.UpdatedList , 
      
 
 bookmarkedArticles: bookmarkedArticles ?? this.bookmarkedArticles , 
 isBookmarked: isbookmarked ?? this.isBookmarked
     );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [Message , OriginalList , Status , UpdatedList , bookmarkedArticles , isBookmarked];
}


