import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vendass/views/Anuncios.dart';
import 'package:vendass/views/Login.dart';
import 'package:vendass/firebase_options.dart';
import 'package:vendass/views/MeusAnuncios.dart';
import 'package:vendass/views/NovoAnuncio.dart';
import 'package:vendass/views/RouteGeneration.dart';

final ThemeData temaPadrao = ThemeData(
  primaryColor: const Color(0xff9c27b0),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Vendass   ",
    home: Anuncios(),
    theme: temaPadrao,
    initialRoute: "/l",
    routes: {
      '/l': (context) => Anuncios(),
      '/login': (context) => Login(), //modificacao
      '/meus-anuncios': (context) => MeusAnuncios(), //modificacao
      '/novo-anuncio': (context) => NovoAnuncio(), //modificacao
    },
    onGenerateRoute: RouteGeneration.generateRoute,
  ));
}
