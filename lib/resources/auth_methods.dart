//import 'dart:typed_data';

import 'dart:typed_data';

import 'package:beacon/resources/storage_methods.dart';
import 'package:beacon/screens/signup_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //registro
  Future<String> SignUpUser({
    required String username,
    required String email,
    required String password,
    required Uint8List file,
  }) async {
    String res = "ERROR";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          file != null) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);
        //print(cred.user.displayName);

        await _firestore.collection('users').doc(cred.user!.uid).set({
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'followers': [],
          'following': [],
          'photoUrl': photoUrl,
        });
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
