import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:deneme/pages/globals/globals.dart' as globals;

class Qr extends StatefulWidget {
  const Qr({Key? key}) : super(key: key);

  @override
  _QrState createState() => _QrState();
}

FirebaseAuth _auth = FirebaseAuth.instance;
TextEditingController t1 = TextEditingController();
String qrCode = t1.text;

class _QrState extends State<Qr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(title: Text("Qr Kod"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           newMethod(),
           SizedBox(height: 60,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextFormField(
                controller: t1,
                decoration: InputDecoration(
                  labelText: "Okul Numarası",
                  prefixIcon: Icon(Icons.person),
                ),
              ),
            ),
            SizedBox(height: 50,),
            RaisedButton(
              color: Colors.blue,
              onPressed: () {
                makeQr();
              },
              child: Text(
                "Kod Oluştur",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            ),
            SizedBox(height: 100,)
          ],
        ),
      ),
    );
  }

  QrImage newMethod() {
    return QrImage(
            data: globals.qrCode,
            version: QrVersions.auto,
            size: 200.0,
          );
  }

  makeQr() {
  
      setState(() {
        globals.qrCode = t1.text;
      });
      print(t1.text);
      print(qrCode);
   
  }
}
