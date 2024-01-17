import 'dart:io';
import 'package:flutter/foundation.dart';
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

  final imagePicker = ImagePicker();
  late Uint8List imagem = Uint8List(0);

  //funcao pra add imagem

  // ignore: non_constant_identifier_names
  _selecionarImagemGaleria(ImageSource source) async {
    try {
      final XFile? xfile = await imagePicker.pickImage(source: source);

      File imageN = File(xfile!.path);

      setState(() {
        imagem = imageN.readAsBytesSync();
      });
    } catch (e) {}
  }

  // ignore: unused_field, prefer_final_fields
  List<File> _listaImagens = List.empty();
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
                                        _selecionarImagemGaleria(
                                            ImageSource.gallery);
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Colors.grey[400],
                                        radius: 50,
                                        // backgroundImage:
                                        //  FileImage(_listaImagens[indice]),
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
                                        /*
                                        showDialog(
                                            context: context,
                                            builder: (context) => Dialog(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Image.file(
                                                        _listaImagens[indice],
                                                      ),
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
                                      */
                                      },
                                      child: CircleAvatar(
                                        radius: 50,
                                        // backgroundImage:
                                        // FileImage(_listaImagens[indice]),
                                        backgroundImage: imagem.isNotEmpty
                                            ? Image.memory(imagem).image
                                            : null,
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
