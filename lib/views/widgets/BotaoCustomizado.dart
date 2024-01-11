import 'package:flutter/material.dart';

class BotaoCustomizado extends StatelessWidget {
  final String texto;
  final Color corTexto;
  final VoidCallback onPressed;

  BotaoCustomizado(
      {required this.texto,
      this.corTexto = Colors.white,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: Colors.blue),

      //shape:RoudedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      onPressed: this.onPressed,
      child: Text(
        this.texto,
        style: TextStyle(color: this.corTexto, fontSize: 20),
      ),
    );
  }
}
