import 'package:dio/dio.dart';
import '../helpers/api_client_1.dart';
import '../helpers/user_info.dart';
import 'package:randomstring_dart/randomstring_dart.dart';

final rs = RandomString();
String randomtoken = rs.getRandomString(
  uppersCount: 10,
  lowersCount: 10,
  numbersCount: 10,
  specialsCount: 2,
  specials: '_-=!=',
);

class LoginService {
  Future<bool> login(String email, String password) async {
    bool isLogin = false;

    final Response response = await ApiClientPertama().get('pegawai');
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      final employee = data.firstWhere(
        (element) =>
            element['email'] == email && element['password'] == password,
        orElse: () => null,
      );

      if (employee != null) {
        final token = randomtoken;
        final userEmail = employee['email'];

        await UserInfo().setToken(token);
        await UserInfo().setUsername(userEmail);
        isLogin = true;
      } else {
        await UserInfo().logout();
        isLogin = false;
      }
    } else {
      await UserInfo().logout();
      isLogin = false;
    }

    return isLogin;
  }
}
