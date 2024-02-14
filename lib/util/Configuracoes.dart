// ignore_for_file: file_names, sort_child_properties_last

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';

class Configuracoes{
  static List <DropdownMenuItem<String>> getVans(){

//vans
  
List<DropdownMenuItem<String>> listaItensDropVans = [];


  
 listaItensDropVans.add(const DropdownMenuItem(
      
      child: Text("Vans",style: TextStyle(
        color: Color(0xff9c27b0),
      ),),
      value: null,
    ));

    return  listaItensDropVans;
  
}
  //--------------------------------------------------------------------------------
static List <DropdownMenuItem<String>> getEstados(){

//Região
  //Categoria
List<DropdownMenuItem<String>> listaItensDropEstados = [];


  //Categoria
 listaItensDropEstados.add(const DropdownMenuItem(
      
      child: Text("Região",style: TextStyle(
        color: Color(0xff9c27b0),
      ),),
      value: null,
    ));


    for (var estado in Estados.listaEstadosSigla) {
      listaItensDropEstados.add(DropdownMenuItem(
        child: Text(estado),
        value: estado,
      ));
    }
    return  listaItensDropEstados;
  
}

  //Categoria
  static List <DropdownMenuItem<String>> getCategorias(){
List<DropdownMenuItem<String>> itensDropCategorias = [];


  //Categoria
 itensDropCategorias.add(const DropdownMenuItem(
      
      child: Text("Categoria",style: TextStyle(
        color: Color(0xff9c27b0),
      ),),
      value: null,
    ));
  //----------------------------------
    itensDropCategorias.add(const DropdownMenuItem(
      
      child: Text("Automóvel"),
      value: "auto",
    ));
    itensDropCategorias.add(const DropdownMenuItem(
      child: Text("Imóvel"),
      value: "imovel",
    ));
    return itensDropCategorias;
 
}
}




  
    