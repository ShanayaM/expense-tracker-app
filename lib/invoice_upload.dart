import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final confirmButton = Material(
    child: MaterialButton(
      onPressed: () {},
    ),
  );
  final cancelButton = Material(
    child: MaterialButton(
      onPressed: () {},
    ),
  );

  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child:
            _image == null ? Text('No image selected.') : Image.file(_image!),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getImage();
          // Fluttertoast.showToast(
          //     msg: "Selecting an image...",
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.CENTER,
          //     timeInSecForIosWeb: 1,
          //     backgroundColor: Colors.grey,
          //     textColor: Colors.white,
          //     fontSize: 16.0);
        },
        tooltip: 'Upload an expense',
        child: Icon(Icons.add),
      ),
    );
  }
}
