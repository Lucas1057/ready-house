

import 'dart:io';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:validadores/Validador.dart';
import 'package:vendass/main.dart';
import 'package:vendass/models/anuncio.dart';
import 'package:vendass/util/configuracoes.dart';
import 'package:vendass/views/widgets/BotaoCustomizado.dart';
import 'package:vendass/views/widgets/InputCustomizado.dart';


class NovoAnuncio extends StatefulWidget {
  const NovoAnuncio({super.key});

  @override
  State<NovoAnuncio> createState() => _NovoAnuncioState();
}

class _NovoAnuncioState extends State<NovoAnuncio> {
 
  final List<File> _listaImagens = [];
 
  List<DropdownMenuItem<String>> _listaItensDropEstados = [];
  
  List<DropdownMenuItem<String>> _listaItensDropCategorias = [];
  final _formKey = GlobalKey<FormState>();
  late Anuncio _anuncio;
  late BuildContext _dialogContext;
  //late String _itemSelecionadoEstado;
  //late String _itemSelecionadoCategoria;

  ImagePicker imagePicker = ImagePicker();


  _selecionarImagemGaleria() async {
    XFile? imagemEscolhida =
        await imagePicker.pickImage(source: ImageSource.gallery);

    File arquivoImagem = File(imagemEscolhida!
        .path);

    setState(() {
      _listaImagens.add(arquivoImagem);
    });
  }

  _abrirDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,//bloqueio de tela
        builder: (BuildContext context) {
          return const AlertDialog(
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              CircularProgressIndicator(),
              SizedBox(
                height: 20,
              ),
              Text("salvando anúncio")
            ]),
          );
        });
  }

  _salvarAnuncio() async {
    _abrirDialog(_dialogContext);
    //upload imagens no storage
    await _uploadImagens();
    

    //salvar anuncio no firestore
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore db = FirebaseFirestore.instance;
   
    User usuarioLogado = auth.currentUser!;
    String idUsuarioLogadoo = usuarioLogado.uid;
    db
        .collection("meus_anuncios")
        .doc(idUsuarioLogadoo)
        .collection("anuncios")
        .doc(_anuncio.id)
        .set(_anuncio.toMap())
        .then((_) {
          //salvar anuncio publico
          db.collection("anuncios")
          .doc(_anuncio.id)
          .set(_anuncio.toMap()).then((_) {// set no lugaar de setDate()
              Navigator.pop(_dialogContext);
      Navigator.pop(context);
          });
    
    });
  }

  Future _uploadImagens() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference pastaRaiz = storage.ref();
    for (var imagem in _listaImagens) {
      String nomeImagem = DateTime.now().millisecondsSinceEpoch.toString();
      Reference arquivo = pastaRaiz
          .child("meus_anuncios") //pasta
          .child(_anuncio.id) //id do anuncio
          .child(nomeImagem); //nome da imagem
      UploadTask uploadTask = arquivo.putFile(imagem);
      TaskSnapshot taskSnapshot = await uploadTask;
      String url = await taskSnapshot.ref.getDownloadURL();
      _anuncio.fotos.add(url);
    }
  }

  ///controler
  
  // ignore: unused_field
  final TextEditingController _controllerEstado = TextEditingController();
  // ignore: unused_field
  final TextEditingController _controllerCategoria = TextEditingController();
  final TextEditingController _controllerTitulo = TextEditingController();
  final TextEditingController _controllerPreco = TextEditingController();
  final TextEditingController _controllerTelefone = TextEditingController();
  final TextEditingController _controllerDescricao = TextEditingController();

  @override
  void initState() {
    super.initState();
    _carregarItensDropdown();

    _anuncio = Anuncio.gerarId();
  }

  _carregarItensDropdown() {
    //Categoria
    _listaItensDropCategorias = Configuracoes.getCategorias();
    //Estados

   _listaItensDropEstados = Configuracoes.getEstados();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Anuncio'),
        foregroundColor: temaPadrao.foregroundColor,
          backgroundColor: temaPadrao.backgroundColor,
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
             
                    if (imagens!.isEmpty) {
                      return "Necessario selecionar uma imagem!";
                    }
                    return null;
                  },
                  //builder constroi o widget
                  builder: (state) {
                    return Column(
                      children: [
                      
                        SizedBox(
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
                              
                                if (_listaImagens.isNotEmpty) {
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
                                                      Image.file(_listaImagens[
                                                          indice]),
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
                          Text(
                            "[${state.errorText}]",
                            style: const TextStyle(
                                color: Colors.red, fontSize: 14),
                          )
                      ],
                    );
                  },
                ),
//menus Dropdown --------------------------
                Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: DropdownButtonFormField(
                        // value: _itemSelecionadoEstado,
                        hint: const Text("Estados"),
                        onSaved: (estado) {
                          _anuncio.estado = estado!;
                        },

                        style: const TextStyle(color: Colors.black, fontSize: 20),
                        items: _listaItensDropEstados,
                        validator: (valor) {
                          return Validador().validar(Validador.DEFAULT_MESSAGE);
                        },
                        onChanged: (valor) {
                          setState(() {
                            //   _itemSelecionadoEstado = valor!;
                          });
                        },
                      ),
                    )),
                    //-----------------------------Categoria
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: DropdownButtonFormField(
                        // value: _itemSelecionadoEstado,
                        hint: const Text("Categoria"),
                        onSaved: (categoria) {
                          _anuncio.categoria = categoria!;
                        },
                        style: const TextStyle(color: Colors.black, fontSize: 20),
                        items: _listaItensDropCategorias,
                        validator: (valor) {
                          return Validador().validar(Validador.DEFAULT_MESSAGE);
                        },
                        onChanged: (valor) {
                          setState(() {
                            //   _itemSelecionadoEstado = valor!;
                          });
                        },
                      ),
                    )),
                  ],
                ),
                //Caixa de Texto----------------------------------------------
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: InputCustomizado(
                    hint: "Título",
                    obscure: false,
                    onSaved: (titulo) {
                      _anuncio.titulo = titulo;
                    },
                    validator: (valor) {
                      return Validador()
                          .add(Validar.OBRIGATORIO, msg: "campo obrigatório")
                          .valido(valor);
                    },
                    controller: _controllerTitulo,
                    inputFormatters: const [],
                    maxLines: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: InputCustomizado( 
                    hint: "Preço",
                    obscure: false,
                    type: TextInputType.number,
                    onSaved: (preco) {
                      _anuncio.preco = preco;
                    },
                    validator: (valor) {
                      return Validador()
                          .add(Validar.OBRIGATORIO, msg: "campo obrigatório")
                          .valido(valor);
                    },
                    controller: _controllerPreco,
                   inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      /* RealInputFormatter(moeda: true), */
                      CentavosInputFormatter(moeda: true)
                    ],
                    maxLines: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: InputCustomizado(
                    hint: "WhatsApp",
                    obscure: false,
                    type: TextInputType.phone,
                    onSaved: (telefone) {
                      _anuncio.telefone = telefone;
                    },
                    validator: (valor) {
                      return Validador()
                          .add(Validar.OBRIGATORIO, msg: "campo obrigatório")
                          .valido(valor);
                    },
                    controller: _controllerTelefone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      TelefoneInputFormatter()
                    ],
                    maxLines:  1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: InputCustomizado(
                    hint: "Descrição (200 caracteres)",
                    obscure: false,
                    onSaved: (descricao) {
                      _anuncio.descricao = descricao;
                    },
                    validator: (valor) {
                      return Validador()
                          .add(Validar.OBRIGATORIO, msg: "campo obrigatório")
                          .maxLength(200, msg: "Maximo de 200 caracteres")
                          .valido(valor);
                    },
                    controller: _controllerDescricao,
                    inputFormatters: const [],
                    maxLines: 3,
                  ),
                ),
                BotaoCustomizado(
                    texto: "Cadastrar anuncio",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        //================================================
                        //salvar cmpos
                        _formKey.currentState?.save();
                        //Configura dialog context
                        _dialogContext = context;

                        //salvar anuncio
                        _salvarAnuncio();
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
