import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../model/mobil.dart';
import 'mobil_detail.dart';

import '../../service/mobil_service.dart';

class MobilForm extends StatefulWidget {
  const MobilForm({Key? key}) : super(key: key);

  @override
  State<MobilForm> createState() => _MobilFormState();
}

class _MobilFormState extends State<MobilForm> {
  final _formKey = GlobalKey<FormState>();
  final _merekMobilCtrl = TextEditingController();
  final _modelMobilCtrl = TextEditingController();
  final _tahunMobilCtrl = TextEditingController();
  final _warnaMobilCtrl = TextEditingController();
  final _hargaSewaCtrl = TextEditingController();
  final _tersediaCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Tambah Mobil")),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _fieldMerekMobil(),
                _fieldModelMobil(),
                _fieldTahunMobil(),
                _fieldWarnaMobil(),
                _fieldHargaSewa(),
                _fieldTersedia(),
                _pembatas(),
                _tombolSimpan()
              ],
            ),
          ),
        ));
  }

  _fieldMerekMobil() {
    return TextField(
      decoration: const InputDecoration(
          floatingLabelStyle: TextStyle(color: Colors.red),
          labelText: "Merk Mobil",
          hintText: "Input Merk Mobil"),
      controller: _merekMobilCtrl,
    );
  }

  _fieldModelMobil() {
    return TextField(
      decoration: const InputDecoration(
          floatingLabelStyle: TextStyle(color: Colors.red),
          labelText: "Model Mobil",
          hintText: "Input Model Mobil"),
      controller: _modelMobilCtrl,
    );
  }

  _fieldTahunMobil() {
    return TextField(
      decoration: const InputDecoration(
        floatingLabelStyle: TextStyle(color: Colors.red),
        labelText: "Tahun Mobil",
        hintText: "Input Tahun Mobil",
        icon: Icon(Icons.calendar_today),
      ),
      controller: _tahunMobilCtrl,

      readOnly: true, //set it true, so that user will not able to edit text
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(
                1990), //DateTime.now() - not to allow to choose before today.
            lastDate: DateTime(2101));

        if (pickedDate != null) {
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

          _tahunMobilCtrl.text =
              formattedDate; //set output date to TextField value.
        }
      },
    );
  }

  _fieldHargaSewa() {
    return TextField(
      decoration: const InputDecoration(
          floatingLabelStyle: TextStyle(color: Colors.red),
          labelText: "Alamat Mobil",
          hintText: "Input Alamat Mobil"),
      controller: _hargaSewaCtrl,
    );
  }

  _fieldWarnaMobil() {
    return TextField(
      decoration: const InputDecoration(
          floatingLabelStyle: TextStyle(color: Colors.red),
          labelText: "Warna Mobil",
          hintText: "Input Warna Mobil"),
      controller: _warnaMobilCtrl,
    );
  }

  _fieldTersedia() {
    return TextField(
      decoration: const InputDecoration(
          floatingLabelStyle: TextStyle(color: Colors.red),
          labelText: "Ketersediaan Mobil",
          hintText: "Input Ketersediaan Mobil"),
      controller: _tersediaCtrl,
    );
  }

  _pembatas() {
    return const SizedBox(height: 20);
  }

  _tombolSimpan() {
    return ElevatedButton(
        onPressed: () async {
          Mobil mobil = Mobil(
              merekMobil: _merekMobilCtrl.text,
              modelMobil: _modelMobilCtrl.text,
              hargaSewa: _hargaSewaCtrl.text,
              warnaMobil: _warnaMobilCtrl.text,
              tahunMobil: _tahunMobilCtrl.text,
              tersedia: _tersediaCtrl.text);
          await MobilService().simpan(mobil).then((value) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => MobilDetail(mobil: value)));
          });
        },
        child: const Text("Simpan"));
  }
}
