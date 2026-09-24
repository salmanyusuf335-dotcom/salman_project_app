import 'package:dio/dio.dart';
import '../models/product_model.dart';

class ProductService {
  final Dio dio = Dio();

  Future<List<Product>> fetchData() async {
    try {
      final response = await dio.get(
        'https://dummyjson.com/products',
      );

      final List data = response.data['products'];

      return data
          .map(
            (json) => Product.fromJson(json),
          )
          .toList();
    } on DioException catch (e) {
      throw Exception(
        'Gagal terhubung ke server: ${e.message}',
      );
    } catch (e) {
      throw Exception(
        'Terjadi kesalahan: $e',
      );
    }
  }
}