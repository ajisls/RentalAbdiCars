import 'package:flutter/material.dart';
import '../../model/customer.dart';
import 'customer_detail.dart';

import '../../service/customer_service.dart';

class CustomerForm extends StatefulWidget {
  const CustomerForm({Key? key}) : super(key: key);

  @override
  State<CustomerForm> createState() => _CustomerFormState();
}

class _CustomerFormState extends State<CustomerForm> {
  final _formKey = GlobalKey<FormState>();
  final _namaCustomerCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneNumberCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Tambah Customer")),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _fieldNamaCustomer(),
                _fieldEmail(),
                _fieldPhoneNumber(),
                _fieldAddress(),
                _pembatas(),
                _tombolSimpan()
              ],
            ),
          ),
        ));
  }

  _fieldNamaCustomer() {
    return TextField(
      decoration: const InputDecoration(
          floatingLabelStyle: TextStyle(color: Colors.red),
          labelText: "NO RM",
          hintText: "Input Nomor RM"),
      controller: _namaCustomerCtrl,
    );
  }

  _fieldEmail() {
    return TextField(
      decoration: const InputDecoration(
          floatingLabelStyle: TextStyle(color: Colors.red),
          labelText: "Nama Mobil",
          hintText: "Input Nama Mobil"),
      controller: _emailCtrl,
    );
  }

  _fieldPhoneNumber() {
    return TextField(
      decoration: const InputDecoration(
          floatingLabelStyle: TextStyle(color: Colors.red),
          labelText: "Alamat Mobil",
          hintText: "Input Alamat Mobil"),
      controller: _phoneNumberCtrl,
    );
  }

  _fieldAddress() {
    return TextField(
      decoration: const InputDecoration(
          floatingLabelStyle: TextStyle(color: Colors.red),
          labelText: "No Telp Mobil",
          hintText: "Input Nomor Telepon Mobil"),
      controller: _addressCtrl,
    );
  }

  _pembatas() {
    return const SizedBox(height: 20);
  }

  _tombolSimpan() {
    return ElevatedButton(
        onPressed: () async {
          Customer customer = Customer(
              namacustomer: _namaCustomerCtrl.text,
              email: _emailCtrl.text,
              phonenumber: _phoneNumberCtrl.text,
              address: _addressCtrl.text);
          await CustomerService().simpan(customer).then((value) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => CustomerDetail(customer: value)));
          });
        },
        child: const Text("Simpan"));
  }
}
