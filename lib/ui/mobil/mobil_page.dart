import 'package:flutter/material.dart';
import '../../model/mobil.dart';
import '../../service/mobil_service.dart';
import 'mobil_form.dart';
import 'mobil_item.dart';
import '../../widget/sidebar.dart';

class MobilPage extends StatefulWidget {
  const MobilPage({super.key});

  @override
  State<MobilPage> createState() => _MobilPageState();
}

class _MobilPageState extends State<MobilPage> {
  Stream<List<Mobil>> getList() async* {
    List<Mobil> data = await MobilService().listData();
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Mobil"),
        actions: [
          ElevatedButton(
            child: const Text("Tambah Data"),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MobilForm()));
            },
          )
        ],
      ),
      drawer: const Sidebar(),
      body: StreamBuilder(
        stream: getList(),
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
            return const Text('Data Kosong');
          }

          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return MobilItem(mobil: snapshot.data[index]);
            },
          );
        },
      ),
    );
  }
}
//       body: ListView(
//         children: [
//           MobilItem(
//               mobil: Mobil(
//                   namaMobil: "Mobil 1",
//                   nomorRM: "Melati1",
//                   alamat: "Jakarta Pusat",
//                   nomorTelepon: "088888888",
//                   tanggalLahir: "14 Oktober 1993")),
//           MobilItem(
//               mobil: Mobil(
//                   namaMobil: "Mobil 1",
//                   nomorRM: "Melati2",
//                   alamat: "Jakarta Timur",
//                   nomorTelepon: "089999999",
//                   tanggalLahir: "23 Maret 1992")),
//           MobilItem(
//               mobil: Mobil(
//                   namaMobil: "Mobil 1",
//                   nomorRM: "Anggrek21",
//                   alamat: "Jakarta Utara",
//                   nomorTelepon: "085555555",
//                   tanggalLahir: "11 Februari 1996")),
//         ],
//       ),
//     );
//   }
// }
