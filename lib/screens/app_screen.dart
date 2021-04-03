import 'dart:async';
import 'dart:math';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../esptouch_flutter.dart';
import '../wifi_info.dart';

class AppScreen extends StatefulWidget {
  @override
  _AppScreenState createState() => _AppScreenState();
}

const helperSSID =
    "SSID Wi-Fi'nizin görünen ismidir.";
const helperBSSID =
    "BSSID router'ınızın MAC adresidir";
const helperPassword = "Wi-Fi Ağı Şifresi";

class _AppScreenState extends State<AppScreen> {
  final _auth = FirebaseAuth.instance;

  User loggedInUser;
  @override
  void initState() {
    super.initState();

    /*Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final theUser = _auth.currentUser;
      if (theUser != null) {
        loggedInUser = theUser;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }*/
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _ssid = TextEditingController();
  final TextEditingController _bssid = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _expectedTaskResults =
      TextEditingController(); // TODO; is it the same as threshold?
  final TextEditingController _intervalGuideCode = TextEditingController();
  final TextEditingController _intervalDataCode = TextEditingController();
  final TextEditingController _timeoutGuideCode = TextEditingController();
  final TextEditingController _timeoutDataCode = TextEditingController();
  final TextEditingController _repeat = TextEditingController();

  // final TextEditingController _oneLength = TextEditingController();
  // final TextEditingController _macLength = TextEditingController();
  // final TextEditingController _ipLength = TextEditingController();
  final TextEditingController _portListening = TextEditingController();
  final TextEditingController _portTarget = TextEditingController();
  final TextEditingController _waitUdpReceiving = TextEditingController();
  final TextEditingController _waitUdpSending = TextEditingController();
  final TextEditingController _thresholdSucBroadcastCount =
      TextEditingController();
  ESPTouchPacket _packet = ESPTouchPacket.broadcast;

  @override
  void dispose() {
    _ssid.dispose();
    _bssid.dispose();
    _password.dispose();
    _expectedTaskResults.dispose();
    _intervalGuideCode.dispose();
    _intervalDataCode.dispose();
    _timeoutGuideCode.dispose();
    _timeoutDataCode.dispose();
    _repeat.dispose();
    _portListening.dispose();
    _portTarget.dispose();
    _waitUdpReceiving.dispose();
    _waitUdpSending.dispose();
    _thresholdSucBroadcastCount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[300],
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              //_auth.signOut();
              Navigator.pop(context);
            },
          ),
        ],
        title: Text(
          'Smart Config',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      // Using builder to get context without creating new widgets
      //  https://docs.flutter.io/flutter/material/Scaffold/of.html
      body: Builder(builder: (BuildContext context) {
        return Center(
          child: form(context),
        );
      }),
    );
  }

  bool fetchingWifiInfo = false;

  void fetchWifiInfo() async {
    setState(() {
      fetchingWifiInfo = true;
    });
    try {
      _ssid.text = await ssid;
      _bssid.text = await bssid;
    } finally {
      setState(() {
        fetchingWifiInfo = false;
      });
    }
  }

  createTask() {
    final taskParameter = ESPTouchTaskParameter();
    if (_intervalGuideCode.text.isNotEmpty) {
      taskParameter.intervalGuideCode =
          Duration(milliseconds: int.parse(_intervalGuideCode.text));
    }
    if (_intervalDataCode.text.isNotEmpty) {
      taskParameter.intervalDataCode =
          Duration(milliseconds: int.parse(_intervalDataCode.text));
    }
    if (_timeoutGuideCode.text.isNotEmpty) {
      taskParameter.timeoutGuideCode =
          Duration(milliseconds: int.parse(_timeoutGuideCode.text));
    }
    if (_timeoutDataCode.text.isNotEmpty) {
      taskParameter.timeoutDataCode =
          Duration(milliseconds: int.parse(_timeoutDataCode.text));
    }
    if (_repeat.text.isNotEmpty) {
      taskParameter.repeat = int.parse(_repeat.text);
    }
    if (_portListening.text.isNotEmpty) {
      taskParameter.portListening = int.parse(_portListening.text);
    }
    if (_portTarget.text.isNotEmpty) {
      taskParameter.portTarget = int.parse(_portTarget.text);
    }
    if (_waitUdpSending.text.isNotEmpty) {
      taskParameter.waitUdpSending =
          Duration(milliseconds: int.parse(_waitUdpSending.text));
    }
    if (_waitUdpReceiving.text.isNotEmpty) {
      taskParameter.waitUdpReceiving =
          Duration(milliseconds: int.parse(_waitUdpReceiving.text));
    }
    if (_thresholdSucBroadcastCount.text.isNotEmpty) {
      taskParameter.thresholdSucBroadcastCount =
          int.parse(_thresholdSucBroadcastCount.text);
    }
    if (_expectedTaskResults.text.isNotEmpty) {
      taskParameter.expectedTaskResults = int.parse(_expectedTaskResults.text);
    }

    return ESPTouchTask(
      ssid: _ssid.text,
      bssid: _bssid.text,
      password: _password.text,
      packet: _packet,
      taskParameter: taskParameter,
    );
  }

  Widget form(BuildContext context) {

    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: <Widget>[
          SizedBox(height: 10,),
          Center(

            child: RaisedButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              elevation: 15,

              color: Colors.red[300],



              onPressed: fetchingWifiInfo ? null : fetchWifiInfo,
              child: fetchingWifiInfo
                  ? Text(
                      'Wi-Fi Bilgisi Alınıyor',
                      style: TextStyle(color: Colors.white),
                    )
                  : Text(
                      'Wi-Fi Bilgisi Al',
                      style: TextStyle(color: Colors.white,fontSize: 15),
                    ),
            ),
          ),
          TextFormField(
            controller: _ssid,
            decoration: const InputDecoration(
              labelText: 'SSID',
              hintText: 'Wi-Fi ismi(Otomatik)',
              helperText: 'Wi-Fi ağınızın ismi otomatik gelecektir.'

            ),
          ),
          TextFormField(
            controller: _bssid,
            decoration: const InputDecoration(
              labelText: 'BSSID',
              hintText: '00:a0:c9:14:c8:29(Otomatik)',
              helperText: 'BSSID Router\'ınızın MAC adresidir. Otomatik olarak gelecektir.'

            ),
          ),
          TextFormField(
            controller: _password,
            decoration: const InputDecoration(
              labelText: 'Password',
              hintText: 'Wi-Fi şifrenizi giriniz.',
              helperText: 'Lütfen ağınızın şifresini giriniz.'

            ),
            
          ),

          SizedBox(height: 15,),
          // RadioListTile(
          //   title: Text('Broadcast'),
          //   value: ESPTouchPacket.broadcast,
          //   groupValue: _packet,
          //   onChanged: setPacket,
          //   activeColor: color,
          // ),
          // RadioListTile(
          //   title: Text('Multicast'),
          //   value: ESPTouchPacket.multicast,
          //   groupValue: _packet,
          //   onChanged: setPacket,
          //   activeColor: color,
          // ),

          Center(

            child: RaisedButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              elevation: 10,
              color: Colors.amber,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskRoute(task: createTask()),
                  ),
                );
              },
              child: const Text('Başlat',style: TextStyle(fontFamily:'Roboto',color: Colors.white,fontSize: 15),),
            ),
          ),
        ],
      ),
    );
  }

  void setPacket(ESPTouchPacket packet) {
    setState(() {
      _packet = packet;
    });
  }
}

class TaskRoute extends StatefulWidget {
  final ESPTouchTask task;

  TaskRoute({this.task});

  @override
  State<StatefulWidget> createState() {
    return TaskRouteState();
  }
}

class TaskRouteState extends State<TaskRoute> {
  Stream<ESPTouchResult> _stream;
  StreamSubscription<ESPTouchResult> _streamSubscription;
  Timer _timer;

  List<ESPTouchResult> _results = [];
  addEsp(ESPTouchResult espTouchResult) async {
    final cihazlarBox = Hive.box('devices');
    await cihazlarBox.add(espTouchResult);

    setState(() {});
  }

  addCihaz() async {
    await Future.forEach(_results, (result) => addEsp(result));
    pageLoaded = true;
  }

  bool value = false;
  bool pageLoaded = false;

  var result;

  bool isFound = false;

  @override
  void initState() {
    _stream = widget.task.execute();
    _streamSubscription = _stream.listen(_results.add);

    final receiving = widget.task.taskParameter.waitUdpReceiving;
    final sending = widget.task.taskParameter.waitUdpSending;
    final cancelLatestAfter = receiving + sending;
    _timer = Timer(cancelLatestAfter, () {
      _streamSubscription?.cancel();
      addCihaz();

      if (_results.isEmpty && mounted) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Cihaz Bulunamadı'),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context)..pop()..pop();
                    },
                    child: Text('Tamam'),
                  ),
                ],
              );
            });
      }
    });
    super.initState();
  }

  @override
  dispose() {
    _timer.cancel();
    _streamSubscription?.cancel();

    super.dispose();
  }

  Widget waitingState(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
          ),
          SizedBox(height: 16),
          Text('Şonuçlar Bekleniyor'),
        ],
      ),
    );
  }

  Widget error(BuildContext context, String s) {
    return Center(child: Text(s, style: TextStyle(color: Colors.red)));
  }

  copyValue(BuildContext context, String label, String v) {
    return () {
      Clipboard.setData(ClipboardData(text: v));
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('Copied $label to clipboard: $v')));
    };
  }

  Widget noneState(BuildContext context) {
    return Text('None');
  }

  Widget resultList(BuildContext context) {
    return pageLoaded
        ? Center(
      child: FlatButton(
          onPressed: () {
            setState(() {});
            Navigator.pushNamed(context, '/');
          },
          child: Text('Cihazlara git')),
    )
        : Center(child:JumpingDotsProgressIndicator(
      fontSize: 30.0,));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[300],
        title: Text('Yükleniyor...'),
      ),
      body: Container(
        child: StreamBuilder<ESPTouchResult>(
          builder: (context, AsyncSnapshot<ESPTouchResult> snapshot) {

            if (snapshot.hasError) {
              return error(context, 'Error in StreamBuilder');
            }
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                ),
              );
            }
            switch (snapshot.connectionState) {
              case ConnectionState.active:
                return resultList(context);
              case ConnectionState.none:
                return noneState(context);
              case ConnectionState.done:
                return resultList(context);
              case ConnectionState.waiting:
                return waitingState(context);
            }
            return error(context, 'Unexpected');
          },
          stream: _stream,
        ),
      ),
    );
  }
}
