import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'data_structure.dart';
import 'service/manage_item.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseStorage _storage = FirebaseStorage.instance;
manage_items Addfunc = new manage_items();

TextEditingController product_field = new TextEditingController();
TextEditingController price_field = new TextEditingController();
TextEditingController description_field = new TextEditingController();

class EditPage extends StatefulWidget {

  final Record record;
  EditPage({Key key, this.record}) : super(key :key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {

  String new_photoURL;
  File _image;

  String name;
  int price;
  String description;
  String photoURL;

  @override
  void initState() {
    new_photoURL = widget.record.photoURL;
    product_field.clear();
    price_field.clear();
    description_field.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Flee Market', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        leading: FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel", style: new TextStyle(fontSize: 7.0))),



        actions: <Widget>[
          FlatButton(
              onPressed: () {
                Map<String, dynamic> Product = {
                  'name' : this.name,
                  'price' : this.price,
                  'description' : this.description,
                  'modified_time' : new DateTime.now().toString(),
                  'photoURL' : this.photoURL,
                  'Is_modified' : true,
                  'create_time': widget.record.create_time,
                  'UID' : widget.record.UID
                };
                Addfunc.updateData(widget.record.create_time, Product);
                Navigator.pop(context);
                setState((
                    ) {});
              },
              child: Text("Save"))
        ],
      ),

      body: Column(
        children: <Widget>[
          Image.network(new_photoURL,
            width: 414.0,
            height: 300.0,
            fit: BoxFit.cover,
          ),

          IconButton(icon: Icon(Icons.camera_alt)
              , onPressed: () {
                Future modifyImage() async {
                  var image = await ImagePicker.pickImage(
                      source: ImageSource.gallery);

                  setState(() {
                    _image = image;
                  });

                  StorageReference reference = _storage.ref().child(widget.record.create_time);
                  //Upload the file to firebase
                  StorageUploadTask uploadTask = reference.putFile(_image);
                  //photoURL = await reference.getDownloadURL();
                  photoURL = await (await uploadTask.onComplete).ref
                      .getDownloadURL();

                  setState(() {
                    new_photoURL = photoURL;
                  });

                }
                modifyImage();
              }),

          TextField(
            controller: product_field,
            decoration: InputDecoration(
              filled: true,
              hintText: widget.record.name,
            ),
            onChanged: (String value) {
              setState(() {
                name = value;
              });
            },
          ),
          SizedBox(height: 12.0),
          TextField(
            controller: price_field,
            decoration: InputDecoration(
              filled: true,
              hintText: widget.record.price.toString(),
            ),
              onChanged: (String value) {
                setState(() {
                  price = int.parse(value);
                });
              }
          ),

          SizedBox(height: 12.0),

          TextField(
            controller: description_field,
            decoration: InputDecoration(
              filled: true,
              hintText: widget.record.description,
            ),
              onChanged: (String value) {
                setState(() {
                  description = value;
                });
              }
          ),
        ],
      ),
    );
  }

}

