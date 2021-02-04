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
}
