

import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  final String name;
  final int price;
  final String description;
  final String photoURL;
  final DocumentReference reference;
  final String modified_time;
  final bool Is_modified;
  final String create_time;
  final String UID;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : name = map['name'],
        price = map['price'],
        description = map['description'],
        photoURL = map['photoURL'],
        modified_time = map['modified_time'],
        Is_modified = map['Is_modified'],
        create_time = map['create_time'],
        UID = map['UID'];

  Record.fromSnapshot (DocumentSnapshot snapshot)
      :this.fromMap(snapshot.data, reference: snapshot.reference);
}

class Product {
  final String name="";
  final int price=0;
  final String description="";
  final String photoURL="";
  final String modified_time="";
  final bool Is_modified=false;
  final String create_time="";
  final String UID="";

}