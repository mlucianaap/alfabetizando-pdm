import 'package:alfabetizando/components/buttom.dart';
import 'package:alfabetizando/models/falar.dart';
import 'package:alfabetizando/utils/app_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/alfabetizando_services.dart';

class Fim extends StatefulWidget {
  const Fim({super.key});

  @override
  State<Fim> createState() => _FimState();
}

class _FimState extends State<Fim> {
  int nivel = 1;
  String msg = '';
  String id = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    var provider = Provider.of<AlfabetizandoServices>(context, listen: false);
    nivel = provider.alfabetizando!.nivel;
    switch (nivel) {
      case 1:
        setState(() {
          msg =
              'Nesta lição você aprendeu o alfabeto. Na próxima lição você vai aprender as sílabas.';
        });
        break;
      case 2:
        setState(() {
          msg =
              'Nesta lição você aprendeu as sílabas. Na próxima lição você vai aprender à juntar essas sílabas e formar palavras.';
        });
        break;
      case 3:
        setState(() {
          msg =
              'Agora você já consegue ler pequenas palavras. Continue estudando para se aperfeiçoar.';
        });
        break;
      default:
    }
    Audio().falar('Parabéns!' + msg);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Parabéns! 🎉',
                  style: Theme.of(context).textTheme.headline1,
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    textAlign: TextAlign.center,
                    msg,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                SizedBox(height: 30),
                Buttom(
                    texto: 'Continuar',
                    submitForm: (context) async {
                      print(nivel);
                      await FirebaseFirestore.instance
                          .collection('alfabetizandos')
                          .doc(id)
                          .update({
                        "nivel": nivel + 1,
                      }).then((value) {
                        Provider.of<AlfabetizandoServices>(context,
                                listen: false)
                            .loadAlfabetizando(id)
                            .then((value) {
                          Navigator.of(context).pushReplacementNamed(
                            AppRoutes.niveis,
                          );
                        });
                      });
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
