import 'package:alfabetizando/components/buttom.dart';
import 'package:alfabetizando/models/firebase_auth_service.dart';
import 'package:alfabetizando/utils/app_routes.dart';
import 'package:alfabetizando/utils/constants.dart';
import 'package:alfabetizando/utils/validations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/alfabetizando_services.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  static const Color cinza = Color.fromRGBO(162, 162, 162, 1);

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> with Validations {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, String>{};

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  void _showMsg(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: color,
      ),
    );
  }

  Future<void> _submitForm(BuildContext context) async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    _formKey.currentState?.save();

    FirebaseAuthService auth = Provider.of(context, listen: false);

    try {
      await auth.signup(
          _formData['email']!, _formData['password']!, _formData['name']!);

      try {
        await auth.login(_formData['email']!, _formData['password']!);
        var provider =
            Provider.of<AlfabetizandoServices>(context, listen: false);
        await provider
            .saveAlfabetizando(
                _formData, FirebaseAuth.instance.currentUser!.uid)
            .then((value) async {
          _showMsg('Cadastro realizado com sucesso!', Colors.green);
          Navigator.of(context).pushReplacementNamed(
            AppRoutes.welcome,
          );
        });
      } catch (error) {
        _showMsg('Ocorreu um erro ao salvar os dados! $error', Colors.red);
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        _showMsg('E-mail associado à uma conta!', Colors.red);
      } else {
        _showMsg(error.toString(), Colors.red);
      }
    } catch (error) {
      _showMsg('Ocorreu um erro inesperado! $error', Colors.red);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 80.0, bottom: 40.0),
                    child: Text(
                      'Criar Conta',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: "Nome",
                    ),
                    onSaved: (nome) => _formData['name'] = nome ?? '',
                    validator: (_nome) =>
                        isNotEmpty(_nome, 'O nome é obrigatório.'),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: "Email",
                    ),
                    onSaved: (email) => _formData['email'] = email ?? '',
                    validator: (email) => combine([
                      () => isNotEmpty(email, "E-mail é obrigatório"),
                      () => isEmailValid(email),
                    ]),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _passwordController,
                    obscureText: obscurePassword,
                    decoration: InputDecoration(
                      hintText: "Senha",
                      suffixIcon: IconButton(
                        splashRadius: Material.defaultSplashRadius / 2,
                        onPressed: () =>
                            setState(() => obscurePassword = !obscurePassword),
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
                  SizedBox(height: 20),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _passwordConfirmController,
                    obscureText: obscureConfirmPassword,
                    decoration: InputDecoration(
                      hintText: "Confirmar Senha",
                      suffixIcon: IconButton(
                        splashRadius: Material.defaultSplashRadius / 2,
                        onPressed: () => setState(() =>
                            obscureConfirmPassword = !obscureConfirmPassword),
                        icon: Icon(
                          obscureConfirmPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Constants.grey,
                        ),
                      ),
                    ),
                    validator: (senha) => combine([
                      () => isNotEmpty(senha, "A senha é obrigatória"),
                      () => isPasswordValid(senha),
                      () => isEqualsPassword(_passwordController.text, senha),
                    ]),
                  ),
                  SizedBox(height: 30),
                  Buttom(
                    texto: 'Cadastrar',
                    submitForm: (BuildContext context) => _submitForm(context),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed(
                          AppRoutes.login,
                        );
                      },
                      child: Text(
                        'Entrar',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
