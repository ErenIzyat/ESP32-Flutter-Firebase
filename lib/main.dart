import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'AnaMenu.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Sensor Data')),
        body: Container(
          color: IsInDanger() ? Colors.red : Colors.lightBlue,
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
        floatingActionButton: Stack(
          children: [
            IsInDanger()
                ? Container(
              width: MediaQuery.of(context).size.width / 2,
              alignment: Alignment.centerRight,
            )
                : Container(),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Acil Durum!'),
                      content: Text('Lütfen acil yardım çağırın.'),
                      actions: [
                        FloatingActionButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Icon(Icons.close),
                        ),
                      ],
                    );
                  },
                ),
                child: Icon(Icons.warning),
              ),
            ),
          ],
        ));
  }
}
