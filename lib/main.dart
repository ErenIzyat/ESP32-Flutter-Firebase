import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import  'AnaMenu.dart';


class MyApp extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}



class _MyWidgetState extends State<MyApp> {
  Map<String, dynamic> sensorData = {};
  @override

  void initState() {
    super.initState();

    final databaseReference = FirebaseDatabase.instance.ref('sensor');
    databaseReference.onValue.listen((DatabaseEvent event) {
      setState(() {
        sensorData = Map<String, dynamic>.from(event.snapshot.value as Map);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sensor Data')),
      body: Container(
    color: Colors.lightBlue,
    child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(
    'Temperature:',
    style: TextStyle(color: Colors.white, fontSize: 20),
    ),
    Text(
    '${sensorData['sicaklik']}',
    style: TextStyle(color: Colors.white, fontSize: 16),
    ),
    SizedBox(height: 16),
    Text(
    'Humidity:',
    style: TextStyle(color: Colors.white, fontSize: 20),
    ),
    Text(
    '${sensorData['nem']}',
    style: TextStyle(color: Colors.white, fontSize: 16),
    ),
    SizedBox(height: 16),
    Text(
    'Vibration:',
    style: TextStyle(color: Colors.white, fontSize: 20),
    ),
    Text(
    '${sensorData['titresim']}',
    style: TextStyle(color: Colors.white, fontSize: 16),
    ),
    SizedBox(height: 16),
    Text(
    'Gas:',
    style: TextStyle(color: Colors.white, fontSize: 20),
    ),
    Text(
    '${sensorData['gaz']}',
    style: TextStyle(color: Colors.white, fontSize: 16),
    ),
    ],
    ),
    ),
    ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Burada navigator.pushReplacement ile AnaMenu widget'ına geçiş yapılır.
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => AnaMenu(),
            ),
          );
        },
        child: Icon(Icons.home),
      ),
    );
  }

}
