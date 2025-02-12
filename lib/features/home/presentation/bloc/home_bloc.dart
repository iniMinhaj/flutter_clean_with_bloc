import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_with_bloc/core/error/failures.dart';
import 'package:flutter_clean_with_bloc/features/home/domain/entity/popular_entity.dart';
import 'package:flutter_clean_with_bloc/features/home/domain/usecases/home_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeUsecase homeUsecase;
  HomeBloc({required this.homeUsecase}) : super(HomeInitial()) {
    on<FetchPopularEvent>((event, emit) async {
      emit(HomeLoading());

   final result = await   homeUsecase.call();
   result.fold((failure){
    return Failure(message: failure.message);
   }, (popularProductEntity){
return HomeSuccess(popularProductEntity: popularProductEntity);
   });

    });
  }
}
