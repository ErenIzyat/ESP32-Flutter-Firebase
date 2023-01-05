import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import  'AnaMenu.dart';
import 'main.dart';
import 'dart:async';








class Calisan extends StatefulWidget {
  @override
  _CalisanState createState() => _CalisanState();
}

class _CalisanState extends State<Calisan> {
  Map<String, dynamic> sensorData = {};
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
    const int incrementAmount = 1;
    const int dangerThreshold = 300;
    int count = 0;
    bool isInDanger = false;

    if (sensorData['sicaklik'] > 40 ||
        sensorData['nem'] > 70 ||
        sensorData['gaz'] > 2500 ||
        sensorData['titresim'] == true) {
        isInDanger = true;
    }

    while (isInDanger) {

      count += incrementAmount;
      if (count == dangerThreshold) {
        return true;
      }
    }
    return false;
  }



  Widget build(BuildContext context) {
    return Container(
      color: IsInDanger() ? Colors.red : Colors.white,

      // Calisan widgetinin tasarımı burada olacak
    );
  }
}

