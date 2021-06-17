import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:firebase_core/firebase_core.dart';
class Register extends StatefulWidget {
  const Register({ Key? key }) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

TextEditingController t1 = TextEditingController();
TextEditingController t2 = TextEditingController();
class _RegisterState extends State<Register> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() { 
      print("completed");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  validator: (x) {
                        if (x == null) {
                          return "Doldurulması Zorunludur!";
                        } else {
                          if (EmailValidator.validate(x) != true) {
                            return "Geçerli Bir Email Adresi Giriniz!";
                          } else {
                            return null;
                          }
                        }
                      },
                ),
                TextFormField(
                  controller: t2,
                  decoration: InputDecoration(
                    labelText: "Şifre",
                    prefixIcon: Icon(Icons.vpn_key),
                  ),
                  obscureText: true,
                    validator: (x) {
                        if (x == null) {
                          return "Doldurulması Zorunludur!";
                        } 
                      },
                ),
                SizedBox(
                  height: 50,
                ),
                RaisedButton.icon(
                  color: Colors.blue,
                  onPressed: () {
                    _emailSifreEkle();
                  },
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
                
         
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _emailSifreEkle() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      var _firebaseUser = await _auth
          .createUserWithEmailAndPassword(email: t1.text, password: t2.text)
          .catchError((onError) => null);
      if (_firebaseUser != null) {
        Alert(
            type: AlertType.success,
            context: context,
            title: "KAYIT EKLENDİ!",
            desc: "Lütfen Email Adresinize Gelen Mesajı Onaylıyınız!",
            buttons: [
              DialogButton(
                child: Text(
                  "KAPAT",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                onPressed: () => Navigator.pop(context),
              )
            ]).show();
       

        _firebaseUser.user!
            .sendEmailVerification()
            .then((value) => null)
            .catchError((onError) => null);
      } else {
        Alert(
            type: AlertType.warning,
            context: context,
            title: "KAYIT EKLENEMEDİ!",
            desc:
                "Sisteme Kayıtlı Bir Email Adresi Girdiniz. \n Lütfen Farklı Bir Email Adresi Giriniz!",
            buttons: [
              DialogButton(
                child: Text(
                  "KAPAT",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                onPressed: () => Navigator.pop(context),
              )
            ]).show();
      }
    }
  }
}