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

  /* late List<DropdownMenuItem<String>> _listaItensDropCategorias;
  late List<DropdownMenuItem<String>> _listaItensDropEstados; */
  //late List<DropdownMenuItem<String>> _listaItensDropVans;

  final Stream<QuerySnapshot<Anuncio>> _controler = anuncioRef.snapshots();
 /*  String? _itemSelecionadoEstado;
  String? _itemSelecionadoCategoria; */
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

  /* _carregarItensDropdown() {
    //Categoria
    _listaItensDropCategorias = Configuracoes.getCategorias();
    //Estados

    _listaItensDropEstados = Configuracoes.getEstados();
    //Vans
    //  _listaItensDropVans = Configuracoes.getVans();
  } */

  //----------------------------------STREAM BUILDER FILTRAR ANUNCIO
//   Future<Stream<QuerySnapshot>> _filtrarAnuncios() async {
//     FirebaseFirestore db = FirebaseFirestore.instance;

//     Query query = db.collection("anuncios");

//     if (_itemSelecionadoEstado != null) {
//       query = query.where("estado", isEqualTo: _itemSelecionadoEstado);
//     }
//     if (_itemSelecionadoCategoria != null) {
//       query = query.where("categoria", isEqualTo: _itemSelecionadoCategoria);
//     }
//     if (_itemSelecionadoVans != null) {
//       query = query.where("vans", isEqualTo: _itemSelecionadoVans);
//     }
//     Stream<QuerySnapshot> stream = query.snapshots();
// //--------------------
//     stream.listen((dados) {
//       _controler.add(dados);
//     });
// //---------------------------
//     return const Stream.empty();
//   }

  //---------------------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
   /*  _carregarItensDropdown(); */

    _verificarUsuarioLogado();
    // _adicionarListenerAnuncios();
  }

  @override
  Widget build(BuildContext context) {
    var carregandoDados = const Center(
      child: Column(
        children: [Text("Carregando ánunioss"), CircularProgressIndicator()],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: temaPadrao.backgroundColor,
        foregroundColor: temaPadrao.foregroundColor,
        title: const Text(
          "PECH",
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
          //filtros
          /* Row(
            children: [
              Expanded(
                  child: DropdownButtonHideUnderline(
                child: Center(
                  child: DropdownButton(
                      iconEnabledColor: const Color(0xff9c27b0),
                      dropdownColor: Colors.amber,
                      value:
                          _itemSelecionadoEstado, // esse erro aqui initialied
                      items: _listaItensDropEstados,
                      style: const TextStyle(fontSize: 22, color: Colors.black),
                      onChanged: (estado) {
                        setState(() {
                          _itemSelecionadoEstado = estado!;
                          // _filtrarAnuncios();
                        });
                      }),
                ),
              )),
              Container(
                color: Colors.grey[200],
                width: 2,
                height: 60,
              ),
              Expanded(
                  child: DropdownButtonHideUnderline(
                child: Center(
                  child: DropdownButton(
                      iconEnabledColor: const Color(0xff9c27b0),
                      value: _itemSelecionadoCategoria,
                      items: _listaItensDropCategorias,
                      style: const TextStyle(fontSize: 22, color: Colors.black),
                      onChanged: (categoria) {
                        setState(() {
                          _itemSelecionadoCategoria = categoria!;
                          // _filtrarAnuncios();
                        });
                      }),
                ),
              )),
              Container(
                color: Colors.grey[200],
                width: 2,
                height: 60,
              ),
              /* Expanded(
                  child: DropdownButtonHideUnderline(
                child: Center(
                  child: DropdownButton(
                      iconEnabledColor: const Color(0xff9c27b0),
                      value: _itemSelecionadoVans,
                      items: _listaItensDropVans,
                      style:
                          const TextStyle(fontSize: 22, color: Colors.black),
                      onChanged: (vans) {
                        setState(() {
                          _itemSelecionadoVans = vans!;
                          _filtrarAnuncios();
                        });
                      }),
                ),
              )),*/
            ],
          ), */

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
                                onPressedRemover: () {});
                          }),
                    );
                }
                //return Container();
              })
        ],
      ),
      /* floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Transporte",
                  style: TextStyle(color: Colors.white, fontSize: 8),
                ),
                Icon(Icons.car_crash_rounded, color: Colors.white),
              ]),
          onPressed: () {
            Navigator.pushNamed(context, "/map");
          }), */
    );
  }
}
