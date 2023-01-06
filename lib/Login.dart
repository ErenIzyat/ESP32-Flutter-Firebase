import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'AnaMenu.dart';
import 'main.dart';
import 'dart:async';


class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: LoginWidget()));
}

class _LoginWidgetState extends State<LoginWidget> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> calisanlar = {};
  @override
  String deneme = "";
  String _isim = " ";
  String _soyisim = " ";

  void initState()  {
    super.initState();
    getName();

  }
  Future<void> getName() async {
    final dbRef = FirebaseDatabase.instance.ref('calisanlar');
    final snapshot = await dbRef.child('calisanlar').get();
    setState(() {
      calisanlar = Map<String, dynamic>.from(snapshot.value as Map<String, dynamic>);
    });
  }



    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giriş'),
      ),
      body: Container(
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'İsim',
                ),
                validator: (value) {
                  if ((value as String).isEmpty) {
                    return 'Lütfen email girin';
                  }
                  return null;
                },
                onSaved: (value) => _isim = value as String,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'soyisim',
                ),
                validator: (value) {
                  if ((value as String).isEmpty) {
                    return 'Lütfen soyisim girin';
                  }
                  return null;
                },
                onSaved: (value) => _soyisim = value as String,
              ),
              FloatingActionButton(
                onPressed: () {
                  if (_formKey?.currentState?.validate() == true && _isim == calisanlar['isim']
                      && _soyisim == calisanlar['soyisim']) {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AnaMenu(),
                      ),
                    );
                  }
                },
                child: Icon(Icons.send),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

