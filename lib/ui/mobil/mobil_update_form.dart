// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../model/mobil.dart';
import '../../service/mobil_service.dart';
import 'mobil_detail.dart';

class MobilUpdateForm extends StatefulWidget {
  final Mobil mobil;

  const MobilUpdateForm({Key? key, required this.mobil}) : super(key: key);
  @override
  _MobilUpdateFormState createState() => _MobilUpdateFormState();
}

class _MobilUpdateFormState extends State<MobilUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final _merekMobilCtrl = TextEditingController();
  final _modelMobilCtrl = TextEditingController();
  final _tahunMobilCtrl = TextEditingController();
  final _warnaMobilCtrl = TextEditingController();
  final _hargaSewaCtrl = TextEditingController();
  final _tersediaCtrl = TextEditingController();
  Future<Mobil> getData() async {
    Mobil data = await MobilService().getById(widget.mobil.id.toString());
    setState(() {
      _merekMobilCtrl.text = widget.mobil.merekMobil;
      _modelMobilCtrl.text = widget.mobil.modelMobil;
      _tahunMobilCtrl.text = widget.mobil.tahunMobil;
      _warnaMobilCtrl.text = widget.mobil.warnaMobil;
      _hargaSewaCtrl.text = widget.mobil.hargaSewa;
      _tersediaCtrl.text = widget.mobil.tersedia;
    });
    return data;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ubah Mobil")),
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
      ),
    );
  }

  _fieldMerekMobil() {
    return TextField(
      decoration: const InputDecoration(
          floatingLabelStyle: TextStyle(color: Colors.red),
          labelText: "Merek Mobil",
          hintText: "Input Merek Mobil"),
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
          labelText: "Harga Sewa Mobil Perhari",
          hintText: "Input Harga Sewa Mobil Perhari"),
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
          labelText: " Tersedia ",
          hintText: "Input tersedia"),
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
              modelMobil: _modelMobilCtrl.text,
              merekMobil: _merekMobilCtrl.text,
              hargaSewa: _hargaSewaCtrl.text,
              warnaMobil: _warnaMobilCtrl.text,
              tahunMobil: _tahunMobilCtrl.text,
              tersedia: _tersediaCtrl.text);
          String id = widget.mobil.id.toString();
          await MobilService().ubah(mobil, id).then((value) {
            Navigator.pop(context);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => MobilDetail(mobil: value)));
          });
        },
        child: const Text("Simpan Perubahan"));
  }
}
