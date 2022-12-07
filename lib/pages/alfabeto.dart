import 'package:alfabetizando/components/buttom.dart';
import 'package:alfabetizando/models/alfabetizando_services.dart';
import 'package:alfabetizando/models/falar.dart';
import 'package:alfabetizando/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Alfabeto extends StatelessWidget {
  Alfabeto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 120,
        flexibleSpace: Container(
          padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Alfabeto",
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
              Row(
                children: [
                  Text(
                    "Clique nas letras",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: MeuAlfabeto(),
    );
  }
}

class MeuAlfabeto extends StatelessWidget {
  const MeuAlfabeto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AlfabetizandoServices>(context, listen: false);
    Widget botaoLaranja(String letra) {
      return Botao(
        letra: letra,
        corDaLetra: Color.fromARGB(255, 221, 135, 65),
        background: Color.fromARGB(255, 255, 214, 100),
      );
    }

    Widget botaoVerde(String letra) {
      return Botao(
        letra: letra,
        background: Theme.of(context).primaryColor,
      );
    }

    Widget botaoVermelho(String letra) {
      return Botao(
        letra: letra,
        background: Color.fromARGB(255, 234, 96, 85),
      );
    }

    Widget botaoRoxo(String letra) {
      return Botao(
        letra: letra,
        background: Color.fromARGB(255, 130, 87, 229),
      );
    }

    return Container(
      child: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              crossAxisCount: 4,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              children: [
                botaoLaranja('A'),
                botaoVerde('B'),
                botaoVermelho('C'),
                botaoRoxo('D'),
                botaoRoxo('E'),
                botaoVermelho('F'),
                botaoLaranja('G'),
                botaoVerde('H'),
                botaoLaranja('I'),
                botaoVerde('J'),
                botaoRoxo('K'),
                botaoVermelho('L'),
                botaoVermelho('M'),
                botaoRoxo('N'),
                botaoVerde('O'),
                botaoLaranja('P'),
                botaoVerde('Q'),
                botaoVermelho('R'),
                botaoLaranja('S'),
                botaoRoxo('T'),
                botaoLaranja('U'),
                botaoRoxo('V'),
                botaoVerde('W'),
                botaoVermelho('X'),
                botaoVermelho('Y'),
                botaoVerde('Z'),
              ],
            ),
          ),
          provider.alfabetizando!.nivel == 1
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

class Botao extends StatelessWidget {
  final String letra;
  final Color corDaLetra;
  final Color background;

  const Botao({
    Key? key,
    required this.letra,
    this.corDaLetra = Colors.white,
    required this.background,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        letra,
        style:
            Theme.of(context).textTheme.bodyText2!.copyWith(color: corDaLetra),
      ),
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        padding: EdgeInsets.all(10),
      ),
      onPressed: () => Audio().falar(letra),
    );
  }
}
