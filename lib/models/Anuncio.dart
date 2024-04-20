import 'package:cloud_firestore/cloud_firestore.dart';

final anuncioRef = FirebaseFirestore.instance
    .collection("anuncios")
    .withConverter(
        fromFirestore: (snapshots, _) => Anuncio.fromJson(snapshots.data()!),
        toFirestore: (anuncio, _) => anuncio.toMap());

class Anuncio {
  String? _id;
  String? _estado;
  String? _categoria;
  String? _titulo;
  String? _preco;
  String? _telefone;
  String? _descricao;
  late List<String> _fotos; 

  Anuncio({
    String? id,
    String? estado,
    String? categoria,
    String? titulo,
    String? preco,
    String? telefone,
    String? descricao,
      List<String>? fotos,
  })  : _id = id,
        _estado = estado,
        _categoria = categoria,
        _titulo = titulo,
        _preco = preco,
        _telefone = telefone,
        _descricao = descricao,
         _fotos = fotos!
  ;

  Anuncio.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot.id;
    estado = documentSnapshot["estado"];
    categoria = documentSnapshot["categoria"];
    titulo = documentSnapshot["titulo"];
    preco = documentSnapshot["preco"];
    telefone = documentSnapshot["telefone"];
    descricao = documentSnapshot["descricao"];
     fotos = List<String>.from(documentSnapshot["fotos"]); 
  }

  Anuncio.gerarId() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference anuncios = db.collection("meus_anuncios");
    id = anuncios.doc().id;
  _fotos = [];

    
  }
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id": id,
      "estado": _estado,
      "categoria": _categoria,
      "titulo": _titulo,
      "preco":_preco,
      "telefone": telefone,
      "descricao":_descricao,
       "fotos": _fotos, 
    };
    return map;
  }

  List<String> get fotos => _fotos;/* ?? */ 

  set fotos(value) => _fotos = value;

  get categoria => _categoria;

  set categoria(value) => _categoria = value;

  get descricao => _descricao;

  set descricao(value) => _descricao = value;

  get estado => _estado;

  set estado(value) => _estado = value;

  get id => _id;

  set id(value) => _id = value;

  get preco => _preco;

  set preco(value) => _preco = value;

  get telefone => _telefone;

  set telefone(value) => _telefone = value;

  get titulo => _titulo;

  set titulo(value) => _titulo = value;

  factory Anuncio.fromJson(Map<String, dynamic> json) {
    return Anuncio(
      id: json['id'] ?? "",
      estado: json['estado'] ?? "",
      categoria: json['categioria'] ?? "",
      titulo: json['titulo'] ?? "",
      preco: json['preco'] ?? "",
      telefone: json['telefone'] ?? "",
      descricao: json['descricao'] ?? "",
        // fotos: json['fotos'] == null ? [] : json['fotos'].map((e)=> e).toList(), 
        fotos: (json['fotos'] as List<dynamic>?)
    ?.map((foto) => foto as String)
    .toList() ?? [],

    );
  }
}
