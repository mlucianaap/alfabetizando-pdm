import 'package:alfabetizando/components/drawer.dart';
import 'package:alfabetizando/models/alfabetizando_services.dart';
import 'package:alfabetizando/utils/app_routes.dart';
import 'package:alfabetizando/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Niveis extends StatefulWidget {
  const Niveis({Key? key}) : super(key: key);

  @override
  State<Niveis> createState() => _NiveisState();
}

class _NiveisState extends State<Niveis> {
  final corDaLetra = Color.fromARGB(255, 221, 135, 65);
  final amarelo = Color.fromARGB(255, 255, 214, 100);
  final vermelho = Color.fromARGB(255, 234, 96, 85);
  int nivel = 1;

  @override
  Widget build(BuildContext context) {
    setState(() {
      Provider.of<AlfabetizandoServices>(
        context,
        listen: false,
      ).loadAlfabetizando(FirebaseAuth.instance.currentUser!.uid);
    });

    var provider = Provider.of<AlfabetizandoServices>(context, listen: false);
    nivel = provider.alfabetizando!.nivel;
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Alfabetizando",
          style: Theme.of(context).textTheme.headline4,
        ),
        elevation: 0,
        toolbarHeight: MediaQuery.of(context).size.width / 4,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 25,
                    bottom: 30,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Vamos aprender?",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5),
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: amarelo,
                                ),
                                child: Center(
                                  child: Text(
                                    'A',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          color: corDaLetra,
                                          fontSize: 20,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'B',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                            fontSize: 20,
                                          ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8.0,
                                  ),
                                  child: Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: vermelho,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'C',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                              fontSize: 20,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Text(
                          'Alfabeto',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(245, 245, 245, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      padding: EdgeInsets.all(20),
                    ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                    onPressed: () => {
                      Navigator.of(context).pushNamed(
                        AppRoutes.alfabeto,
                      ),
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                        color: nivel >= 2
                            ? Constants.ligthBlue
                            : Constants.maisLigthGrey,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                        color: nivel >= 2
                            ? Constants.ligthBlue
                            : Constants.maisLigthGrey,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                        color: nivel >= 2
                            ? Constants.ligthBlue
                            : Constants.maisLigthGrey,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                        color: nivel >= 2
                            ? Constants.ligthBlue
                            : Constants.maisLigthGrey,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5),
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Container(
                                width: 45,
                                height: 35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: vermelho,
                                ),
                                child: Center(
                                  child: Text(
                                    'BA',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          fontSize: 20,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 45,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: amarelo,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'PA',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                            color: corDaLetra,
                                            fontSize: 20,
                                          ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8.0,
                                  ),
                                  child: Container(
                                    width: 45,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'TO',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                              fontSize: 20,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Text(
                          'Sílabas',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Constants.maisLigthGrey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      padding: EdgeInsets.all(20),
                    ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                    onPressed: nivel >= 2
                        ? () => {
                              Navigator.of(context).pushNamed(
                                AppRoutes.silabas1,
                              ),
                            }
                        : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                        color: nivel >= 3
                            ? Constants.ligthBlue
                            : Constants.maisLigthGrey,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                        color: nivel >= 3
                            ? Constants.ligthBlue
                            : Constants.maisLigthGrey,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                        color: nivel >= 3
                            ? Constants.ligthBlue
                            : Constants.maisLigthGrey,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                        color: nivel >= 3
                            ? Constants.ligthBlue
                            : Constants.maisLigthGrey,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5),
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 45,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'PA',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                            fontSize: 20,
                                          ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    '+',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  width: 45,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'TO',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                            fontSize: 20,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Text(
                          'Ler',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(245, 245, 245, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 38),
                    ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                    onPressed: nivel >= 3
                        ? () => {
                              Navigator.of(context).pushNamed(
                                AppRoutes.atividade_ler,
                              ),
                            }
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
