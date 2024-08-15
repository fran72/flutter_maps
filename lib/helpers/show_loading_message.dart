import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showLoadingMessage(BuildContext context) {
  if (Platform.isAndroid) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
          title: Text('Espere por favor'),
          content: SizedBox(
            height: 160,
            width: 100,
            child: Column(
              children: [
                Text('Calculando ruta'),
                SizedBox(height: 6),
                CircularProgressIndicator(strokeWidth: 2, color: Colors.black),
              ],
            ),
          )),
    );
    return;
  }

  showCupertinoDialog(
    context: context,
    builder: (context) => const CupertinoAlertDialog(
      title: Text('Espere por favor'),
      content: Text('Calculando ruta'),
    ),
  );
}
