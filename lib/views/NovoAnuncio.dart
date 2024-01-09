import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vendass/views/widgets/BotaoCustomizado.dart';

class NovoAnuncio extends StatefulWidget {
  const NovoAnuncio({super.key});

  @override
  State<NovoAnuncio> createState() => _NovoAnuncioState();
}

class _NovoAnuncioState extends State<NovoAnuncio> {
  final _formKey = GlobalKey<FormState>();
  _selecionarimagemGaleria() {}
  // ignore: unused_field, prefer_final_fields
  List<File> _listaImagens = List.empty();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Anuncio'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                FormField<List>(
                  initialValue: _listaImagens,
                  validator: (imagens) {
                    if (imagens?.length == 0) {
                      return "nacessario selecionar uma imagem!";
                    }
                    return null;
                  },
                  builder: (state) {
                    return Column(
                      children: [
                        Container(
                          height: 100,
                          child: ListView.builder(
                              itemCount: _listaImagens.length + 1,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, indice) {
                                //indice = 0 == _listaImagens.length
                                if (indice == _listaImagens.length) {
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    child: GestureDetector(
                                      onTap: () {
                                        _selecionarimagemGaleria();
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Colors.grey[400],
                                        radius: 50,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.add_a_photo,
                                                size: 40,
                                                color: Colors.grey[100]),
                                            Text(
                                              "Adicionar",
                                              style: TextStyle(
                                                  color: Colors.grey[100]),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                if (_listaImagens.length > 0) {}
                                return Container();
                              }),
                        ),
                        if (state.hasError)
                          Container(
                            child: Text("[${state.errorText}]"),
                          )
                      ],
                    );
                  },
                ),
//menus Dropdown
                const Row(
                  children: [
                    Text('Estado'),
                    Text('Caregoria'),
                  ],
                ),
              ],
            ),
            //Caixa de Texto
          ),
        ),
      ),
    );
  }
}
