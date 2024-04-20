import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vendass/main.dart';
import 'package:vendass/models/anuncio.dart';
/* import 'package:vendass/util/Configuracoes.dart'; */
import 'package:vendass/views/detalhes_anuncio.dart';
import 'package:vendass/views/item_anuncio.dart';

class Anuncios extends StatefulWidget {
  const Anuncios({super.key});

  @override
  State<Anuncios> createState() => _AnunciosState();
}

class _AnunciosState extends State<Anuncios> {
  List<String> itensMenu = [];

   List<Anuncio> listaAnuncios = [];

  final Stream<QuerySnapshot<Anuncio>> _controler = anuncioRef.snapshots();

  _escolhaMenuItem(String itemEscolhido) {
    switch (itemEscolhido) {
      case "Meus anúncios":
        Navigator.pushNamed(context, "/meus-anuncios");

        break;
      case "Entrar / Cadastrar":
        Navigator.pushNamed(context, "/login");
        break;
      case "Deslogar":
        _deslogarUsuario();
        break;
    }
  }

  _deslogarUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    Navigator.pushReplacementNamed(context, "/login");

    await auth.signOut();
  }

  Future _verificarUsuarioLogado() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    User? usuarioLogado = auth.currentUser; // firebaseUser

    if (usuarioLogado == null) {
      itensMenu = ["Entrar / Cadastrar"];
    } else {
      itensMenu = [
        "Meus anúncios",
        "Deslogar",
      ];
    }
  }

  //---------------------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  

    _verificarUsuarioLogado();
   
  }

  @override
  Widget build(BuildContext context) {
    var carregandoDados = const Center(
      child: Column(
        children: [
          Text("Carregando ánunioss"), 
          CircularProgressIndicator()],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: temaPadrao.backgroundColor,
        foregroundColor: temaPadrao.foregroundColor,
        title: const Text(
          "READY HOUSE",
          style: TextStyle(fontWeight: FontWeight.bold),
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
      body: Column(
        children: [
        

          //Listas de anúncios exibicão dos dados
          StreamBuilder<QuerySnapshot<Anuncio>>(
              stream: _controler,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return carregandoDados;

                  case ConnectionState.active:
                  case ConnectionState.done:
                    listaAnuncios =
                        snapshot.data!.docs.map((e) => e.data()).toList();

                    if (listaAnuncios.isEmpty) {
                      return Container(
                        padding: const EdgeInsets.all(25),
                        child: const Text(
                          "Nenhum anúncio! :( ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      );
                    }
                    return Expanded(
                      child: ListView.builder( 
                          itemCount: listaAnuncios.length,
                          itemBuilder: (_, indice) {
                            return ItemAnuncio(
                                anuncio: listaAnuncios[indice],
                                onTapItem: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          DetalhesAnuncio(
                                        anuncio: listaAnuncios[indice],
                                      ),
                                    ),
                                  );
                                  DetalhesAnuncio();
                                },
                               /*  onPressedRemover: () {} */
                               );
                          }),
                    );
                }
                
              })
        ],
      ),
    
    );
  }
}
