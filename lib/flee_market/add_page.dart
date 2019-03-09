import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'service/manage_item.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

manage_items Addfunc = new manage_items();


FirebaseStorage _storage = FirebaseStorage.instance;


class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

  String name;
  String description;
  int price;
  String photoURL;
  String UID;
  String create_time;

  TextEditingController ProductName = new TextEditingController();
  TextEditingController Price = new TextEditingController();
  TextEditingController Description = new TextEditingController();

  File _image;
  String default_photo = "https://firebasestorage.googleapis.com/v0/b/final-89ca4.appspot.com/o/default.png?alt=media&token=790f7e34-87be-4f15-8155-87a244ed2f0f";

  Future<String> getUID() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    UID = user.uid.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios, color: Colors.black,),
        ),

        title: Text('Sell', style: TextStyle(color: Color(0xff000000))),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                Map<String, dynamic> Product = {
                  'name' : this.name,
                  'price' : this.price,
                  'description' : this.description,
                  'UID' : UID,
                  'modified_time' : "",
                  'Is_modified' : false,
                  'create_time' : create_time = new DateTime.now().toString(),
                  'photoURL' : photoURL,
                };
                Addfunc.addData(Product, create_time);
                Navigator.pop(context);
              },
              child: Text("Save", style: TextStyle(color: Color(0xff000000)),))
        ],
      ),

      body: Column(
        children: <Widget>[
          Image.network("$default_photo",
            width: 414.0,
            height: 300.0,
            fit: BoxFit.cover,
          ),
          
          IconButton(icon: Icon(Icons.camera_alt)
              , onPressed: () {
                Future getImage() async {
                  var image = await ImagePicker.pickImage(
                      source: ImageSource.gallery);

                  setState(() {
                    _image = image;
                  });

                  StorageReference reference = _storage.ref().child("$name");
                  //Upload the file to firebase
                  StorageUploadTask uploadTask = reference.putFile(_image);
                  //photoURL = await reference.getDownloadURL();
                  photoURL = await (await uploadTask.onComplete).ref
                      .getDownloadURL();

                  setState(() {
                    default_photo = photoURL;
                    UID = getUID().toString();
                  });
                }
                getImage();
              }),

          TextField(
            controller: ProductName,
            decoration: InputDecoration(
              filled: true,
              hintText: 'Product Name',
            ),
            onChanged: (value) {
              this.name = value;
            },
          ),
          SizedBox(height: 12.0),

          TextField(
            controller: Price,
            decoration: InputDecoration(
              filled: true,
              hintText: "price"
            ),
            onChanged: (value) {
              this.price = int.parse(value);
            },
          ),

          SizedBox(height: 12.0),

          TextField(
            controller: Description,
            decoration: InputDecoration(
              filled: true,
              hintText: 'Description',
            ),
            onChanged: (value) {
              this.description = value;
            },
          ),
        ],
      ),
    );
  }

}



