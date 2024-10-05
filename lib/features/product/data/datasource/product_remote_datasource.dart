import 'package:flutter_clean_with_bloc/core/constant/api_list.dart';
import 'package:flutter_clean_with_bloc/core/error/exception.dart';
import 'package:flutter_clean_with_bloc/core/network/api_services.dart';

import '../model/product_model.dart';

abstract class ProductRemoteDatasource {
  Future<List<ProductModel>> getProducts();
}

class ProductRemoteDatasourceImpl implements ProductRemoteDatasource{
  final ApiService apiService;

  ProductRemoteDatasourceImpl({required this.apiService});

  @override
  Future<List<ProductModel>> getProducts() async{

    final response = await apiService.get(endpoint: ApiEndpoints.fakeStoreProduct);
    if(response.statusCode == 200){
      final data = response.data as List;
      print("data = $data");
      List<ProductModel> productList = data.map((e)=> ProductModel.fromJson(e)).toList();
      return productList;
    }else{
      throw ServerException(message:  response.data['message']);
    }

    
  }
}