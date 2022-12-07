import 'package:flutter/material.dart';

class Silaba {
  final String consoante;
  final String silaba1;
  final String silaba2;
  final String silaba3;
  final String silaba4;
  final String silaba5;
  final String silaba6;
  final String som1;
  final String som2;
  final String som3;
  final String som4;
  final String som5;
  final String som6;
  final String urlImagem1;
  final String urlImagem2;
  final String urlImagem3;
  final String urlImagem4;
  final String urlImagem5;
  final String urlImagem6;
  final Color background;
  final Color corDaLetra;

  const Silaba({
    required this.consoante,
    required this.silaba1,
    required this.silaba2,
    this.silaba3 = '',
    this.silaba4 = '',
    this.silaba5 = '',
    this.silaba6 = '',
    required this.som1,
    required this.som2,
    this.som3 = '',
    this.som4 = '',
    this.som5 = '',
    this.som6 = '',
    this.urlImagem1 = '',
    this.urlImagem2 = '',
    this.urlImagem3 = '',
    this.urlImagem4 = '',
    this.urlImagem5 = '',
    this.urlImagem6 = '',
    required this.background,
    this.corDaLetra = Colors.white,
  });
}
