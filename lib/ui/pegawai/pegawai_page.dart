import 'package:flutter/material.dart';
import '../../model/pegawai.dart';
import '../../service/pegawai_service.dart';
import 'pegawai_form.dart';
import 'pegawai_item.dart';
import '../../widget/sidebar.dart';

class PegawaiPage extends StatefulWidget {
  const PegawaiPage({super.key});

  @override
  State<PegawaiPage> createState() => _PegawaiPageState();
}

class _PegawaiPageState extends State<PegawaiPage> {
  Stream<List<Pegawai>> getList() async* {
    List<Pegawai> data = await PegawaiService().listData();
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Pegawai"),
        actions: [
          ElevatedButton(
            //child: Text("Tambah Data"),
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const PegawaiForm()));
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
              return PegawaiItem(pegawai: snapshot.data[index]);
            },
          );
        },
      ),
    );
  }
}
//       body: ListView(
//         children: [
//           PegawaiItem(
//               pegawai: Pegawai(
//                   namaPegawai: "Abdul Latif",
//                   tanggalLahir: "07 Maret 1997",
//                   nomorTelepon: "087777777",
//                   email: "pegawai1@klinikapp.com")),
//           PegawaiItem(
//               pegawai: Pegawai(
//                   namaPegawai: "Bill Gates",
//                   tanggalLahir: "09 April 1996",
//                   nomorTelepon: "082222222",
//                   email: "pegawai2@klinikapp.com")),
//           PegawaiItem(
//               pegawai: Pegawai(
//                   namaPegawai: "Mark Zuckerberg",
//                   tanggalLahir: "31 Mei 1998",
//                   nomorTelepon: "083333333",
//                   email: "pegawai3@klinikapp.com")),
//           PegawaiItem(
//               pegawai: Pegawai(
//                   namaPegawai: "Elon Musk",
//                   tanggalLahir: "21 Maret 1999",
//                   nomorTelepon: "085555555",
//                   email: "pegawai4@klinikapp.com")),
//           PegawaiItem(
//               pegawai: Pegawai(
//                   namaPegawai: "Jeff Bezos",
//                   tanggalLahir: "11 Desember 1992",
//                   nomorTelepon: "081111111",
//                   email: "pegawai5@klinikapp.com")),
//         ],
//       ),
//     );
//   }
// }
