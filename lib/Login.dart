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
  Map<String, String> calisansoyisim = {};
  Map<String, String> calisanisim = {};
  @override
  String _isim = " ";
  String _soyisim = " ";

  void initState()  {
    super.initState();
    getName();

  }
  Future<void> getName() async {
    final dbRef = FirebaseDatabase.instance.ref('calisanlar');
    final snapshot = await dbRef.get();
    if(snapshot.value == null ){
      print("null");
    }
    else{
      setState(() {
        calisanlar = Map<String, dynamic>.from(snapshot.value as Map);
        print(calisanlar.entries);
        var entryString = calisanlar.toString();
        calisanlar.forEach((key, value) {
          String isim = "";
          String soyisim = "";
          if(value.containsKey("isim")){
            isim = value["isim"];
          }
          if(value.containsKey("soyisim")){
            isim = value["soyisim"];
          }
          calisansoyisim[isim] = soyisim;
        });
        calisanlar.forEach((key, value) {
          String isim = "";
          String soyisim = "";
          if(value.containsKey("soyisim")){
            isim = value["soyisim"];
          }
          if(value.containsKey("isim")){
            isim = value["isim"];
          }
          calisanisim[isim] = soyisim;
        });
      });
    }
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
                    return 'Lütfen isim girin';
                  }
                  return null;
                },
                onChanged: (value) {
                  _isim = value;
                },
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
                onChanged: (value) {
                  _soyisim = value;
                },
              ),
              FloatingActionButton(
                onPressed: () {
                  calisanisim.forEach((key, value) {
                    if(key.toLowerCase() == _isim.toLowerCase()) {
                      if (_formKey?.currentState?.validate() == true && calisansoyisim.containsKey(_soyisim)) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AnaMenu(),
                          ),
                        );
                      }
                    }
                  });
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

