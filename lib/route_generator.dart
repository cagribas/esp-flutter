import 'package:esptouch_example/esptouch_flutter.dart';
import 'package:esptouch_example/screens/add_devices_screen.dart';
import 'package:esptouch_example/screens/app_screen.dart';
import 'package:esptouch_example/screens/login_screen.dart';
import 'package:esptouch_example/screens/on_off_screen.dart';
import 'package:esptouch_example/screens/registration_screen.dart';
import 'package:esptouch_example/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => AddDevices());

      case '/on_off':
        return MaterialPageRoute(
            builder: (_) => OnOff(
                  args,
                ));

      case '/app_screen':
        return MaterialPageRoute(builder: (_) => AppScreen());
      case '/welcome':
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
      case '/registration_screen':
        return MaterialPageRoute(builder: (_) => RegistrationScreen());
      case '/login_screen':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(child: Text('Error')),
                ));
    }
  }
}
