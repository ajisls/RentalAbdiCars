import 'package:flutter/material.dart';
import '../../service/mobil_service.dart';
import '../../model/mobil.dart';
import '../../widget/sidebar.dart';
import 'mobil_page.dart';
import 'mobil_update_form.dart';

class MobilDetail extends StatefulWidget {
  final Mobil mobil;

  const MobilDetail({super.key, required this.mobil});

  @override
  State<MobilDetail> createState() => _MobilDetailState();
}

class _MobilDetailState extends State<MobilDetail> {
  Stream<Mobil> getData() async* {
    Mobil data = await MobilService().getById(widget.mobil.id.toString());
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mobil Detail")),
      drawer: const Sidebar(),
      body: StreamBuilder(
        stream: getData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return const Text('Data Tidak Ditemukan');
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              ListTile(
                  title: const Text("Merek Mobil"),
                  subtitle: Text(snapshot.data.merekMobil,
                      style: const TextStyle(fontSize: 20))),
              ListTile(
                  title: const Text("Model Mobil"),
                  subtitle: Text(snapshot.data.modelMobil,
                      style: const TextStyle(fontSize: 20))),
              ListTile(
                  title: const Text("Tahun"),
                  subtitle: Text(snapshot.data.tahunMobil,
                      style: const TextStyle(fontSize: 20))),
              ListTile(
                  title: const Text("Warna Mobil"),
                  subtitle: Text(snapshot.data.warnaMobil,
                      style: const TextStyle(fontSize: 20))),
              ListTile(
                  title: const Text("Harga Sewa Perhari"),
                  subtitle: Text(snapshot.data.hargaSewa,
                      style: const TextStyle(fontSize: 20))),
              const SizedBox(height: 20),
              ListTile(
                  title: const Text("Tersedia"),
                  subtitle: Text(snapshot.data.tersedia,
                      style: const TextStyle(fontSize: 20))),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _tombolUbah(),
                  _tombolHapus(),
                ],
              )
            ],
          );
        },
      ),
    );
  }

  _tombolUbah() {
    return StreamBuilder(
        stream: getData(),
        builder: (context, AsyncSnapshot snapshot) => ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MobilUpdateForm(mobil: snapshot.data)));
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text("Ubah")));
  }

  _tombolHapus() {
    return ElevatedButton(
        onPressed: () async {
          AlertDialog alertDialog = AlertDialog(
            content: const Text("Yakin ingin menghapus data ini?"),
            actions: [
              // tombol ya
              StreamBuilder(
                stream: getData(),
                builder: (context, AsyncSnapshot snapshot) => ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pop(); // Close the confirmation dialog
                    _hapusData(snapshot.data);
                    // Call the _hapusData function
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MobilPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text("YA"),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text("Tidak"),
              )
            ],
          );
          showDialog(context: context, builder: (context) => alertDialog);
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        child: const Text("Hapus"));
  }

// Function to handle data deletion and navigation
  _hapusData(data) async {
    await MobilService().hapus(data);
    await Future.delayed(Duration.zero);
    if (!context.mounted) return;
    Navigator.of(context).pop(); // Close the confirmation dialog
  }
}
