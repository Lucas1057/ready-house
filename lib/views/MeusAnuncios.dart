import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MeusAnuncios extends StatefulWidget {
  const MeusAnuncios({super.key});

  @override
  State<MeusAnuncios> createState() => _MeusAnunciosState();
}

class _MeusAnunciosState extends State<MeusAnuncios> {
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
    return Scaffold(
        appBar: AppBar(
          title: const Text('Meus Anúncios'),
          backgroundColor: Colors.green,
        ),
        body: Container(),
        floatingActionButton: FloatingActionButton(
          foregroundColor: Colors.white,
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, "/novo-anuncio");
          },
        ));
  }
}
