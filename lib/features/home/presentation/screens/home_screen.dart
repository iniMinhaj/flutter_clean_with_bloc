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
    // Trigger events in initState
   context.read<HomeBloc>().add(FetchPopularEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Homescreen"),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          print("State = $state");
    
          if (state is HomeLoading) {
            return const CircularProgressIndicator();
          } 
        else if (state is HomeSuccess) {
          print("image = ${state.popularProductEntity.data?[0].cover}");
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemCount: state.popularProductEntity.data?.length,
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                  
                    Image.network(
  state.popularProductEntity.data?[index].thumb ?? "",
  errorBuilder: (context, error, stackTrace) {
    return const Icon(Icons.error); // Display an error icon
  },
),
                    Text(state.popularProductEntity.data?[index].name ?? "")
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text("No data"));
          }
        },
      ),
    );
  }
}
