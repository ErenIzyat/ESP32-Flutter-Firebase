import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'main.dart';
import 'Calisan.dart';

class AnaMenu extends StatefulWidget {
  @override
  _AnaMenuState createState() => _AnaMenuState();
}




class _AnaMenuState extends State<AnaMenu> {
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

    if (sensorData['sicaklik'] > 20 ||
        sensorData['nem'] > 70 ||
        sensorData['gaz'] > 2500 ||
        sensorData['titresim'] == true) {
      return true;
    }

    return false;
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  backgroundColor: Colors.lightBlue,
                  child: Icon(Icons.account_circle_outlined),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Calisan()),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  backgroundColor: Colors.lightBlue,
                  child: Icon(Icons.error_outline_outlined),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: IsInDanger()
          ? FloatingActionButton(
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
      )
          : Container(),
    );
  }

}
