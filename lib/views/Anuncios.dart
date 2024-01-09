// ignore: file_names
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Anuncios extends StatefulWidget {
  @override
  State<Anuncios> createState() => _AnunciosState();
}

class _AnunciosState extends State<Anuncios> {
  List<String> itensMenu = [];
  _escolhaMenuItem(String itemEscolhido) {
    switch (itemEscolhido) {
      case "Meus anúncios":
        Navigator.pushNamed(context, "/meus-anuncios");

        break;
      case "Entrar / Cadastrar":
        Navigator.pushNamed(context, "/login");
        print('Meus anuncios');
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

  Future _verificarUsuarioLogado() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    User? usuarioLogado = await auth.currentUser; // firebaseUser

    if (usuarioLogado == null) {
      itensMenu = ["Entrar / Cadastrar"];
    } else {
      itensMenu = ["Meus anúncios", "Deslogar"];
    }
  }

  @override
  void initState() {
    super.initState();
    _verificarUsuarioLogado();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "OLX",
          style: TextStyle(color: Colors.white),
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
        backgroundColor: Colors.blue,
      ),
      body: Container(
        width: 400,
        color: Colors.grey,
        child: const Text('anuncios'),
      ),
    );
  }
}
