// ignore_for_file: file_names, unnecessary_this

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class InputCustomizado extends StatelessWidget {
  final TextEditingController? controller;
  final String hint;
  final bool obscure;
  final bool? autofocus;
  final TextInputType? type;
 

  //final int maxLines;

  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? validator;
  final Function(String?)? onSaved; //-----------coloquei o ?

  const InputCustomizado(
      {super.key,
      this.controller,
      required this.hint,
      required this.obscure,
      this.autofocus = false,
      this.type = TextInputType.text,
   
     this.inputFormatters,
      // required th, required IconData iconeis.maxLines,

      required this.validator,
      required this.onSaved,
       int? maxLines,
       
       });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      autofocus: false,
      keyboardType: type,
      
      inputFormatters: this.inputFormatters,
      maxLines: 1,
      onSaved: this.onSaved,
     // validator: this.validator,
      style: const TextStyle(fontSize: 20),
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
          hintText: hint,
          
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18))),
    );
  }
}
