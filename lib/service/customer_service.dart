import 'package:dio/dio.dart';
import '../helpers/api_client_2.dart';
import '../model/customer.dart';

class CustomerService {
  Future<List<Customer>> listData() async {
    final Response response = await ApiClientKedua().get('customer');
    final List data = response.data as List;
    List<Customer> result =
        data.map((json) => Customer.fromJson(json)).toList();
    return result;
  }

  Future<Customer> simpan(Customer customer) async {
    var data = customer.toJson();
    final Response response = await ApiClientKedua().post('customer', data);
    Customer result = Customer.fromJson(response.data);
    return result;
  }

  Future<Customer> ubah(Customer customer, String id) async {
    var data = customer.toJson();
    final Response response = await ApiClientKedua().put('customer/$id', data);
    print(response);
    Customer result = Customer.fromJson(response.data);
    return result;
  }

  Future<Customer> getById(String id) async {
    final Response response = await ApiClientKedua().get('customer/$id');
    Customer result = Customer.fromJson(response.data);
    return result;
  }

  Future<Customer> hapus(Customer customer) async {
    final Response response =
        await ApiClientKedua().delete('customer/${customer.id}');
    Customer result = Customer.fromJson(response.data);
    return result;
  }
}
