import 'package:dio/dio.dart';

final Dio dio_pertama = Dio(BaseOptions(
    baseUrl: 'https://6598ddfda20d3dc41cef0419.mockapi.io/', //poli dan pegawai
    connectTimeout: 5000,
    receiveTimeout: 3000));

class ApiClientPertama {
  Future<Response> get(String path) async {
    try {
      final response = await dio_pertama.get(Uri.encodeFull(path));
      return response;
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  Future<Response> post(String path, dynamic data) async {
    try {
      final response = await dio_pertama.post(Uri.encodeFull(path), data: data);
      return response;
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  Future<Response> put(String path, dynamic data) async {
    try {
      final response = await dio_pertama.put(Uri.encodeFull(path), data: data);
      return response;
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  Future<Response> delete(String path) async {
    try {
      final response = await dio_pertama.delete(Uri.encodeFull(path));
      return response;
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }
}
