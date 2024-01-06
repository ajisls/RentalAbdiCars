// ignore_for_file: non_constant_identifier_names


import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../model/pegawai.dart';
import 'pegawai_detail.dart';

import '../../service/pegawai_service.dart';

class PegawaiForm extends StatefulWidget {
  const PegawaiForm({Key? key}) : super(key: key);

  @override
  State<PegawaiForm> createState() => _PegawaiFormState();
}

class _PegawaiFormState extends State<PegawaiForm> {
  final _formKey = GlobalKey<FormState>();
  final _NipPegawaiCtrl = TextEditingController();
  final _namaPegawaiCtrl = TextEditingController();
  final _tanggalLahirCtrl = TextEditingController();
  final _TeleponPegawaiCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  //bool _obscureText = true;

  //String? _password;

  // Toggles the password show status
  // void _toggle() {
  //   setState(() {
  //     _obscureText = !_obscureText;
  //   });
  // }
  // File? _pickedImage; // Track the picked image

  // Future<File?> pickImage() async {
  //   final ImagePicker _picker = ImagePicker();
  //   final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  //   if (image != null) {
  //     return File(image.path);
  //   }
  //   return null;
  // }

  // Future<void> uploadImage(File imageFile) async {
  //   try {
  //     String fileName = imageFile.path.split('/').last;
  //     FormData formData = FormData.fromMap({
  //       'file': await MultipartFile.fromFile(
  //         imageFile.path,
  //         filename: fileName,
  //       ),
  //     });

  //     // Replace 'your_upload_url' with your actual API endpoint for uploading images
  //     Response response = await Dio().post(
  //       'your_upload_url',
  //       data: formData,
  //     );

  //     if (response.statusCode == 200) {
  //       // Image uploaded successfully, handle the response
  //     } else {
  //       // Handle any errors if the upload fails
  //     }
  //   } catch (e) {
  //     // Handle any exceptions that occur during the upload process
  //     print('Upload error: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Tambah Pegawai")),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _fieldNIPPegawai(),
                _fieldNamaPegawai(),
                _fieldTglLahirPegawai(),
                _fieldTeleponPegawai(),
                _fieldEmailPegawai(),
                _fieldPassword(),
                //_imagePickerButton(),
                _pembatas(),
                _tombolSimpan()
              ],
            ),
          ),
        ));
  }

  _fieldNIPPegawai() {
    return TextField(
      decoration: const InputDecoration(
          floatingLabelStyle: TextStyle(color: Colors.red),
          labelText: "NIP Pegawai",
          hintText: "Input NIP Pegawai"),
      controller: _NipPegawaiCtrl,
    );
  }

  _fieldNamaPegawai() {
    return TextField(
      decoration: const InputDecoration(
          floatingLabelStyle: TextStyle(color: Colors.red),
          labelText: "Nama Pegawai",
          hintText: "Input Nama Pegawai"),
      controller: _namaPegawaiCtrl,
    );
  }

  // _imagePickerButton() {
  //   return Column(
  //     children: [
  //       ElevatedButton(
  //         onPressed: () async {
  //           File? pickedImage = await pickImage();
  //           if (pickedImage != null) {
  //             setState(() {
  //               _pickedImage = pickedImage; // Update the picked image
  //             });
  //             await uploadImage(pickedImage);
  //           }
  //         },
  //         child: const Text('Pick and Upload Image'),
  //       ),
  //       if (_pickedImage != null)
  //         Image.file(
  //           _pickedImage!,
  //           height: 100, // Set desired height for the preview image
  //           width: 100, // Set desired width for the preview image
  //         ),
  //     ],
  //   );
  // }

  _fieldTglLahirPegawai() {
    return TextField(
      decoration: const InputDecoration(
        floatingLabelStyle: TextStyle(color: Colors.red),
        labelText: "Tanggal Lahir",
        hintText: "Input Tanggal Lahir",
        icon: Icon(Icons.calendar_today),
      ),
      controller: _tanggalLahirCtrl,

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

          _tanggalLahirCtrl.text =
              formattedDate; //set output date to TextField value.
        }
      },
    );
  }

  _fieldTeleponPegawai() {
    return TextField(
      decoration: const InputDecoration(
          floatingLabelStyle: TextStyle(color: Colors.red),
          labelText: "Nomor Telepon",
          hintText: "Input Nomor Telepon"),
      controller: _TeleponPegawaiCtrl,
    );
  }

  _fieldEmailPegawai() {
    return TextField(
      decoration: const InputDecoration(
          floatingLabelStyle: TextStyle(color: Colors.red),
          labelText: "Email",
          hintText: "Input Email"),
      controller: _emailCtrl,
    );
  }

  _fieldPassword() {
    return TextField(
      decoration: const InputDecoration(labelText: "Password"),
      controller: _passwordCtrl,
      obscureText: true,
    );
  }

  _pembatas() {
    return const SizedBox(height: 20);
  }

  _tombolSimpan() {
    return ElevatedButton(
        onPressed: () async {
          Pegawai pegawai = Pegawai(
              nip: _NipPegawaiCtrl.text,
              namaPegawai: _namaPegawaiCtrl.text,
              tanggalLahir: _tanggalLahirCtrl.text,
              nomorTelepon: _TeleponPegawaiCtrl.text,
              email: _emailCtrl.text,
              password: _passwordCtrl.text);
          await PegawaiService().simpan(pegawai).then((value) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => PegawaiDetail(pegawai: value)));
          });
        },
        child: const Text("Simpan"));
  }
}
