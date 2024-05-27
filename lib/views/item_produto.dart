// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:vendass/models/anuncio.dart';

class ItemProduto extends StatelessWidget {
  final Anuncio anuncio;
  final VoidCallback onTapItem;
  final VoidCallback? onPressedRemover;

  const ItemProduto(
      {super.key,
      required this.anuncio,
      required this.onTapItem,
      this.onPressedRemover});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapItem, //this.onTapItem,
      child: Container(
        margin: const EdgeInsets.all(5),
        color: Colors.black12,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              //Imagem
              SizedBox(
                width: 300,
                height: 200,
                child: Container(
                  color: Colors.orange,
                  child: anuncio.fotos[0] == null
                      ? Image.network(
                          "https://www.malhariapradense.com.br/wp-content/uploads/2017/08/produto-sem-imagem.png")
                      : Image.network(
                          anuncio.fotos[0],
                          fit: BoxFit.cover,
                        ),
                  // child: anuncio.fotos[0] == null ? Container() :Image.network(anuncio.fotos[0] ,fit: BoxFit.cover,),
                ),
              ),
              //Titulo e preco
            //  const Padding(
                // padding:
                    // const EdgeInsets.symmetric(horizontal: 0, vertical: 0 ),
                /* child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      anuncio.titulo,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Text("${anuncio.preco}")
                  ],
                ), */
              // ),

              // if (onPressedRemover != null)
              //   Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: FloatingActionButton(
              //       backgroundColor: Colors.red,

              //       onPressed: onPressedRemover, //this.onPressedRemover
              //       child: const Padding(
              //         padding: EdgeInsets.all(0),
              //         child: Icon(Icons.delete, color: Colors.white),
              //       ),
              //     ),
              //   )

              //botao remover
            ],
          ),
        ),
      ),
    );
  }
}
