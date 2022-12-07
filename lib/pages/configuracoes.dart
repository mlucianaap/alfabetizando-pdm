import 'package:alfabetizando/components/buttom.dart';
import 'package:alfabetizando/components/drawer.dart';
import 'package:alfabetizando/models/alfabetizando.dart';
import 'package:alfabetizando/models/alfabetizando_services.dart';
import 'package:alfabetizando/utils/app_routes.dart';
import 'package:alfabetizando/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConfiguracoesPage extends StatefulWidget {
  ConfiguracoesPage({super.key});

  @override
  State<ConfiguracoesPage> createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  final _formKey = GlobalKey<FormState>();

  final _formData = Map<String, String>();
  String id = FirebaseAuth.instance.currentUser!.uid;
  bool obscurePassword = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final alfabetizando = arg as Alfabetizando;
        _formData['id'] = alfabetizando.id;
        _formData['name'] = alfabetizando.nome;
        _formData['email'] = alfabetizando.email;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    Provider.of<AlfabetizandoServices>(
      context,
      listen: false,
    ).loadAlfabetizando(id);
  }

  void _showMsg(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: color,
      ),
    );
  }

  Future<void> _submitForm(BuildContext context) async {
    _formKey.currentState?.save();
    print(_formData);

    String email = _formData['email']!;
    String senha = _formData['password']!;

    try {
      await Provider.of<AlfabetizandoServices>(
        context,
        listen: false,
      ).saveAlfabetizando(_formData, FirebaseAuth.instance.currentUser!.uid);
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: senha);
      User user = await FirebaseAuth.instance.currentUser!;
      try {
        await user.updateEmail(email);
        if (senha != '') {
          await user.updatePassword(senha).then((value) {
            user.reauthenticateWithCredential(credential);
          });
        }
      } catch (e) {
        _showMsg('$e', Colors.red);
      }
      _showMsg('Dados atualizados com sucesso!', Colors.green);
    } catch (error) {
      print(error);
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Ocorreu um erro!'),
          content: const Text('Ocorreu um erro para salvar o alfabetizando.'),
          actions: [
            TextButton(
              child: const Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _apagarConta(BuildContext context) async {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Atenção!'),
        content: const Text('Deseja realmente apagar sua conta.'),
        actions: [
          TextButton(
            child: const Text('Não'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text('Sim'),
            onPressed: () async {
              try {
                await Provider.of<AlfabetizandoServices>(
                  context,
                  listen: false,
                ).removeAlfabetizando(id).then((value) {
                  Navigator.of(context).pushReplacementNamed(
                    AppRoutes.login,
                  );
                });
              } catch (error) {
                print(error);
                await showDialog<void>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Ocorreu um erro!'),
                    content: const Text('Ocorreu um erro ao apagar a conta.'),
                    actions: [
                      TextButton(
                        child: const Text('Ok'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AlfabetizandoServices>(context, listen: false);
    provider.loadAlfabetizando(id);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Configurações",
          style: Theme.of(context).textTheme.headline4,
        ),
        elevation: 0,
        toolbarHeight: MediaQuery.of(context).size.width / 3.5,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: TextFormField(
                        initialValue: provider.alfabetizando!.nome,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Nome',
                          hintStyle: Theme.of(context).textTheme.headline6,
                          filled: true,
                          fillColor: Colors.grey[200],
                          contentPadding: EdgeInsets.all(20),
                        ),
                        onFieldSubmitted: (_) => _submitForm(context),
                        onSaved: (nome) => _formData['name'] =
                            nome ?? provider.alfabetizando!.nome,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextFormField(
                        initialValue: provider.alfabetizando!.email,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          hintText: 'Email',
                        ),
                        onFieldSubmitted: (_) => _submitForm(context),
                        onSaved: (email) => _formData['email'] =
                            email ?? provider.alfabetizando!.email,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: obscurePassword,
                        decoration: InputDecoration(
                          hintText: 'Senha',
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
                        onFieldSubmitted: (_) => _submitForm(context),
                        onSaved: (senha) => _formData['password'] = senha ?? '',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Buttom(
                        texto: 'Salvar',
                        submitForm: _submitForm,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          MediaQuery.of(context).viewInsets.bottom == 0
              ? Padding(
                  padding: EdgeInsets.all(25.0),
                  child: Buttom(
                    texto: 'Apagar Conta',
                    submitForm: _apagarConta,
                    color: Color.fromRGBO(234, 96, 85, 1),
                  ),
                )
              : SizedBox(),
        ],
      ),
      drawer: MyDrawer(),
    );
  }
}
