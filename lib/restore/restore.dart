import 'dart:io';
import 'dart:typed_data';
import 'package:app_flutter_moor_backup_restore/provider/database_provider.dart';
import 'package:app_flutter_moor_backup_restore/widgets/dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as p;

class Restore {
//method to restore database
  static Future<void> restore(BuildContext context) async {
    final dbNotifier = Provider.of<AppDatabaseNotifier>(context, listen: false);
    final dbFolder = await getApplicationDocumentsDirectory();
    final dbLocation = p.join(dbFolder.path, 'db.sqlite');

    dbNotifier.database.close();
//acess file
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      if (result.files.single.name != 'db_backup.sqlite') {
        MyDialog.dialog(
            context,
            'El archivo que se selecciono no es considerado un copia de seguridad válida.',
            Text(
                'Para que el archivo pueda ser restaurado debe de tener el siguiente nombre y extensión: \n\n db_backup.sqlite'));
        dbNotifier.reOpen();
      } else {
        Uint8List updatedContent =
            await File(result.files.single.path).readAsBytes();
        futureBuilderRes(
            futureBuilderFile(dbLocation, updatedContent), context, dbNotifier);
      }
    } else {
      dbNotifier.reOpen();
      MyDialog.dialog(context, ' ', Text('No se selecciono ningún archivo.'));
    }
  }

//Method in charge of restoring the backup.
  static Future<bool> futureBuilderFile(
      String dbLocation, Uint8List updatedContent) async {
    await File(dbLocation).writeAsBytes(updatedContent, flush: true);
    return true;
  }

//Method responsible for returning the response while restoring the backup.
  static Future<Widget> futureBuilderRes(Future<bool> res, BuildContext context,
      AppDatabaseNotifier appDatabaseNotifier) async {
    if (res != null) {
      appDatabaseNotifier.reOpen();
      return MyDialog.dialog(
        context,
        '',
        Text('Copia de seguridad restaurada con éxito.'),
      );
    } else {
      return showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            );
          });
    }
  }
}
