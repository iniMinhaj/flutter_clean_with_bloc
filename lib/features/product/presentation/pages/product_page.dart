import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_with_bloc/features/product/domain/entity/product_entity.dart';
import 'package:flutter_clean_with_bloc/features/product/presentation/bloc/product_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../widgets/product_card.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Accessing the ProductBloc created in main.dart's MultiBlocProvider
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          // Trigger product fetch event on screen load if needed
          if (state is ProductInitial) {
            context.read<ProductBloc>().add(GetProductEvent());
            return const Center(child: CircularProgressIndicator());
          }

          // Loading state
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error state
          if (state is ProductFailed) {
            return Center(
              child: Text(
                state.error,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          // Success state with product data
          if (state is ProductFetched) {
            return ProductGridView(productList: state.productList);
          }

          // Default state
          return const Center(child: Text("Unexpected state!"));
        },
      ),
    );
  }
}


class ProductGridView extends StatelessWidget {
  const ProductGridView({super.key, required this.productList});
  final List<ProductEntity> productList;

  @override
  Widget build(BuildContext context) {

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: MasonryGridView.count(
              crossAxisCount: 2, // Number of columns
            
              itemCount: productList.length,
              itemBuilder: (context, index) {
                final product = productList[index];

                return ProductCard(
                  imageUrl: product.image ?? '',
                  title: product.title ?? 'No Title',
                  price: product.price?.toString() ?? 'N/A',
                  rating: product.rating?.rate?.toString() ?? 'N/A',
                );
              },
             
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
          );
        }

}


