import 'package:alfabetizando/components/buttom.dart';
import 'package:alfabetizando/models/alfabetizando_services.dart';
import 'package:alfabetizando/models/firebase_auth_service.dart';
import 'package:alfabetizando/utils/constants.dart';
import 'package:alfabetizando/utils/validations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_routes.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});
  static const Color cinza = Color.fromRGBO(162, 162, 162, 1);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with Validations {
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, String>();
  bool _isLoading = false;
  bool obscurePassword = true;
  late NavigatorState _navigator;

  @override
  void didChangeDependencies() {
    _navigator = Navigator.of(context);
    super.didChangeDependencies();
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.red,
      ),
    );
  }

  Future<void> _login(BuildContext context) async {
    final provider = Provider.of<AlfabetizandoServices>(context, listen: false);
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    _formKey.currentState?.save();
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      setState(() => _isLoading = true);

      await FirebaseAuthService()
          .login(_formData['email']!, _formData['password']!);

      if (auth.currentUser != null) {
        provider.loadAlfabetizando(auth.currentUser!.uid).then((value) {
          _navigator.pushReplacementNamed(
            AppRoutes.niveis,
          );
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _showError('Nenhum usuário encontrado para esse e-mail.');
      } else if (e.code == 'wrong-password') {
        _showError('Senha incorreta.');
      } else {
        _showError('Ocorreu um erro inesperado.');
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100.0, bottom: 20.0),
                child: Text(
                  'Entrar',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          hintText: 'Email',
                        ),
                        onFieldSubmitted: (_) => _login(context),
                        onSaved: (email) => _formData['email'] = email ?? '',
                        validator: (email) => combine([
                          () => isNotEmpty(email, "E-mail é obrigatório"),
                          () => isEmailValid(email),
                        ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: obscurePassword,
                        decoration: InputDecoration(
                          hintText: "Senha",
                          suffixIcon: IconButton(
                            splashRadius: Material.defaultSplashRadius / 2,
                            onPressed: () => setState(
                                () => obscurePassword = !obscurePassword),
                            icon: Icon(
                              obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Constants.grey,
                            ),
                          ),
                        ),
                        onSaved: (senha) => _formData['password'] = senha ?? '',
                        validator: (senha) => combine([
                          () => isNotEmpty(senha, "A senha é obrigatória"),
                          () => isPasswordValid(senha),
                        ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacementNamed(
                            AppRoutes.esqueceu_senha,
                          );
                        },
                        child: Align(
                          child: Text(
                            'Esqueceu a senha',
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      decoration: TextDecoration.underline,
                                    ),
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: _isLoading
                          ? CircularProgressIndicator()
                          : Buttom(
                              texto: 'Entrar',
                              submitForm: _login,
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacementNamed(
                            AppRoutes.cadastro,
                          );
                        },
                        child: Text(
                          'Criar conta',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
