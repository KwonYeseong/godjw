import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

String name;
File _image;
FirebaseStorage _storage = FirebaseStorage.instance;


class manage_items {

  Future<void> addData(Map <String, dynamic> Product, name) async {
    Firestore.instance.document('item/$name').setData(Product);

  }

  Future<void> delData (name) async {
    Firestore.instance.document("item/$name").delete();
  }

  updateData(selectedDoc, newValues) {
    Firestore.instance.collection('item').document(selectedDoc).updateData(newValues);
  }

}


