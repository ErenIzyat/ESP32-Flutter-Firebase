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
        backgroundColor: Colors.deepPurple[700],
        title: Text('Giriş'),
      ),
      body: Container(

        color: Colors.purple[100],
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 50),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
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
              SizedBox(height: 20),
              TextFormField(
                decoration:  InputDecoration(
                  border: OutlineInputBorder(
                    //<-- SEE HERE
                    borderRadius: BorderRadius.circular(50.0),
                  ),
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
                  if (_formKey?.currentState?.validate() == true) {

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

