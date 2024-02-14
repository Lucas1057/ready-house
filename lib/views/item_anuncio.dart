// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:vendass/models/Anuncio.dart';

// ignore: must_be_immutable
class ItemAnuncio extends StatelessWidget {
  Anuncio anuncio;
  VoidCallback onTapItem;
  VoidCallback onPressedRemover;
  // ignore: use_key_in_widget_constructors
  ItemAnuncio ({
    required this.anuncio,
    required this.onTapItem,
    required this.onPressedRemover
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapItem,//this.onTapItem
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              //Imagem
              SizedBox(
                width: 120,
                height: 120,
                child: Image.network(anuncio.fotos[0] ,fit: BoxFit.cover,),
                
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
                      Text("R\$ ${anuncio.preco}")
                    ],
                  ),
                ),
              ),
              // ignore: unnecessary_null_comparison
              if(onPressedRemover != null)  Expanded(//this.onPressedRemover
                flex: 1,
                child: ElevatedButton(
                  onPressed: onPressedRemover,//this.onPressedRemover
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.delete),
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
