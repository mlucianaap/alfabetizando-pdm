import 'package:alfabetizando/models/alfabetizando.dart';
import 'package:alfabetizando/models/alfabetizando_services.dart';
import 'package:alfabetizando/models/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/app_routes.dart';

class MyDrawer extends StatefulWidget {
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  late NavigatorState _navigator;
  late Alfabetizando? alfabetizando;

  @override
  void initState() {
    Provider.of<AlfabetizandoServices>(context, listen: false)
        .loadAlfabetizando(FirebaseAuth.instance.currentUser!.uid);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _navigator = Navigator.of(context);
    super.didChangeDependencies();
  }

  _logout() {
    try {
      FirebaseAuthService().logout().then((value) {
        print(FirebaseAuth.instance.currentUser);
        _navigator.pushNamed(
          AppRoutes.login,
        );
      });
    } on FirebaseAuth catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: ListTile(
              title: Align(
                alignment: Alignment.center,
                child: Text(
                  'Início',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                print('Você clicou em Início!');
                Navigator.of(context).pushReplacementNamed(
                  AppRoutes.niveis,
                );
              },
            ),
          ),
          ListTile(
            title: Align(
              alignment: Alignment.center,
              child: Text(
                'Sobre',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              print('Você clicou no Sobre!');
              Navigator.of(context).pushReplacementNamed(
                AppRoutes.sobre,
              );
            },
          ),
          ListTile(
              title: Align(
                alignment: Alignment.center,
                child: Text(
                  'Configurações',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                print('Você clicou em Configurações!');
                Navigator.of(context).pushReplacementNamed(
                  AppRoutes.configuracoes,
                );
              }),
          ListTile(
            title: Align(
              alignment: Alignment.center,
              child: Text(
                'Sair',
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Colors.red),
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              print('Você clicou em Sair!');

              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Sair'),
                  content: const Text('Você deseja realmente sair?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Não'),
                    ),
                    TextButton(
                      onPressed: _logout,
                      child: const Text('Sim'),
                    ),
                  ],
                ),
              );
            },
            textColor: Colors.red,
          ),
        ],
      ),
    );
  }
}
