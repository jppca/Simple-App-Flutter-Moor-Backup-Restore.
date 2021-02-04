import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../pages/backup_restore_page.dart';
import '../pages/home_page.dart';

//Class in charge of identifying routes
class Routere {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/backupRestore':
        return MaterialPageRoute(builder: (_) => BackupScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}'))));
    }
  }
}
