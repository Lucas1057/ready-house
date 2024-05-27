// ignore_for_file: unused_element

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vendass/main.dart';
import 'package:vendass/models/anuncio.dart';
import 'package:vendass/views/detalhes_anuncio.dart';

import 'package:vendass/views/item_produto.dart';

class Produtos extends StatefulWidget {
  const Produtos({super.key});

  @override
  State<Produtos> createState() => _ProdutosState();
}

class _ProdutosState extends State<Produtos> {
  List<String> itensMenu = [];

   List<Anuncio> listaAnuncios = [];
   bool pesquisa= false;

 final TextEditingController _searchController = TextEditingController();
  Stream<QuerySnapshot<Map<String, dynamic>>> _productsStream =
      FirebaseFirestore.instance.collection('anuncios').snapshots();

  //  late List<DropdownMenuItem<String>> _listaItensDropCategorias;
  // late List<DropdownMenuItem<String>> _listaItensDropEstados; 
 

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
    // _listaItensDropCategorias = Configuracoes.getCategorias();
    // //Estados
    // _listaItensDropEstados = Configuracoes.getEstados();
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
     _searchController.addListener(() {
      final searchText = _searchController.text;
      if (searchText.isNotEmpty) {
        _productsStream = FirebaseFirestore.instance
            .collection('products')
            .where('name', isGreaterThanOrEqualTo: searchText)
            .where('name', isLessThanOrEqualTo: searchText + '\ufff0')
            .snapshots();
      } else {
        _productsStream = FirebaseFirestore.instance
            .collection('products')
            .snapshots();
      }
    });
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
        backgroundColor: Colors.black,
        foregroundColor: temaPadrao.foregroundColor,
         title: TextField(
          style:const TextStyle(color: Colors.white) ,
          controller: _searchController,
          decoration:  InputDecoration(
            labelStyle: const TextStyle(backgroundColor: Colors.green),
            fillColor: Colors.white,
            hoverColor: const Color.fromARGB(255, 149, 244, 54),
            border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
            hintText: 'Pesquisar produtos',hintStyle: const TextStyle(color: Colors.white),
            suffixIcon: IconButton(
              icon:pesquisa ? const Icon(Icons.arrow_back,color: Colors.white,):const Icon(Icons.search,color: Colors.white),
              onPressed: () {
                setState(() {
                  pesquisa = !pesquisa;
                });
              },
            ),
          ),
        ),
        elevation: 0,
        actions: [
          
          /* IconButton(
            onPressed: (){
              showSearch(
                context: context,
               delegate: CustomSearchDelegate());
            },
            icon:const Icon(Icons.search),
          ), */
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
      body:
      
       Column(
        children: [
         /*  StreamBuilder<QuerySnapshot<Map<String , dynamic>>>(stream: _productsStream,
           builder: (context, snapshot){
            if(snapshot.hasError){
              return const Center(child: Text('Erro ao carregar os produtos'),);
            }
            if(snapshot.hasData){
               final products = snapshot.data!.docs;
                  return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index].data();
                return ListTile(
                  title: Text(product['nome']),
                );
            },
                  );
           }
           return const Center(child: CircularProgressIndicator(),);
           },
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
                        scrollDirection: Axis.horizontal,
                          itemCount: listaAnuncios.length,
                          itemBuilder: (_, indice) {
                            return ItemProduto(
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
              }),
              Container(height: 300,)

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
 /*  class CustomSeartDelegate extends Produtos {
    
    List<String> searchTerms = [
      'Apple',
      'Banana',
      'Orange',
    ];
    //  @override
      List<Widget> buildActions(BuildContext context){
return[
  IconButton(onPressed:(){
     query ='';
  }, icon:const Icon(Icons.clear),),
];
      }
      //  @override
       Widget buildLeading(BuildContext context){
    return    IconButton(onPressed:(){
    close(context, null);
  }, icon:const Icon(Icons.arrow_back),);
      }
@override
      Widget buildResult(BuildContext context){
        List<String> matchQuery = [];
        for (var fruit in searchTerms){
          if(fruit.toLowerCase().contains(query.toLowerCase())){
            matchQuery.add(fruit);
          }
                  }
                  return ListView.builder(
                    itemCount: matchQuery.length,
                    itemBuilder: (context, index){
                      var resut = matchQuery[index];
                      return ListTile(
                        title: Text(resut),
                      );
                    },
                  );
      }
  @override
      Widget buildSuggestions(BuildContext context){
        List<String> matchQuery = [];
         for (var fruit in searchTerms){
          if(fruit.toLowerCase().contains(query.toLowerCase())){
            matchQuery.add(fruit);
          }
      }
        return ListView.builder(
                    itemCount: matchQuery.length,
                    itemBuilder: (context, index){
                      var resut = matchQuery[index];
                      return ListTile(
                        title: Text(resut),
                      );
                    },
                  );

  } */
  
