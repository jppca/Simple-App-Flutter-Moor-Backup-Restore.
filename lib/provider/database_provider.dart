import 'package:app_flutter_moor_backup_restore/database/moor_database.dart';
import 'package:flutter/material.dart';

//use of the provider to monitor the status of the App
class AppDatabaseNotifier extends ChangeNotifier {
  AppDatabase database;

  AppDatabaseNotifier() : database = AppDatabase();

  bool reOpen() {
    database = AppDatabase();
    notifyListeners();
    return true;
  }
}
