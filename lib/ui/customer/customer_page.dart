// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kelas_7ad/widget/sidebar.dart';
import '../../model/customer.dart';
import '../../service/customer_service.dart';
import 'customer_form.dart';
import 'customer_item.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key});

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  Stream<List<Customer>> getList() async* {
    List<Customer> data = await CustomerService().listData();
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Customer"),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CustomerForm()));
              },
              child: Icon(Icons.add))
        ],
      ),
      drawer: Sidebar(),
      body: StreamBuilder(
        stream: getList(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return Text('Data Kosong');
          }
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return CustomerItem(customer: snapshot.data[index]);
            },
          );
        },
      ),
    );
  }
}
