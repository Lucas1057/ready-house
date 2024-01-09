// ignore: file_names
// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:vendass/views/Anuncios.dart';
import 'package:vendass/views/Login.dart';
import 'package:vendass/views/MeusAnuncios.dart';
import 'package:vendass/views/NovoAnuncio.dart';

class RouteGeneration {
  static Route<dynamic> generateRoute(RouteSettings settings) {
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

      default:
        _erroRota();
    }
  }

  static Route<dynamic> _erroRota() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("tela não encontrada"),
        ),
        body: const Center(
          child: Text("tela não encontrada!"),
        ),
      );
    });
  }
}
