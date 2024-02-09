// ignore_for_file: file_names

class Usuario {
  late String _idUsuario;
  late String _nome;
  late String _email;
  late String _senha;

  Usuario();
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "idUsuario": _idUsuario,
      "nome": _nome,
      "email": _email,
    };
    return map;
  }

  // ignore: unnecessary_getters_setters
  String get senha => _senha;
  set senha(String value) {
    _senha = value;
  }

  // ignore: unnecessary_getters_setters
  String get email => _email;
  set email(String value) {
    _email = value;
  }

  // ignore: unnecessary_getters_setters
  String get idUsuario => _idUsuario;
  set idUsuario(String value) {
    _idUsuario = value;
  }

  // ignore: unnecessary_getters_setters
  String get nome => _nome;
  set nome(String value) {
    _nome = value;
  }
}
