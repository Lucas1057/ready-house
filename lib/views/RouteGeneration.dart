// ignore_for_file: file_names, dead_code

import 'package:flutter/material.dart';
import 'package:vendass/views/Anuncios.dart';
import 'package:vendass/views/Login.dart';
import 'package:vendass/views/MeusAnuncios.dart';
import 'package:vendass/views/NovoAnuncio.dart';

class RouteGeneration {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // ignore: unused_local_variable
    final args = settings.arguments;
    return generateRoute(settings);

    switch (settings.name) {
      case "/l":
        return MaterialPageRoute(builder: (_) => Anuncios());
      case "/login":
        return MaterialPageRoute(builder: (_) => const Login());
      case "/meus-anuncios":
        return MaterialPageRoute(builder: (_) => const MeusAnuncios());
      case "/novo-anuncio":
        return MaterialPageRoute(builder: (_) => const NovoAnuncio());
      /*case "/foto":
        return MaterialPageRoute(builder: (_) => const Foto());
      case "/tela":
        return MaterialPageRoute(builder: (_) => Tela_imagem());*/

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
