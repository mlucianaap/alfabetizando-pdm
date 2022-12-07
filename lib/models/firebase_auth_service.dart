import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthService with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  String? _userId;

  bool get isAuth {
    final isValid = auth.currentUser != null;
    return isValid;
  }

  String? get userId {
    return isAuth ? _userId : null;
  }

  Future<void> login(String email, String password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signup(String email, String password, String name) async {
    UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    if (credential.user == null) return;

    credential.user?.updateDisplayName(name);
    _userId = credential.user!.uid;
    print(_userId);
    notifyListeners();
  }

  Future<void> logout() async {
    await auth.signOut().then((value) {
      addListener(() {
        _userId = null;
      });
    });

    notifyListeners();
  }

  Future<String> passwordReset(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'O e-mail fornecido não está associado a nenhum usuário.';
      }
    } catch (e) {
      return 'Ocorreu um erro inesperado!';
    }
    return 'E-mail enviado com sucesso! Verifique sua caixa de SPAM.';
  }
}
