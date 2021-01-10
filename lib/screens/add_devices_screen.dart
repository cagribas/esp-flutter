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
  /*bool _isEditingText = false;
  TextEditingController _editingController;
  String initialText = "Cihaz ismi giriniz";
  Widget _editTitleTextField(ESPTouchResult esp, int i) {
    if (_isEditingText)
      return TextField(
        onSubmitted: (newValue) {
          setState(() {
            initialText = newValue;

            _isEditingText = false;
          });
          kutular.putAt(
              i,
              ESPTouchResult(
                  ip: esp.ip,
                  bssid: esp.bssid,
                  isim: initialText,
                  status: false));
        },
        autofocus: true,
        controller: _editingController,
      );
    return InkWell(
      onTap: () {
        setState(() {
          _isEditingText = true;
        });
      },
      child: Text(
        initialText,
      ),
    );
  }

  @override
  initState() {
    super.initState();
    _editingController = TextEditingController(text: initialText);
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    // print("$_results S");
    //widget.results == null ? widget.results = [] : widget.results;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                            TextField(
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
/* itemBuilder: (context, index) {
              return Card(
                color: Colors.teal,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                elevation: 5,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        child: Column(
                          children: [
                            Text('IP: ',
                                style: Theme.of(context).textTheme.bodyText1),
                            Text(_results[index].ip,
                                style: TextStyle(fontFamily: 'monospace')),
                            Text(
                              'BSSID: ',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Text(_results[index].bssid),
                          ],
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/on_off',
                              arguments: _results[index]);
                          setState(() {});
                        },
                        onLongPress: () {},
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: _results.length, */

/* ListView.builder(
            itemCount: cihazlarBox.length,
            itemBuilder: (context, index) {
              final cihaz = cihazlarBox.getAt(index) as ESPTouchResult;
              return Card(
                color: Colors.teal,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                elevation: 5,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        child: Column(
                          children: [
                            Text('IP: ',
                                style: Theme.of(context).textTheme.bodyText1),
                            Text(cihaz.ip,
                                style: TextStyle(fontFamily: 'monospace')),
                            Text(
                              'BSSID: ',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Text(cihaz.bssid),
                          ],
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/on_off',
                              arguments: cihaz);
                          setState(() {});
                        },
                        onLongPress: () {},
                      ),
                    ],
                  ),
                ),
              );
            },
          ), */
