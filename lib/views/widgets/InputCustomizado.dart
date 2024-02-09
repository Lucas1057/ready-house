// ignore_for_file: file_names, unnecessary_this

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputCustomizado extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final bool autofocus;
  final TextInputType type;
  //final int maxLines;

  final List<TextInputFormatter> inputFormatters;
  final Function(String) validator;
  final Function(String?) onSaved; //-----------coloquei o ?

  const InputCustomizado(
      {super.key,
      required this.controller,
      required this.hint,
      this.obscure = false,
      this.autofocus = false,
      this.type = TextInputType.text,
      required this.inputFormatters,
      // required this.maxLines,

      required this.validator,
      required this.onSaved,
      required int maxLines});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      autofocus: autofocus,
      keyboardType: type,
      inputFormatters: this.inputFormatters,
      //maxLines: this.maxLines,
      onSaved: this.onSaved,
     // validator: this.validator,
      style: const TextStyle(fontSize: 20),
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6))),
    );
  }
}
