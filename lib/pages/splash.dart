import 'package:alfabetizando/utils/app_routes.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  _Splash createState() => _Splash();
}

class _Splash extends State<Splash> {
  bool animate = false;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    Widget _imagem1 = Image.asset(
      'imagens/inicio2.png',
      fit: BoxFit.cover,
    );

    Widget _imagem2 = Image.asset(
      'imagens/inicio1.png',
      fit: BoxFit.cover,
    );
    return AnimatedOpacity(
      duration: Duration(milliseconds: 1600),
      opacity: animate ? 1 : 0,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 27, 197, 160),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _imagem1,
                  Text(
                    'Bem vindo ao',
                    textDirection: TextDirection.ltr,
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(color: Colors.white),
                  ),
                  Text(
                    'Alfabetizando',
                    textDirection: TextDirection.ltr,
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(fontSize: 40),
                  ),
                  _imagem2
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _startAnimation() async {
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      animate = true;
    });
    await Future.delayed(Duration(milliseconds: 5000));
    Navigator.of(context).pushReplacementNamed(
      AppRoutes.login,
    );
  }
}
