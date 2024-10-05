import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_with_bloc/core/usecases/usecase.dart';
import 'package:flutter_clean_with_bloc/features/product/domain/entity/product_entity.dart';
import 'package:flutter_clean_with_bloc/features/product/domain/usecase/get_product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
 final GetProductUsecase getProductUsecase;

 

  ProductBloc({required this.getProductUsecase}) : super(ProductInitial()) {
    on<GetProductEvent>((event, emit) async{
      emit(ProductLoading());
      final result = await getProductUsecase(NoParams());
      result.fold((error){
        emit(ProductFailed(error: error.message));
      }, (data){
        emit(ProductFetched(productList: data));
      });
    });
  }
}



// ------------[Another Approach - Sperating method from constructor]-------------
/*

        class ProductBloc extends Bloc<ProductEvent, ProductState> {
          final GetProductUsecase getProductUsecase;

          ProductBloc({required this.getProductUsecase}) : super(ProductInitial()) {
            
            // Handling GetProductEvent with a specific method
            on<GetProductEvent>(_onGetProductEvent);
          }

          // Event handler method for GetProductEvent
          Future<void> _onGetProductEvent(
              GetProductEvent event, Emitter<ProductState> emit) async {
            emit(ProductLoading());

            try {
              // Fetch products from the use case
              final result = await getProductUsecase(NoParams());

              // Handling success or failure from the result
              result.fold(
                (failure) => emit(ProductFailed(error: failure.message)),
                (productList) => emit(ProductFetched(productList: productList)),
              );
            } catch (e) {
              // Catching unexpected errors
              emit(ProductFailed(error: 'Unexpected error: $e'));
            }
          }
        }

*/

