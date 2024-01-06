import 'package:flutter/material.dart';
import 'widget/HalamanUtama.dart';
import 'package:kelas_7ad/ui/login.dart';
import 'helpers/user_info.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var token = await UserInfo().getToken();
  //print(token);
  runApp(MaterialApp(
    title: "Rental APP",
    debugShowCheckedModeBanner: false,
    home: token == null ? const Login() : const Beranda(),
  ));
}
