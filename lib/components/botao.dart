import 'package:flutter/material.dart';

class Botao extends StatelessWidget {
  final String texto;
  final Color corDaLetra;
  final Color background;
  final String som;
  final void Function(String) funcao;

  const Botao({
    Key? key,
    required this.texto,
    this.corDaLetra = Colors.white,
    required this.background,
    this.som = '',
    required this.funcao,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        texto,
        style:
            Theme.of(context).textTheme.bodyText2!.copyWith(color: corDaLetra),
      ),
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      onPressed: () => funcao(som),
    );
  }
}
