import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vendass/main.dart';
import 'package:vendass/models/anuncio.dart';
import 'package:vendass/util/Configuracoes.dart'; 
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

   late List<DropdownMenuItem<String>> _listaItensDropCategorias;
  late List<DropdownMenuItem<String>> _listaItensDropEstados; 
 

  final Stream<QuerySnapshot<Anuncio>> _controler = anuncioRef.snapshots();
   String? _itemSelecionadoEstado;
  String? _itemSelecionadoCategoria; 
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

    _carregarItensDropdown() {
     
    //Categoria
    _listaItensDropCategorias = Configuracoes.getCategorias();
    //Estados
    _listaItensDropEstados = Configuracoes.getEstados();
  } 
 
  //----------------------------------STREAM BUILDER FILTRAR ANUNCIO
   Future<Stream<QuerySnapshot>?> _filtrarAnuncios() async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    Query query = db.collection("anuncios");

    if (_itemSelecionadoEstado != null) {
      query = query.where("estado", isEqualTo: _itemSelecionadoEstado);
     }
     if (_itemSelecionadoCategoria != null) {
       query = query.where("categoria", isEqualTo: _itemSelecionadoCategoria);
     }
    
     Stream<QuerySnapshot> stream = query.snapshots();
// //--------------------
     stream.listen((dados) {
       _controler.any(dados as bool Function(QuerySnapshot<Anuncio> element));
     });
// //---------------------------
     return const Stream.empty();
  }

  //---------------------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
     _carregarItensDropdown(); 
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
        StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(), // Stream user changes
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              // User is logged in, show green icon
              return IconButton(
                onPressed: () {
                  // Handle logged-in actions
                  const SnackBar(content: Text('Voce esta logado'),);
                },
                icon: const Icon(Icons.check_circle_outline, color: Colors.green),
              );
            } else {
              // User is logged out, show red icon
              return IconButton(
                onPressed: () {
                  // Handle login flow
                  _showLoginRequiredDialog(context); 
                },
                icon: const Icon(Icons.cancel, color: Colors.red),
              );
            }
          },
        ),
         //------------------------------------------------------------
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
           Row(
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
                           _filtrarAnuncios();
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
                           _filtrarAnuncios();
                        });
                      }),
                ),
              )),
              Container(
                color: Colors.grey[200],
                width: 2,
                height: 60,
              ),
             
            ],
          ), 

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

                  if (snapshot.hasError) {
                return Text('Erro ao carregar dados: ${snapshot.error}');
                } else {
                listaAnuncios =
                snapshot.data!.docs.map((e) => e.data()).toList(); 
              // ignore: avoid_print
              print(" o tamanho é ${listaAnuncios.length} ");}
                    
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
                                  final user = FirebaseAuth.instance.currentUser; // Get current user
                                  if(user != null){
                                    Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          DetalhesAnuncio(
                                        anuncio: listaAnuncios[indice],
                                      ),
                                    ),
                                  );
                                  } else {
            // User is logged out, show login required message or redirect
            _showLoginRequiredDialog(context); // Replace with your logic
          }
                                }
                                // onPressedRemover: () {}
                                );
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
  void _showLoginRequiredDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Precisa fazer o Login'),
        content: const Text('Voce precisa logar para acessar os Detalhes do anuncio'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, "/login");
            },
            child: const Text('Login'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
