import 'package:alfabetizando/components/botao.dart';
import 'package:alfabetizando/components/buttom.dart';
import 'package:alfabetizando/models/alfabetizando_services.dart';
import 'package:alfabetizando/models/falar.dart';
import 'package:alfabetizando/models/silabas.dart';
import 'package:alfabetizando/utils/app_routes.dart';
import 'package:alfabetizando/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Silabas2 extends StatefulWidget {
  final Silaba silaba;

  Silabas2({required this.silaba});

  @override
  State<Silabas2> createState() => _Silabas2State();
}

class _Silabas2State extends State<Silabas2> {
  String urlImagem = '';
  String id = FirebaseAuth.instance.currentUser!.uid;

  Widget botao(String silaba, String som) {
    return Botao(
      texto: silaba,
      corDaLetra: Constants.orange,
      background: Constants.yellow,
      som: som,
      funcao: (som) async {
        setState(() {
          if (silaba == this.widget.silaba.silaba1) {
            urlImagem = this.widget.silaba.urlImagem1;
          } else if (silaba == this.widget.silaba.silaba2) {
            urlImagem = this.widget.silaba.urlImagem2;
          } else if (silaba == this.widget.silaba.silaba3) {
            urlImagem = this.widget.silaba.urlImagem3;
          } else if (silaba == this.widget.silaba.silaba4) {
            urlImagem = this.widget.silaba.urlImagem4;
          } else if (silaba == this.widget.silaba.silaba5) {
            urlImagem = this.widget.silaba.urlImagem5;
          } else if (silaba == this.widget.silaba.silaba6) {
            urlImagem = this.widget.silaba.urlImagem6;
          }
        });

        Audio().falar(som);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AlfabetizandoServices>(context, listen: false);
    provider.loadAlfabetizando(id);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 120,
        flexibleSpace: Container(
          padding: EdgeInsets.fromLTRB(40, 40, 40, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sílabas - ${widget.silaba.consoante}",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.clear_rounded,
                      size: 50,
                      color: Color.fromRGBO(217, 217, 217, 1),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              botao(widget.silaba.silaba1, widget.silaba.som1),
                        ),
                        widget.silaba.silaba2 != ''
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: botao(
                                    widget.silaba.silaba2, widget.silaba.som2),
                              )
                            : SizedBox(),
                        widget.silaba.silaba6 != ''
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: botao(
                                    widget.silaba.silaba3, widget.silaba.som3),
                              )
                            : SizedBox(),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        widget.silaba.silaba4 != ''
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: botao(
                                    widget.silaba.silaba4, widget.silaba.som4),
                              )
                            : SizedBox(),
                        widget.silaba.silaba5 != ''
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: botao(
                                    widget.silaba.silaba5, widget.silaba.som5),
                              )
                            : SizedBox(),
                      ],
                    ),
                    widget.silaba.silaba6 != ''
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: botao(
                                    widget.silaba.silaba6, widget.silaba.som6),
                              ),
                            ],
                          )
                        : SizedBox(),
                    SizedBox(height: 40),
                    urlImagem != ''
                        ? Image.network(
                            urlImagem,
                            fit: BoxFit.contain,
                            cacheHeight: 200,
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            ),
          ),
          provider.alfabetizando!.nivel == 2 && widget.silaba.consoante == 'Z'
              ? Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Buttom(
                    texto: 'Continuar',
                    submitForm: (context) {
                      Navigator.of(context).pushReplacementNamed(
                        AppRoutes.fim,
                      );
                    },
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
