

// ignore_for_file: must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher_string.dart';
import 'package:vendass/main.dart';
import 'package:vendass/models/anuncio.dart';

class DetalhesAnuncio extends StatefulWidget {
    Anuncio? anuncio;
    

DetalhesAnuncio({super.key, this.anuncio});
  

  @override
  State<DetalhesAnuncio> createState() => _DetalhesAnuncioState();
}

class _DetalhesAnuncioState extends State<DetalhesAnuncio> {
  
   Anuncio? _anuncio;
   
  //List<String>urls = ["https://images.creativemarket.com/0.1.0/ps/520037/1360/1234/m1/fpnw/wm1/jqnlos5tllcpu597jp2ynvmn2ismyuajq9yfpiuo3mrax8lpppafqczudweqpypz-.jpg?1434009176&s=2a672b5af2969671634b11eb8196e7b1",];

 List<Widget> _getListaImagens() {
   List<String> listaUrlImagns =  _anuncio!.fotos ; // ["https://images.creativemarket.com/0.1.0/ps/520037/1360/1234/m1/fpnw/wm1/jqnlos5tllcpu597jp2ynvmn2ismyuajq9yfpiuo3mrax8lpppafqczudweqpypz-.jpg?1434009176&s=2a672b5af2969671634b11eb8196e7b1"]; 
    return listaUrlImagns.map((url) {
      return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(url), fit: BoxFit.fitWidth)),
      ); //Image.network(url);
    }).toList();
  
  }
_ligarTelefone(String telefone)async{
if(await canLaunchUrlString("tel: $telefone")){
  await launchUrlString(telefone);
}else {
 "Não pode fazer a ligação";
}
}
  @override
  void initState() {
    super.initState();
   //_anuncio = widget.anuncio == null ? Anuncio() : widget.anuncio!;
    _anuncio = widget.anuncio;
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(iconTheme: const IconThemeData(size: 30,color: Colors.white30),title:const Text("Detalhes do Anuncio",
            style: TextStyle(
              color: Colors.white,
            ), 
            ) ,backgroundColor: Colors.black,),
        backgroundColor: Colors.white30,
       
      body: Stack(
        children: [
          //Conteudos
          ListView(
            children: <Widget>[
              
              SizedBox(
                  height: 250,
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 300,
                      autoPlay: false,
                    ),
                    items: _getListaImagens(),
                  )),
              Container(color: Colors.black26,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${_anuncio?.preco}",
                      style:  TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[900]),

                    ),
                    Text(
                      "${_anuncio?.titulo}",
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(),
                    ),
                    const Text(
                      "Descrição",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "${_anuncio?.descricao}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(),
                    ),
                    const Text(
                      "Contato",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                        Text(
                      "${_anuncio?.telefone}",
                      style: const TextStyle(
                        fontSize: 18,
                        
                      ),
                    ),
                   const Padding(padding:EdgeInsets.only(bottom: 66))
                  ],
                ),
              )
            ],
          ),
          //Botão ligar
          Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: GestureDetector(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: temaPadrao.backgroundColor,
                      borderRadius: BorderRadius.circular(30)),
                  child: const Text(
                    "Ligar",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                onTap: () {
                  _ligarTelefone(_anuncio?.telefone);
                },
              ))
        ],
      ),
    );
  }
}
//---------------------------------------------------------------------------------------
