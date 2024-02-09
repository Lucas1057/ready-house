// ignore_for_file: unnecessary_this, file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class Anuncio {
  late String _id;
  late String _estado;
  late String _categoria;
  late String _titulo;
  late String _preco;
  late String _telefone;
  late String _descricao;
  late List<String> _fotos;

  Anuncio();
  Anuncio.fromDocumentSnapshot(DocumentSnapshot documentSnapshot){

    this.id = documentSnapshot.id;
    this.estado = documentSnapshot["estado"];
    this.categoria = documentSnapshot["categoria"];
    this.titulo = documentSnapshot["titulo"];
    this.preco = documentSnapshot["preco"];
    this.telefone = documentSnapshot["telefone"];
    this.descricao = documentSnapshot["descricao"];
    this.fotos = List<String>.from(documentSnapshot["fotos"]);
  }

         Anuncio.gerarId() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference anuncios = db.collection("meus_anuncios");
    this.id = anuncios.doc().id;
    //this._id = anuncios.document().documentID; //--------------------------------------------
    this._fotos = [];

    // ...
  }
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id": this.id,
      "estado": this._estado,
      "categoria": this._categoria,
      "titulo": this._titulo,
      "preco": this._preco,
      "telefone": telefone,
      "descricao": this._descricao,
      "fotos": this._fotos,
    };
    return map;
  }

  List<String> get fotos => this._fotos;

  set fotos(value) => this._fotos = value;

  get categoria => this._categoria;

  set categoria(value) => this._categoria = value;

  get descricao => this._descricao;

  set descricao(value) => this._descricao = value;

  get estado => this._estado;

  set estado(value) => this._estado = value;

  get id => this._id;

  set id(value) => this._id = value;

  get preco => this._preco;

  set preco(value) => this._preco = value;

  get telefone => this._telefone;

  set telefone(value) => this._telefone = value;

  get titulo => this._titulo;

  set titulo(value) => this._titulo = value;
}
