import 'package:esptouch_example/esptouch_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddDevices extends StatefulWidget {
  @override
  _AddDevicesState createState() => _AddDevicesState();
}

class _AddDevicesState extends State<AddDevices> {
  final _formKey = GlobalKey<FormState>();
  var kutular = Hive.box('devices');
  showAlertDialog(BuildContext context,var box, int index) {

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("İptal"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget deleteButton = FlatButton(
      child: Text("Sil",style: TextStyle(color: Colors.red[700]),),
      onPressed:  () {
        box.deleteAt(index);
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Uyarı!"),
      content: Text("Cihazınızı silmek istediğinizden emin misiniz? (Silindikten sonra cihazı fabrika ayarlarına geri yüklemeniz gerekir.)",style: TextStyle(
        fontFamily: 'Roboto'
      ),),
      actions: [
        cancelButton,
        deleteButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // print("$_results S");
    //widget.results == null ? widget.results = [] : widget.results;

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 60.0,
        ),
        color:Colors.red[300],

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          // Navigator.pushNamed(context, '/app_screen');

          Navigator.pushNamed(context, '/app_screen');
        },
        child: Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.red[300],
        title: Text('Cihazlarım'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            width: double.infinity,
            height: double.infinity,
            child: ValueListenableBuilder(
                valueListenable: kutular.listenable(),
                builder: (context, box, widget) {
                  return ListView.builder(
                    itemCount: box.length,
                    itemBuilder: (context, index) {
                      final cihaz = box.getAt(index) as ESPTouchResult;
                      return Card(
                        color: Colors.red[300],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 5,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: TextField(
                                    textAlign: TextAlign.center,

                                    style: TextStyle(

                                      color: Colors.white,
                                      fontFamily: 'Roboto',
                                    ),


                                    cursorColor: Colors.white,


                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Cihaz İsmi Gir/Değiştir',
                                        hintStyle: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Roboto')),
                                    onChanged: (val) {
                                      box.putAt(
                                          index,
                                          ESPTouchResult(
                                              ip: cihaz.ip,
                                              bssid: cihaz.bssid,
                                              isim: val,
                                              status: false));
                                    },
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: IconButton(icon: Icon(Icons.delete,color: Colors.white,), onPressed: (){
                                    //box.deleteAt(index);
                                    showAlertDialog(context,box,index);
                                  }),
                                )


                              ],
                            ),

                            Divider(
                              thickness: 1,
                            ),
                            GestureDetector(
                              child: Column(
                                children: [
                                  cihaz.isim != null
                                      ? Text(
                                          cihaz.isim,
                                          style: TextStyle(
                                            fontSize: 18,
                                              color: Colors.white,
                                              fontFamily: 'Roboto'),
                                        )
                                      : Text(''),
                                  Text('IP: ',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Roboto')),
                                  Text(cihaz.ip,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Roboto')),
                                  Text(
                                    'BSSID: ',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    cihaz.bssid,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Roboto'),
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.pushNamed(context, '/on_off',
                                    arguments: cihaz);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                })),
      ),
    );
  }
}

