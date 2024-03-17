/* // ignore_for_file: file_names, dead_code

import 'package:flutter/material.dart';
import 'package:vendass/views/anuncios.dart';
import 'package:vendass/views/detalhes_anuncio.dart';
import 'package:vendass/views/login.dart';

import 'package:vendass/views/novo_anuncio.dart';

class RouteGeneration {
  static Route<dynamic> generateRoute(RouteSettings settings) {
   // final args = settings.arguments;

    return generateRoute(settings);

    switch (settings.name) {
      case "/l":
        return MaterialPageRoute(builder: (_) => const Anuncios());
      case "/login":
        return MaterialPageRoute(builder: (_) => const Login());
    /*   case "/meus-anuncios":
        return MaterialPageRoute(builder: (_) => const MeusAnuncios()); */
      case "/novo-anuncio":
        return MaterialPageRoute(builder: (_) => const NovoAnuncio());

      case "/detalhes-anuncio":
        return MaterialPageRoute(builder: (_) => DetalhesAnuncio());

      default:
        _erroRota();
    }
  }

  static Route<dynamic> _erroRota() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("tela não encontrada"),
        ),
        body: const Center(
          child: Text("tela não encontrada!"),
        ),
      );
    });
  }
}
 */