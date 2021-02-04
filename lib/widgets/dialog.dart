import 'package:flutter/material.dart';

class MyDialog {
  static Future<Widget> dialog(
      BuildContext context, String text, Widget widget) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text('Mensaje'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(text),
                SizedBox(
                  height: 10,
                ),
                widget,
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Regresar")),
            ],
          );
        });
  }
}
