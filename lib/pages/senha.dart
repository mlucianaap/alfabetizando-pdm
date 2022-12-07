import 'package:alfabetizando/components/buttom.dart';
import 'package:alfabetizando/models/firebase_auth_service.dart';
import 'package:alfabetizando/utils/app_routes.dart';
import 'package:alfabetizando/utils/constants.dart';
import 'package:alfabetizando/utils/validations.dart';
import 'package:flutter/material.dart';

class EsqueceuSenha extends StatefulWidget {
  const EsqueceuSenha({super.key});

  static const Color cinza = Color.fromRGBO(162, 162, 162, 1);

  @override
  State<EsqueceuSenha> createState() => _EsqueceuSenhaState();
}

class _EsqueceuSenhaState extends State<EsqueceuSenha> with Validations {
  final _emailController = TextEditingController();

  void _showMsg(String msg, Color cor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: cor,
      ),
    );
  }

  void _enviarSenha(BuildContext context) {
    FirebaseAuthService()
        .passwordReset(_emailController.text.trim())
        .then((msg) {
      if (msg == 'E-mail enviado com sucesso! Verifique sua caixa de SPAM.') {
        _showMsg(msg, Colors.green);
        Navigator.of(context).pushNamed(
          AppRoutes.login,
        );
      } else {
        _showMsg(msg, Constants.red);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Recuperar senha',
                  style: Theme.of(context).textTheme.headline1,
                ),
                SizedBox(
                  height: 40,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                  ),
                  validator: (email) => combine([
                    () => isNotEmpty(email, "E-mail é obrigatório"),
                    () => isEmailValid(email),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Buttom(
                    texto: 'Enviar Senha',
                    submitForm: _enviarSenha,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.login,
                    );
                  },
                  child: Text(
                    'Entrar',
                    style: Theme.of(context).textTheme.headline6,
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
