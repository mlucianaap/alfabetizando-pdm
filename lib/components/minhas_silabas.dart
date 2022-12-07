import 'package:alfabetizando/components/consoante.dart';
import 'package:alfabetizando/utils/constants.dart';
import 'package:flutter/material.dart';

class MinhasSilabas extends StatefulWidget {
  const MinhasSilabas({Key? key}) : super(key: key);

  @override
  State<MinhasSilabas> createState() => _MinhasSilabasState();
}

class _MinhasSilabasState extends State<MinhasSilabas> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        crossAxisCount: 4,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        children: SILABAS.map((cat) {
          return Consoante(silabas: cat);
        }).toList(),
      ),
    );
  }
}
