import 'package:flutter/material.dart';

import '../components/drawer.dart';

class SobrePage extends StatelessWidget {
  const SobrePage({super.key});

  static const Color cinza = Color.fromRGBO(162, 162, 162, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Sobre",
          style: Theme.of(context).textTheme.headline4,
        ),
        elevation: 0,
        toolbarHeight: MediaQuery.of(context).size.width / 3.5,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: Text(
          textAlign: TextAlign.justify,
          'O alfabetizando é um projeto desenvolvido por alunos do curso de Análise e Desenvolvimento de Sistemas do IFCE - Campus Canindé, que tem como objetivo auxiliar adultos e idosos durante o processo de alfabetização onde será possível aprender as letras do alfabeto, as sílabas e formação de palavras simples.\n\n\nEquipe:\nLuzia Vitória Lima de Sousa\nMaria Luciana Almeida Pereira\nRui Duarte do Nascimento Junior\nThaila Morais Mendes',
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Color.fromRGBO(75, 75, 75, 1)),
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}
