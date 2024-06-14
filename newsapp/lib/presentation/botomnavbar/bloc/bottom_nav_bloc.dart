import 'package:bloc/bloc.dart';
import 'package:newsapp/presentation/botomnavbar/bloc/bottom_nav_event.dart';
import 'package:newsapp/presentation/botomnavbar/bloc/bottom_nav_state.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super(BottomNavState()){
    on<PageTappedEvent>(_pagetapeventhandel);


  }

  _pagetapeventhandel(PageTappedEvent event , Emitter<BottomNavState> emit) async{
    emit(PageLoading());

    await Future.delayed(Duration(milliseconds: 300)) ;
    emit(PageLoaded(event.index));
  }



}
