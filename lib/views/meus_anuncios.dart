

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vendass/main.dart';
import 'package:vendass/models/anuncio.dart';

import 'package:vendass/views/item_anuncio.dart';

class MeusAnuncios extends StatefulWidget {
 
   const MeusAnuncios({super.key}); 
    

  @override
  State<MeusAnuncios> createState() => _MeusAnunciosState();
}

class _MeusAnunciosState extends State<MeusAnuncios> {
  
  
  

 final _controller = StreamController<QuerySnapshot>.broadcast();
  late String _idUsuarioLogado;
  _recuperaDadosUsuarioLogado() async {

    FirebaseAuth auth = FirebaseAuth.instance;
    User? usuarioLogado = auth.currentUser;
    _idUsuarioLogado = usuarioLogado!.uid;

  }
Future<Stream<QuerySnapshot>>_adicionarListenerAnuncios() async {

    await _recuperaDadosUsuarioLogado();

    FirebaseFirestore db = FirebaseFirestore.instance;
    Stream<QuerySnapshot> stream = db
        .collection("meus_anuncios")
        .doc( _idUsuarioLogado )
        .collection("anuncios")
        .snapshots();

    stream.listen((dados){
      _controller.add( dados );
    });
return const Stream.empty();//errorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr
  }
  _removerAnuncio(String idAnuncio){
FirebaseFirestore db = FirebaseFirestore.instance;
db.collection("meus_anuncios")
.doc(_idUsuarioLogado)
.collection("anuncios")
.doc(idAnuncio)
.delete().then((_) {
  db.collection("anuncios")
  .doc(idAnuncio)
  .delete();
});
  }
  
  @override
  void initState() {
    super.initState();
    _adicionarListenerAnuncios();
  }

  List<String> itensMenu = ["menu", "menives"];
  // ignore: unused_element
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
    await auth.signOut();

  
    // ignore: use_build_context_synchronously
    Navigator.pushNamed(context, "/login");
  }

  @override
  Widget build(BuildContext context) {

    
    var carregandoDados = const Center(
      child: Column(
        children: [Text("Carregando anúncios"), CircularProgressIndicator()],
      ),
    );
    return Scaffold(
        appBar: AppBar(
          title: const Text('Meus Anúncios'),
          backgroundColor: temaPadrao.backgroundColor,
          foregroundColor: temaPadrao.foregroundColor,
        ),
        body: StreamBuilder(
         stream: _controller.stream,
       
         
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return carregandoDados;
                
              case ConnectionState.active:
              case ConnectionState.done:
                //Exibir mensagem de erro
                if (snapshot.hasError) {
                  return const Text("Erro ao carregar os dados!");
                }
                QuerySnapshot<Object>?  querySnapshot = snapshot.data as QuerySnapshot<Object>?;
                return    ListView.builder(
                  
                   itemCount: querySnapshot?.docs.length,//contar a quantidade de documento que tem dentro de querysnapshort
                  
                    itemBuilder: (_, indice) {
// listaAnuncios = snapshot.data!.docs.map((e) => e.data()).toList();

                      List<DocumentSnapshot?> anuncios =
                          querySnapshot!.docs.toList();
                           
                          DocumentSnapshot<Object?>?  documentSnapshot = anuncios[indice] ;
                       //  print("${ } ----------------------------------------------------------------------------");
                         Anuncio anuncio = Anuncio.fromDocumentSnapshot(documentSnapshot!);//aqui tinha colocado como parametro DocumentSnapshot
                      return ItemAnuncio(
                        
                       anuncio: anuncio,// o anuncio fica aqui
                        
                        onPressedRemover: () {
                          
                          showDialog(context: context, builder: (context){
                            
                            return AlertDialog(
                              title: const Text("Confirmar"),
                              content: const Text("Deseja realmente excluir o anuncio?"),
                              actions: [
                                ElevatedButton(onPressed: (){Navigator.of(context).pop();}, child: const Text("Cancelar",
                              style: TextStyle(
                                color: Colors.grey
                              ),)),
                              ElevatedButton(onPressed: (){
                                _removerAnuncio(anuncio.id);
                                Navigator.of(context).pop();//----------------------- minha alteracao
                              }, child: const Text("Remover",
                              style: TextStyle(
                                color: Colors.grey
                              ),))
                              ],
                            );
                          });
                        }, onTapItem: () {}, 
                      );
                    });
            }
            // ignore: dead_code
            return const SizedBox(height: 100,width: 100);
          }
          ), 
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
           floatingActionButton: FloatingActionButton.extended(
          foregroundColor: temaPadrao.foregroundColor,
          backgroundColor: temaPadrao.backgroundColor,
           icon :const Icon(Icons.add),//versao extendida
           label:const Text("Adicionar Novo"),//versao extendida
          //child: const Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, "/novo-anuncio");
          },
        )
          );
      
       
  }
}
