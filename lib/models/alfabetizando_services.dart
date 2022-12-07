import 'package:alfabetizando/models/alfabetizando.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AlfabetizandoServices with ChangeNotifier {
  final String _userId;
  Alfabetizando? _alfabetizando;

  Alfabetizando? get alfabetizando => _alfabetizando;

  AlfabetizandoServices(this._userId, [this._alfabetizando]);

  var db = FirebaseFirestore.instance.collection('alfabetizandos');
  var auth = FirebaseAuth.instance;

  Future<void> loadAlfabetizando(String id) async {
    try {
      var result = await db.doc(id).get();

      _alfabetizando = Alfabetizando(
        id: _userId,
        nome: result['name'],
        email: result['email'],
        nivel: result['nivel'],
        novoUsuario: result['novoUsuario'],
      );
    } catch (e) {
      print(e);
    }

    notifyListeners();
  }

  Future<void> saveAlfabetizando(Map<String, Object> data, String id) {
    bool hasId = data['id'] != null;

    final alfabetizando = Alfabetizando(
      id: hasId ? data['id'] as String : id,
      nome: data['name'] as String,
      email: data['email'] as String,
      nivel: 1,
      novoUsuario: false,
    );

    if (hasId) {
      return updateAlfabetizando(alfabetizando);
    } else {
      return addAlfabetizando(alfabetizando);
    }
  }

  Future<void> addAlfabetizando(Alfabetizando alfabetizando) async {
    db.doc(_userId).set({
      "name": alfabetizando.nome,
      "email": alfabetizando.email,
      "nivel": 1,
      "novoUsuario": true,
    });

    _alfabetizando = Alfabetizando(
      id: _userId,
      nome: alfabetizando.nome,
      email: alfabetizando.email,
      nivel: 1,
      novoUsuario: true,
    );
    notifyListeners();
  }

  Future<void> updateAlfabetizando(Alfabetizando alfabetizando) async {
    db.doc(_userId).update({
      "name": alfabetizando.nome,
      "email": alfabetizando.email,
      "nivel": alfabetizando.nivel,
      "novoUsuario": false,
    });

    _alfabetizando = Alfabetizando(
      id: _userId,
      nome: alfabetizando.nome,
      email: alfabetizando.email,
      nivel: alfabetizando.nivel,
      novoUsuario: false,
    );

    notifyListeners();
  }

  Future<void> removeAlfabetizando(String id) async {
    db.doc(id).delete().then((value) async {
      await auth.currentUser?.delete();
    });
    notifyListeners();
  }
}
