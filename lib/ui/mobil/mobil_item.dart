import 'package:flutter/material.dart';
import '../../model/mobil.dart';
import 'mobil_detail.dart';

class MobilItem extends StatelessWidget {
  final Mobil mobil;
  const MobilItem({super.key, required this.mobil});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MobilDetail(mobil: mobil)));
      },
      child: Card(
        child: ListTile(
          title: Text(mobil.merekMobil),
        ),
      ),
    );
  }
}
