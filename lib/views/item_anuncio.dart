

// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:vendass/models/anuncio.dart';


class ItemAnuncio extends StatelessWidget {
  final Anuncio anuncio;
  final VoidCallback? onTapItem;
  final VoidCallback? onPressedRemover;

  const ItemAnuncio ({super.key, 
     required this.anuncio,
      this.onTapItem,
       this.onPressedRemover 
   
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapItem, //this.onTapItem,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              //Imagem
               SizedBox(
                width: 120,
                height: 120,
                child: Container(color: Colors.orange,
                  child: anuncio.fotos[0]== null ? Image.network("https://www.malhariapradense.com.br/wp-content/uploads/2017/08/produto-sem-imagem.png"):Image.network(anuncio.fotos[0],fit: BoxFit.cover,), 
                  // child: anuncio.fotos[0] == null ? Container() :Image.network(anuncio.fotos[0] ,fit: BoxFit.cover,), 
                
                 
                 ),
                
               ),
              //Titulo e preco
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        anuncio.titulo,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(" ${anuncio.preco}")
                    ],
                  ),
                ),
              ),
              
              if(onPressedRemover != null)  Expanded(//this.onPressedRemover
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                    backgroundColor:  Colors.red,
                  
                    onPressed: onPressedRemover,//this.onPressedRemover
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(Icons.delete,color: Colors.white),
                      
                    ),
                  ),
                ),
              )

              //botao remover
            ],
          ),
        ),
      ),
    );
  }
}
