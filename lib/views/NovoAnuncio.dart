// ignore_for_file: unnecessary_null_comparison

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
  List<File> _listaImagens = [];
  final _formKey = GlobalKey<FormState>();

  ImagePicker imagePicker = ImagePicker();

  // ignore: unused_element
  _selecionarImagemGaleria() async {
    XFile? imagemEscolhida =
        await imagePicker.pickImage(source: ImageSource.gallery);

    File arquivoImagem = File(imagemEscolhida!.path);

    setState(() {
      _listaImagens.add(arquivoImagem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Anuncio'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                FormField<List>(
                  //lista de imagem
                  initialValue: _listaImagens,
                  validator: (imagens) {
                    //imagens.length
                    if (imagens!.length == 0) {
                      return "Necessario selecionar uma imagem!";
                    }
                    return null;
                  },
                  //builder constroi o widget
                  builder: (state) {
                    return Column(
                      children: [
                        Container(
                          height: 100,
                          child: ListView.builder(
                              //construir o listview
                              itemCount: _listaImagens.length + 1, //+1
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, indice) {
                                //indice = 0 == _listaImagens.length
                                if (indice == _listaImagens.length) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: GestureDetector(
                                      onTap: () {
                                        _selecionarImagemGaleria();
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Colors.grey[400],
                                        radius: 50,
                                        //backgroundImage: imageFile != null
                                        // ? FileImage(imageFile!)
                                        //: null,
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
                                if (_listaImagens.length > 0) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: GestureDetector(
                                      onTap: () {
                                        //----------------- parte oculta
                                        showDialog(
                                            context: context,
                                            builder: (context) => Dialog(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      BotaoCustomizado(
                                                          texto: "Excluir",
                                                          corTexto:
                                                              Colors.white,
                                                          onPressed: () {
                                                            setState(() {
                                                              _listaImagens
                                                                  .removeAt(
                                                                      indice);
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            });
                                                          })
                                                    ],
                                                  ),
                                                ));

                                        //-------------------------------------atew aqui
                                      },
                                      child: CircleAvatar(
                                        radius: 50,
                                        backgroundImage:
                                            FileImage(_listaImagens[indice]),
                                        child: Container(
                                          color: const Color.fromRGBO(
                                              255, 255, 255, 0.4),
                                          alignment: Alignment.center,
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                return Container();
                              }),
                        ),
                        if (state.hasError)
                          Container(
                            child: Text(
                              "[${state.errorText}]",
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 14),
                            ),
                          )
                      ],
                    );
                  },
                ),
//menus Dropdown --------------------------
                const Row(
                  children: [
                    Text('Estado'),
                    Text('Cartegoria'),
                  ],
                ),
                //Caixa de Texto
                Text("Caixas de Textos"),
                BotaoCustomizado(
                    texto: "Cadastrar anuncio",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        //================================================
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
