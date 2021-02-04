import 'package:app_flutter_moor_backup_restore/backup/backup.dart';
import 'package:app_flutter_moor_backup_restore/restore/restore.dart';
import 'package:flutter/material.dart';

class BackupScreen extends StatefulWidget {
  const BackupScreen({Key key}) : super(key: key);

  @override
  _BackupScreenState createState() => _BackupScreenState();
}

class _BackupScreenState extends State<BackupScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          Text('Backup and Restore'),
        ]),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 240,
              height: 120,
              child: Card(
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: RaisedButton(
                  color: Colors.green,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Colors.blueGrey[700]),
                  ),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Backup',
                        style: TextStyle(
                          fontSize: 24.0,
                        ),
                      ),
                      Icon(
                        Icons.file_copy_sharp,
                        size: 80,
                      ),
                    ],
                  ),
                  onPressed: () async {
                    await Backup.backup(context);
                  },
                ),
              ),
            ),
            SizedBox(height: 80),
            Container(
              width: 240,
              height: 120,
              child: Card(
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: RaisedButton(
                  color: Colors.green,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Colors.blueGrey[700]),
                  ),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Restore',
                        style: TextStyle(
                          fontSize: 24.0,
                        ),
                      ),
                      Icon(
                        Icons.restore,
                        size: 80,
                      ),
                    ],
                  ),
                  onPressed: () async {
                    await Restore.restore(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

/*
-----------------------------------------------------------------------------
//method to perform backup
  Future<void> _backup() async {
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
      dialog(context, 'Ubicación: ${fileBackup.path}',
          'Su copia local de seguridad fue realizada con éxito.');
    }
  }

//method to restore database
  Future<void> _restore() async {
    final dbNotifier = Provider.of<AppDatabaseNotifier>(context, listen: false);
    final dbFolder = await getApplicationDocumentsDirectory();
    final dbLocation = p.join(dbFolder.path, 'db.sqlite');

    dbNotifier.database.close();
    //acess file
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      if (result.files.single.path != 'db_backup.sqlite') {
        dialog(
            context,
            'Para que el archivo pueda ser restaurado debe de tener el siguiente nombre y extensión: \n\n db_backup.sqlite',
            'El archivo que se selecciono no es considerado un copia de seguridad válida.');
        dbNotifier.reOpen();
      } else {
        Uint8List updatedContent =
            await File(result.files.single.path).readAsBytes();

        await File(dbLocation).writeAsBytes(updatedContent, flush: true);
        //for start database

        // SystemNavigator.pop();
        dialog(context, '', 'Copia de seguridad restaurada con éxito.');
        if (dbNotifier.reOpen()) {}
      }
    } else {
      dbNotifier.reOpen();
      dialog(context, ' ', 'No se selecciono ningún archivo.');
    }
  }*/
}
