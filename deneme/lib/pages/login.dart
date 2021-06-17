import 'package:deneme/pages/qr.dart';
import 'package:deneme/pages/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import 'package:rflutter_alert/rflutter_alert.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
    var formKey = GlobalKey<FormState>();
FirebaseAuth _auth = FirebaseAuth.instance;
 

  int sayac = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Giriş"),),
      body: Container(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: t1,
                  decoration: InputDecoration(
                    labelText: "Email",
                    prefixIcon: Icon(Icons.mail),
                  ),
                ),
                TextFormField(
                  controller: t2,
                  decoration: InputDecoration(
                    labelText: "Şifre",
                    prefixIcon: Icon(Icons.vpn_key),
                  ),
                  obscureText: true,
                ),
                SizedBox(
                  height: 50,
                ),
                RaisedButton.icon(
                  color: Colors.blue,
                  onPressed: () {_emailSifreGiris();},
                  icon: Icon(
                    Icons.login,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Giriş",
                    style: TextStyle(color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                ),
                RaisedButton.icon(
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Register()),
                    );
                  },
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Kaydol",
                    style: TextStyle(color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

   void _emailSifreGiris() async {
   
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      await _auth
          .signInWithEmailAndPassword(email: t1.text, password: t2.text)
          .then((user) {
      
           Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Qr()),
                    );
         
        
      }).catchError((onError) {
        Alert(
            type: AlertType.warning,
            context: context,
            title: "GİRİŞ YAPILAMADI!",
            desc: "Hatalı Email Adresi / Şifre",
            buttons: [
              DialogButton(
                child: Text(
                  "KAPAT",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                onPressed: () => Navigator.pop(context),
              )
            ]).show();
     
      });
    } 
  }
}
