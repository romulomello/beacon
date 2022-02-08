import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Adicionar imagem ao storage
  Future<String> uploadImageToStorage(
      String childName, Uint8List file, bool isPost) async {
    print("CHEGOU AQUI");
    if (file == null) {
      String url =
          'https://t4.ftcdn.net/jpg/02/15/84/43/360_F_215844325_ttX9YiIIyeaR7Ne6EaLLjMAmy4GvPC69.jpg';
      return url;
    } else {
      Reference ref =
          _storage.ref().child(childName).child(_auth.currentUser!.uid);

      UploadTask uploadTask = ref.putData(file);

      TaskSnapshot snap = await uploadTask;
      String downloadUrl = await snap.ref.getDownloadURL();
      return downloadUrl;
    }
  }
}
