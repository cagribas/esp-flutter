import 'package:esptouch_example/esptouch_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'app_screen.dart';

class OnOff extends StatefulWidget {
  ESPTouchResult cihaz;


  OnOff(this.cihaz);

  @override
  _OnOffState createState() => _OnOffState();
}

class _OnOffState extends State<OnOff> {
  var value = false;

  var kutular  = Hive.box('devices');



  final dbRef = FirebaseDatabase.instance.reference();
  onOffSwitch() {


      dbRef.child('cihazlar').child(widget.cihaz.bssid).set({'cihaz_durum': value?"1":"0"});
      setState(() {
        value = !value;
      });

  }
  // dataPull() {
  //   for(int i= 0 ;i<kutular.length; i++){
  //     sonuclar.add ( kutular.getAt(i) as ESPTouchResult);
  //   }
  //   Future.forEach(sonuclar, (sonuc) => )
  //
 // dbRef.child(widget.cihaz.bssid).set({"switch": !value});
  // }
  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Itesatec'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(18),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton.extended(
                  onPressed: () {

                    setState(() {
                      onOffSwitch();

                    });
                  },
                  label: value ? Text('ON') : Text('OFF'),
                  elevation: 20,
                  backgroundColor:
                      value ? Colors.orangeAccent : Colors.redAccent,
                  icon: value
                      ? Icon(Icons.power_settings_new)
                      : Icon(Icons.close),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
