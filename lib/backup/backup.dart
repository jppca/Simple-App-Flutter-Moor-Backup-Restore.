import 'dart:io';
import 'package:app_flutter_moor_backup_restore/provider/database_provider.dart';
import 'package:app_flutter_moor_backup_restore/widgets/dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as p;

class Backup {
  //address to save copy
  static Future<Directory> getSaveDir() async {
    final Directory directory = await getExternalStorageDirectory();
    final Directory exportDir = Directory('${directory.path}/export');
    bool exits = await exportDir.exists();
    if (!exits) {
      await new Directory('${directory.path}/export').create(recursive: true);
    }
    exits = await exportDir.exists();
    if (exits) {
      return exportDir;
    }
    return null;
  }

  static Future<void> backup(BuildContext context) async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    final dbNotifier = Provider.of<AppDatabaseNotifier>(context, listen: false);

    final Directory exportDir = await getSaveDir();
    final fileBackup = File(p.join(exportDir.path, 'db_backup.sqlite'));

    //close database to overwrite
    dbNotifier.database.close();

    if (await fileBackup.exists()) {
      await fileBackup.delete();
    }
    await fileBackup.writeAsBytes(await file.readAsBytes(), flush: true);

    // Open Database again
    if (dbNotifier.reOpen()) {
      MyDialog.dialog(
        context,
        'Su copia local de seguridad fue realizada con éxito.',
        Text('Ubicación: ${fileBackup.path}'),
      );
    }
  }
}
