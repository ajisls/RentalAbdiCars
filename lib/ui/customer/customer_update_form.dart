// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import '../../model/customer.dart';
import '../../service/customer_service.dart';
import 'customer_detail.dart';

class CustomerUpdateForm extends StatefulWidget {
  final Customer customer;

  const CustomerUpdateForm({Key? key, required this.customer})
      : super(key: key);
  @override
  _CustomerUpdateFormState createState() => _CustomerUpdateFormState();
}

class _CustomerUpdateFormState extends State<CustomerUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final _namaCustomerCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneNumberCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  Future<Customer> getData() async {
    Customer data =
        await CustomerService().getById(widget.customer.id.toString());
    setState(() {
      _namaCustomerCtrl.text = widget.customer.namacustomer;
      _emailCtrl.text = widget.customer.email;
      _phoneNumberCtrl.text = widget.customer.phonenumber;
      _addressCtrl.text = widget.customer.address;
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
      appBar: AppBar(title: const Text("Ubah Customer")),
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
      ),
    );
  }

  _fieldNamaCustomer() {
    return TextField(
      decoration: const InputDecoration(
          floatingLabelStyle: TextStyle(color: Colors.red),
          labelText: "Nama Customer",
          hintText: "Input Nama Customer"),
      controller: _namaCustomerCtrl,
    );
  }

  _fieldEmail() {
    return TextField(
      decoration: const InputDecoration(
          floatingLabelStyle: TextStyle(color: Colors.red),
          labelText: "Nama Customer",
          hintText: "Input Nama Customer"),
      controller: _emailCtrl,
    );
  }

  _fieldPhoneNumber() {
    return TextField(
      decoration: const InputDecoration(
          floatingLabelStyle: TextStyle(color: Colors.red),
          labelText: "Alamat Customer",
          hintText: "Input Alamat Customer"),
      controller: _phoneNumberCtrl,
    );
  }

  _fieldAddress() {
    return TextField(
      decoration: const InputDecoration(
          floatingLabelStyle: TextStyle(color: Colors.red),
          labelText: "Customer Alamat",
          hintText: "Input Customer alamat"),
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
          String id = widget.customer.id.toString();
          await CustomerService().ubah(customer, id).then((value) {
            Navigator.pop(context);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => CustomerDetail(customer: value)));
          });
        },
        child: const Text("Simpan Perubahan"));
  }
}
