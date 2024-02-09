// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_is_empty

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vendass/models/Anuncio.dart';
import 'package:vendass/util/Configuracoes.dart';
import 'package:vendass/views/itemAnuncio.dart';

class Anuncios extends StatefulWidget {
  @override
  State<Anuncios> createState() => _AnunciosState();
}

class _AnunciosState extends State<Anuncios> {

  
  List<String> itensMenu = [];

  late List<DropdownMenuItem<String>> _listaItensDropCategorias;
  late List<DropdownMenuItem<String>> _listaItensDropEstados;
     
     final _controler = StreamController<QuerySnapshot>.broadcast();
     String? _itemSelecionadoEstado;
     String? _itemSelecionadoCategoria;
  _escolhaMenuItem(String itemEscolhido) {
    switch (itemEscolhido) {
      case "Meus anúncios":
        Navigator.pushNamed(context, "/meus-anuncios");

        break;
      case "Entrar / Cadastrar":
        Navigator.pushNamed(context, "/login");
        //print('Meus anuncios');
        break;
      case "Deslogar":
        _deslogarUsuario();
        break;
      case "Foto":
        Navigator.pushNamed(context, "/foto");
        break;
      case "Tela":
        Navigator.pushNamed(context, "/tela");
        break;
    }
  }

  _deslogarUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();

    // ignore: use_build_context_synchronously
    Navigator.pushNamed(context, "/login");
  }

  Future _verificarUsuarioLogado() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    // ignore: await_only_futures
    User? usuarioLogado = await auth.currentUser; // firebaseUser

    if (usuarioLogado == null) {
      itensMenu = ["Entrar / Cadastrar"];
    } else {
      itensMenu = ["Meus anúncios", "Deslogar", /*"Foto", "Tela"*/];
    }
  }
 _carregarItensDropdown() {
    //Categoria
    _listaItensDropCategorias = Configuracoes.getCategorias();
    //Estados

   _listaItensDropEstados = Configuracoes.getEstados();
  }

  Future<Stream<QuerySnapshot>> _adicionarListenerAnuncios() async{
FirebaseFirestore db = FirebaseFirestore.instance;
Stream<QuerySnapshot> stream = db.collection("anuncios")
.snapshots();

//--------------------
stream.listen((dados) {
  _controler.add(dados);
 });
//---------------------------
return const Stream.empty();
  }
  //----------------------------------STREAM BUILDER FILTRAR ANUNCIO
   Future<Stream<QuerySnapshot>> _filtrarAnuncios() async{
FirebaseFirestore db = FirebaseFirestore.instance;

Query query=db.collection("anuncios");

if(_itemSelecionadoEstado != null){
query = query.where("estado",isEqualTo: _itemSelecionadoEstado);
}
if(_itemSelecionadoCategoria != null){
query = query.where("categoria",isEqualTo: _itemSelecionadoCategoria);
}
Stream<QuerySnapshot> stream = query.snapshots();
//--------------------
stream.listen((dados) {
  _controler.add(dados);
 });
//---------------------------
return const Stream.empty();
  }
  //---------------------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _carregarItensDropdown();
    
    _verificarUsuarioLogado();
     _adicionarListenerAnuncios() ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "OLX",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        elevation: 0,
        actions: [
          PopupMenuButton(
              onSelected: _escolhaMenuItem,
              itemBuilder: (context) {
                return itensMenu.map((String item) {
                  return PopupMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList();
              })
        ],
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
      
        child: Column(children: [
          //filtros
Row(children: [
  Expanded(child: DropdownButtonHideUnderline(child: Center(
    child: DropdownButton(
      iconEnabledColor: const Color(0xff9c27b0) ,dropdownColor: Colors.amber,
      value: _itemSelecionadoEstado,// esse erro aqui initialied
      items: _listaItensDropEstados,
      style: const TextStyle(fontSize:22 ,color: Colors.black ),
      
       onChanged:(estado){
        setState(() {
          _itemSelecionadoEstado = estado!;
          _filtrarAnuncios();
        });
      }),
  ) ,)
  ),

Container(
  color: Colors.grey[200],
  width:2 ,
  height: 60,
),
  Expanded(child: DropdownButtonHideUnderline(child: Center(
    child: DropdownButton(
      iconEnabledColor: const Color(0xff9c27b0) ,
      value: _itemSelecionadoCategoria,
      items: _listaItensDropCategorias,
      style: const TextStyle(fontSize:22 ,color: Colors.black ),
      
       onChanged:(categoria){
        setState(() {
          _itemSelecionadoCategoria = categoria!;
          _filtrarAnuncios();
        });
      }),
  ) ,)
  ),
],),


          //Listas de anúncios exibicão dos dados
StreamBuilder(stream:_controler.stream, 
builder: (context,snapshot){
  switch(snapshot.connectionState){
case ConnectionState.none:
case ConnectionState.waiting:
case ConnectionState.active:
case ConnectionState.done:

    QuerySnapshot<Object?>? querySnapshot = snapshot.data;
   if( querySnapshot?.docs.length== 0){
return Container(
  padding: const EdgeInsets.all(25),
  child: const Text("Nenhum anúncio! :( ",style: TextStyle(
    fontWeight: FontWeight.bold
  ),),
);
   }
   return Expanded(
    child: ListView.builder(
      itemCount: querySnapshot?.docs.length ,
      itemBuilder: (_, indice){
         List<DocumentSnapshot> anuncios =
                          querySnapshot!.docs.toList();
                          DocumentSnapshot documentSnapshot = anuncios[indice];
                          Anuncio anuncio = Anuncio.fromDocumentSnapshot(documentSnapshot);

                          return ItemAnuncio(anuncio: anuncio, onTapItem: (){}, onPressedRemover:(){});
      }),
      );
  }
  //return Container();

}
)
        ],),
      ),
    );
  }
}
