import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import  'AnaMenu.dart';
import 'main.dart';
import 'dart:async';




/*class Calisanlar {
  final String isim;
  final String soyisim;
  final String numara;
  final String konum;

  Calisanlar({
    required this.isim,
    required this.soyisim,
    required this.numara,
    required this.konum,
  });
}*/



class Calisan extends StatefulWidget {
  @override
  _CalisanState createState() => _CalisanState();
}

class _CalisanState extends State<Calisan> {
  Map<String, dynamic> sensorData = {};
  final _formKey = GlobalKey<FormState>();
  final databaseReference = FirebaseDatabase.instance.ref().child("calisanlar");
  String _isim = " ";
  String _soyisim = " ";
  String _numara = " ";
  String _konum = " ";

  @override


  void initState() {
    super.initState();

    final databaseReference = FirebaseDatabase.instance.ref('sensor');
    databaseReference.onValue.listen((DatabaseEvent event) {
      setState(() {
        sensorData = Map<String, dynamic>.from(event.snapshot.value as Map);
        print(sensorData['gaz']);
      });
    });
  }

  bool IsInDanger() {

    int count = 0;
    bool isInDanger = false;

    if (sensorData['sicaklik'] > 40 ||
        sensorData['nem'] > 70 ||
        sensorData['gaz'] > 2500 ||
        sensorData['titresim'] == true) {

        return true;
    }


    return false;
  }



  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Calisan Ekle'),
      ),
    body: Container(
      color: IsInDanger() ? Colors.red : Colors.white,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'İsim'),
              validator: (value) {
                if ((value as String).isEmpty) {
                  return 'Lütfen isim girin';
                }
                return null;
              },
              onSaved: (value) => _isim = value as String,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Soyisim'),
              validator: (value) {
                if ((value as String).isEmpty) {
                  return 'Lütfen soyisim girin';
                }
                return null;
              },
              onSaved: (value) => _soyisim = value as String,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Numara'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if ((value as String).isEmpty) {
                  return 'Lütfen numara girin';
                }
                return null;
              },
              onSaved: (value) => _numara = value as String,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Konum'),
              validator: (value) {
                if ((value as String).isEmpty) {
                  return 'Lütfen konum girin';
                }
                return null;
              },
              onSaved: (value) => _konum = value as String,
            ),
            FloatingActionButton(
              onPressed: () {
                if (_formKey?.currentState?.validate() == true) {
                  _formKey?.currentState?.save();

                  databaseReference.push().set({
                    'isim': _isim,
                    'soyisim': _soyisim,
                    'numara': _numara,
                    'konum': _konum
                  });
                }
              },
              child: Icon(Icons.send),
            ),
          ],
        ),
      ),
    )
    );
  }
}

