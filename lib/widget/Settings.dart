import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pengaturan"),
      ),
      body: const Center(
        child: Text("Ini Merupakan Tampilan Halaman Pengaturan"),
      ),
    );
  }
}
