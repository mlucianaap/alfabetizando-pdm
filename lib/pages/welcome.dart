import 'package:alfabetizando/components/buttom.dart';
import 'package:alfabetizando/models/alfabetizando_services.dart';
import 'package:alfabetizando/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/app_routes.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  static const Color cinza = Constants.ligthGrey;
  String id = FirebaseAuth.instance.currentUser!.uid;

  String msg =
      "Tudo bem?\n\nNós, do Alfabetizando, preparamos com carinho um ambiente especial de aprendizado para adultos e idosos.";

  int contador = 0;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AlfabetizandoServices>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0, top: 50.0),
                      child: contador != 0
                          ? Text('')
                          : Text(
                              'Olá, ${provider.alfabetizando!.nome}!',
                              style: Theme.of(context).textTheme.headline1,
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: Text(
                        msg,
                        style: Theme.of(context).textTheme.headline5,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 1),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Buttom(
              texto: contador >= 2 ? 'Começar' : 'Próximo',
              submitForm: (BuildContext context) async {
                setState(() {
                  contador++;
                });

                print(contador);
                if (contador == 1) {
                  msg =
                      'Você será o responsável por um alfabetizando e poderá acompanhar o seu progresso.';
                } else if (contador == 2) {
                  msg =
                      'No alfabetizando, será apresentado inicialmente as letras que compõem o alfabeto. Depois as sílabas simples e a formação de palavras.';
                } else if (contador > 2) {
                  await FirebaseFirestore.instance
                      .collection('alfabetizandos')
                      .doc(id)
                      .update({
                    "novoUsuario": false,
                  }).then((value) {
                    Navigator.of(context).pushReplacementNamed(
                      AppRoutes.niveis,
                    );
                  });
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 55,
                  height: 9,
                  decoration:
                      BoxDecoration(color: Theme.of(context).primaryColor),
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                  width: 55,
                  height: 9,
                  decoration: contador >= 1
                      ? BoxDecoration(color: Theme.of(context).primaryColor)
                      : BoxDecoration(color: cinza),
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                  width: 55,
                  height: 9,
                  decoration: contador >= 2
                      ? BoxDecoration(color: Theme.of(context).primaryColor)
                      : BoxDecoration(color: cinza),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
