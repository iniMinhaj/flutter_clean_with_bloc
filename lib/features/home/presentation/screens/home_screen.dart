import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_with_bloc/features/home/presentation/bloc/home_bloc.dart';

import '../../../../injection_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
     final homeBloc = sl<HomeBloc>(); // Resolve Bloc using GetIt

    // Trigger events in initState
    homeBloc.add(FetchPopularEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Homescreen"),),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {

          if(state is HomeLoading){
            return const CircularProgressIndicator();
          }
          else if(state is HomeSuccess){

             return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
          
            ), 
            itemCount: state.popularProductEntity.data?.length,
            itemBuilder: (context, index) => Container(
      
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(children: [
                Image.network(state.popularProductEntity.data?[index].thumb ?? "")
              ],),
            ),);

          }
          else {
              return Center(child: Text("No data"));
            }
         
        },
      ),
    );
  }
}