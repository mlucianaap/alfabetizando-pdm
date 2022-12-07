import 'package:alfabetizando/models/alfabetizando.dart';
import 'package:alfabetizando/models/firebase_auth_service.dart';
import 'package:alfabetizando/pages/alfabeto.dart';
import 'package:alfabetizando/pages/atividade_ler.dart';
import 'package:alfabetizando/pages/cadastro.dart';
import 'package:alfabetizando/pages/configuracoes.dart';
import 'package:alfabetizando/pages/fim.dart';
import 'package:alfabetizando/pages/login.dart';
import 'package:alfabetizando/pages/senha.dart';
import 'package:alfabetizando/pages/silabas_1.dart';
import 'package:alfabetizando/pages/sobre.dart';
import 'package:alfabetizando/pages/splash.dart';
import 'package:alfabetizando/pages/welcome.dart';
import 'package:alfabetizando/pages/niveis.dart';
import 'package:alfabetizando/theme/app_theme.dart';
import 'package:alfabetizando/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/alfabetizando_services.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  runApp(MyApp());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => FirebaseAuthService(),
        ),
        ChangeNotifierProxyProvider<FirebaseAuthService, AlfabetizandoServices>(
          create: (_) => AlfabetizandoServices(''),
          update: (context, auth, previous) {
            return AlfabetizandoServices(
              auth.userId ?? '',
              previous?.alfabetizando ??
                  Alfabetizando(
                      id: '',
                      nome: '',
                      email: '',
                      nivel: 1,
                      novoUsuario: false),
            );
          },
        ),
      ],
      child: MaterialApp(
        theme: appThemeData,
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoutes.splash: (ctx) => Splash(),
          AppRoutes.login: (cxt) => LoginPage(),
          AppRoutes.cadastro: (ctx) => CadastroPage(),
          AppRoutes.welcome: (ctx) => Welcome(),
          AppRoutes.niveis: (ctx) => const Niveis(),
          AppRoutes.sobre: (ctx) => SobrePage(),
          AppRoutes.configuracoes: (cxt) => ConfiguracoesPage(),
          AppRoutes.alfabeto: (ctx) => Alfabeto(),
          AppRoutes.atividade_ler: (ctx) => AtividadeLer(),
          AppRoutes.silabas1: (ctx) => Silabas1(),
          AppRoutes.esqueceu_senha: (cxt) => EsqueceuSenha(),
          AppRoutes.fim: (cxt) => Fim(),
        },
      ),
    );
  }
}
