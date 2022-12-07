import 'package:alfabetizando/models/silabas.dart';
import 'package:alfabetizando/pages/silabas_2.dart';
import 'package:flutter/material.dart';

class Consoante extends StatelessWidget {
  final Silaba silabas;
  //final void Function(String) funcao;

  void _selectConsoante(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return Silabas2(silaba: silabas);
        },
      ),
    );
  }

  const Consoante({
    required this.silabas,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        silabas.consoante,
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(color: silabas.corDaLetra),
      ),
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: silabas.background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      ),
      onPressed: () => _selectConsoante(context),
    );
  }
}
