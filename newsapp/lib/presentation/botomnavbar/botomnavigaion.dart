
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/presentation/Bookmarks/bookmarks.dart';
import 'package:newsapp/presentation/botomnavbar/bloc/bottom_nav_bloc.dart';
import 'package:newsapp/presentation/botomnavbar/bloc/bottom_nav_event.dart';
import 'package:newsapp/presentation/botomnavbar/bloc/bottom_nav_state.dart';
import 'package:newsapp/presentation/homescreen/home.dart';



class BotoomNav extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavBloc(),
      child: BotoomNavView(),
    );
  }
}

class BotoomNavView extends StatefulWidget {


  const BotoomNavView({super.key});

  @override
  _BotoomNavViewState createState() => _BotoomNavViewState();
}

class _BotoomNavViewState extends State<BotoomNavView> {
  late List<Widget> screens;
 

  @override
  void initState() {
    super.initState();

    screens = [
   HomePage(), 
   SavedArticlesScreen()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 
        const Row(children: [
Text("News" , style: TextStyle(color: Colors.black),), Text("App" , style: TextStyle(color: Colors.white),)
        ],), 
        
    
        backgroundColor: Colors.red.shade400,
        elevation: 4.0,

      ),
      body: BlocBuilder<BottomNavBloc, BottomNavState>(
        builder: (context, state) {
          if (state is PageLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is PageLoaded) {
            return IndexedStack(
              index: state.index,
              children: screens,
            );
          }
          return IndexedStack(
            index: 0,
            children: screens,
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<BottomNavBloc, BottomNavState>(
        builder: (context, state) {
          
          if (state is PageLoaded) {
            
          }
          return CurvedNavigationBar(
            backgroundColor: Colors.white,
            color: Colors.redAccent,
            buttonBackgroundColor: Colors.white,
            animationCurve: Curves.easeOutSine,

            onTap: (index) {
                context.read<BottomNavBloc>().add(PageTappedEvent(index));
            },
            items: [
               Icon(Icons.home , size: 35),
               Icon(Icons.bookmark , size: 35,)
            ],
          );
        },
      ),
      
    );
  }
}
