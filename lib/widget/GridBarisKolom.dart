import 'package:flutter/material.dart';

class GridBarisKolom extends StatelessWidget {
  const GridBarisKolom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grid Kolom dan Baris'),
      ),
      body: const Column(
        children: [
          SizedBox(height: 80.0),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text("Kolom 1 Baris 1"),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text("Kolom 2 Baris 1"),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text("Kolom 3 Baris 1"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text("Kolom 1 Baris 2"),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text("Kolom 2 Baris 2"),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text("Kolom 3 Baris 2"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text("Kolom 1 Baris 3"),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text("Kolom 2 Baris 3"),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text("Kolom 3 Baris 3"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
