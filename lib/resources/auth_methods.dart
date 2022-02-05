//import 'dart:typed_data';

import 'dart:typed_data';

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
        //print(cred.user.displayName);

        await _firestore.collection('users').doc(cred.user!.uid).set({
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'followers': [],
          'following': [],
        });
        res = "Registrado com Sucesso";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
