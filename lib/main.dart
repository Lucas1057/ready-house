import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vendass/views/anuncios.dart';
import 'package:vendass/views/detalhes_anuncio.dart';
import 'package:vendass/views/login.dart';
import 'package:vendass/firebase_options.dart';
import 'package:vendass/views/meus_anuncios.dart';
import 'package:vendass/views/novo_anuncio.dart';



ThemeData temaPadraox = ThemeData(
  primaryColor: const Color(0xFF1D361F) //const Color(0xff9c27b0),
); 

 AppBarTheme temaPadrao= const AppBarTheme(
  backgroundColor: Color(0xFF859B48), 
  foregroundColor: Colors.white70
); 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "READY HOUSE   ",
    home: const Anuncios(),  
    theme: temaPadraox,
    initialRoute: "/login",
    routes: {
      '/l': (context) =>const Anuncios(),
      '/login': (context) => const Login(), //modificacao
      '/meus-anuncios': (context) => const MeusAnuncios(), //modificacao
      '/novo-anuncio': (context) => const NovoAnuncio(), //modificacao
     // '/foto': (context) => const Foto(), //modificacao
     // '/tela': (context) => Tela_imagem(),
      '/detalhes-anuncio': (context) =>   DetalhesAnuncio(),
       
    },
   /*  onGenerateRoute: RouteGeneration.generateRoute, */
  ));
}
   