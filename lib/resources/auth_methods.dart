import 'dart:typed_data';

import 'package:beacon/resources/storage_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:beacon/models/user.dart' as model;
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();
    //return model.User(followers: snap.data() as Map<String, dynamic>)['followers'];
    return model.User.fromSnap(snap);
  }

  //registro
  // ignore: non_constant_identifier_names
  Future<String> SignUpUser({
    required String username,
    required String email,
    required String password,
    required Uint8List file,
  }) async {
    String res = "ERROR";
    try {
      if (email.isNotEmpty || password.isNotEmpty || username.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          email: email,
          followers: [],
          following: [],
          photoUrl: photoUrl,
        );

        await _firestore.collection('users').doc(cred.user!.uid).set(
              user.toJson(),
            );
        res = "Registrado com Sucesso";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'Email incompativel';
      } else if (err.code == 'weak-password') {
        res = 'Sua senha deve conter no minimo 6 caracteres';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //Logar

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Erro ao logar";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "Logado com sucesso";
      } else {
        res = "Preencha os campos corretamente";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }
}
