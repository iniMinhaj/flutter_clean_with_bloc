// import 'package:dio/dio.dart';

// import '../error/exception.dart';

// class ApiService {
//   final Dio dio;

//   ApiService(this.dio);

//   Future<Response> post({
//     required String url,
//     required Map<String, dynamic> data,
//     String? token,
//     bool requiresToken = false,
//   }) async {
//     try {
//       final response = await dio.post(
//         url,
//         data: data,
//         options: Options(
//           headers: token != null && requiresToken == true
//               ? {'Authorization': 'Bearer $token'}
//               : null,
//         ),
//       );
//       return response;
//     } catch (e) {
//       throw ServerException(message: 'Error: ${e.toString()}');
//     }
//   }
// }
