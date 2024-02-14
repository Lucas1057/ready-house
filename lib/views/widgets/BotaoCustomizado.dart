// ignore_for_file: file_names, use_key_in_widget_constructors, unnecessary_this

import 'package:flutter/material.dart';


class BotaoCustomizado extends StatelessWidget {
  final String texto;
  final Color corTexto;
  final VoidCallback onPressed;

  const BotaoCustomizado(
      {required this.texto,
      this.corTexto = Colors.white24,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor:Colors.cyan ,
    // style: ElevatedButton.styleFrom(backgroundColor: temaPadrao.foregroundColor),

      //shape:RoudedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      onPressed: this.onPressed,
      child: Text(
        this.texto,
        style: TextStyle(color: this.corTexto, fontSize: 20),
        
      ),
    );
  }
}
