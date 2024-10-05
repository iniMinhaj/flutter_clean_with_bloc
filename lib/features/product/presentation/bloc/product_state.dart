part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();
  
  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState{}

final class ProductFetched extends ProductState{
 final List<ProductEntity> productList;
 const ProductFetched({required this.productList});
  
  @override
  List<Object> get props => productList;
}

final class ProductFailed extends ProductState{
  final String error;

  const ProductFailed({required this.error});

}
