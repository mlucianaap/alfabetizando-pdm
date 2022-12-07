import 'dart:math';
import 'package:alfabetizando/models/alfabetizando_services.dart';
import 'package:alfabetizando/utils/app_routes.dart';
import 'package:alfabetizando/utils/constants.dart';
import 'package:alfabetizando/utils/palavras.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class AtividadeLer extends StatefulWidget {
  const AtividadeLer({super.key});

  @override
  _AtividadeLer createState() => _AtividadeLer();
}

class _AtividadeLer extends State<AtividadeLer> {
  String urlImagem = '';
  String silaba1 = '';
  String silaba2 = '';
  String silaba3 = '';
  String silaba4 = '';
  String silaba5 = '';

  int qtdSilabas = 0;

  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _text = '';
  String resultado = '';
  String palavra = '';

  @override
  void initState() {
    setState(() {
      _gerarPalavra();
    });
    super.initState();
  }

  void _gerarPalavra() {
    _text = '';
    var num = Random().nextInt(PALAVRAS.length - 1);
    palavra = PALAVRAS[num].palavra;
    silaba1 = PALAVRAS[num].silabasDaPalavra1;
    silaba2 = PALAVRAS[num].silabasDaPalavra2;
    silaba3 = PALAVRAS[num].silabasDaPalavra3;
    silaba4 = PALAVRAS[num].silabasDaPalavra4;
    silaba5 = PALAVRAS[num].silabasDaPalavra5;
    urlImagem = PALAVRAS[num].urlImagem;
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
          }),
        );
      }

      print(_isListening);
    } else {
      setState(() => _isListening = false);
      _speech.stop();
      print(_isListening);
    }
  }

  void _showMsg(String msg, Color cor, Color corDaLetra) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Text(
              msg,
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(color: corDaLetra),
            ),
            SizedBox(width: 10),
            corDaLetra == Colors.green
                ? Icon(
                    Icons.thumb_up,
                    color: corDaLetra,
                  )
                : SizedBox(),
          ],
        ),
        backgroundColor: cor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AlfabetizandoServices>(context, listen: false);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 80,
        leadingWidth: 10,
        title: Text('Fale a palavra:',
            style: Theme.of(context).textTheme.headline4),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: GestureDetector(
              child: Icon(
                Icons.clear_rounded,
                size: 50,
                color: Color.fromRGBO(217, 217, 217, 1),
              ),
              onTap: () {
                if (provider.alfabetizando!.nivel == 3) {
                  Navigator.of(context).pushReplacementNamed(
                    AppRoutes.fim,
                  );
                } else {
                  Navigator.pop(context);
                }
              },
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          silaba1,
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: Constants.grey,
                                  ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          '+',
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: Constants.grey,
                                  ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          silaba2,
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: Constants.grey,
                                  ),
                        ),
                        silaba3 != '' ? SizedBox(width: 5) : SizedBox(),
                        silaba3 != ''
                            ? Text(
                                '+',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      color: Constants.grey,
                                    ),
                              )
                            : SizedBox(),
                        silaba3 != '' ? SizedBox(width: 5) : SizedBox(),
                        Text(
                          silaba3,
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: Constants.grey,
                                  ),
                        ),
                        silaba4 != '' ? SizedBox(width: 5) : SizedBox(),
                        silaba4 != ''
                            ? Text(
                                '+',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      color: Constants.grey,
                                    ),
                              )
                            : SizedBox(),
                        silaba4 != '' ? SizedBox(width: 5) : SizedBox(),
                        Text(
                          silaba4,
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: Constants.grey,
                                  ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    urlImagem != ''
                        ? Image.network(
                            urlImagem,
                            fit: BoxFit.contain,
                            height: MediaQuery.of(context).size.height / 4,
                          )
                        : SizedBox(),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: -2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lightBlue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              padding: EdgeInsets.all(15),
                            ).copyWith(
                                elevation: ButtonStyleButton.allOrNull(0.0)),
                            onPressed: _listen,
                            child: Icon(
                                _isListening ? Icons.mic : Icons.mic_none,
                                size: 100)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Constants.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    padding: EdgeInsets.all(15),
                  ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                  onPressed: _text != ''
                      ? () {
                          if (_text.trim() == palavra) {
                            setState(() {
                              _gerarPalavra();
                            });
                            _showMsg('Correto!',
                                Color.fromRGBO(215, 255, 184, 1), Colors.green);
                          } else {
                            setState(() {
                              _text = '';
                            });
                            _showMsg(
                                'Incorreto!',
                                Color.fromRGBO(255, 223, 224, 1),
                                Constants.red);
                          }
                        }
                      : null,
                  child: Text(
                    'Verificar',
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: Colors.white),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
