import 'package:esptouch_example/esptouch_flutter.dart';
import 'package:esptouch_example/route_generator.dart';
import 'package:esptouch_example/screens/add_devices_screen.dart';
import 'package:esptouch_example/screens/app_screen.dart';
import 'package:esptouch_example/screens/login_screen.dart';
import 'package:esptouch_example/screens/on_off_screen.dart';
import 'package:esptouch_example/screens/registration_screen.dart';
import 'package:esptouch_example/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();

  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(ESPTouchResultAdapter());


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: RouteGenerator.generateRoute,
      title: 'navigation',
      home: FutureBuilder(
          future: Hive.openBox('devices'),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.connectionState == ConnectionState.done){
              if(snapshot.hasError) return Text(snapshot.error.toString());
              else return AddDevices();

            }
            else return CircularProgressIndicator();
          }

      ),

      //onGenerateRoute: RouteGenerator.generateRoute,




      // routes: {
      //   'on_off_screen': (context) =>
      //       OnOff(cihaz: ESPTouchResult(ip: '1', bssid: '2')),
      //   'add_devices_screen': (context) => AddDevices(
      //         cihazlar: [ESPTouchResult(ip: '1', bssid: '2')],
      //       ),
      //   'welcome_screen': (context) => WelcomeScreen(),
      //   'login_screen': (context) => LoginScreen(),
      //   'registration_screen': (context) => RegistrationScreen(),
      //   'app_screen': (context) => AppScreen(),
      //
      // },
    );
  }
  // @override
  // void dispose() {
  //   Hive.close();
  //   super.dispose();
  // }
}

