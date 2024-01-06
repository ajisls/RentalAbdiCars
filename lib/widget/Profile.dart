import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Pengguna"),
      ),
      body: const Column(
        children: [
          Text("Kolom 1 : Nama       "),
          Text("Kolom 2 : NIM        "),
          Text("Kolom 3 : Kelas      "),
          Text("Kolom 4 : Mata Kuliah")
        ],
      ),
    );
  }
}
