import 'package:flutter/material.dart';
import 'package:vendass/models/Usuario.dart';
import 'package:vendass/views/widgets/inputCustomizado.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vendass/views/widgets/BotaoCustomizado.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _controllerEmail =
      TextEditingController(text: "exemplo@gmail.com");
  final TextEditingController _controllerSenha =
      TextEditingController(text: "1234567");

  bool _cadastrar = false;
  String _mensagemErro = "";
  String _textBotao = "Entrar";

  _cadastrarUsuario(Usuario usuario) {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth
        .createUserWithEmailAndPassword(
            email: usuario.email, password: usuario.senha)
        // ignore: non_constant_identifier_names
        .then((FirebaseUser) {
      //redirecionar a tela principal
      Navigator.pushReplacementNamed(context, "/");
    });
  }

  _logarUsuario(Usuario usuario) {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth
        .signInWithEmailAndPassword(
            email: usuario.email, password: usuario.senha)
        // ignore: non_constant_identifier_names
        .then((FirebaseUser) {
      //redirecionar a principal
      Navigator.pushReplacementNamed(context, "/");
    });
  }

  _validarCampos() {
    //recuperar dados dos sampos
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if (email.isNotEmpty && email.contains("@")) {
      if (senha.isNotEmpty && senha.length > 6) {
//Configura usuarrio
        Usuario usuario = Usuario();
        usuario.email = email;
        usuario.senha = senha;

        //cadastrar ou logar
        if (_cadastrar) {
          //cadastrar
          _cadastrarUsuario(usuario);
//cadastrar
        } else {
//logar
          _logarUsuario(usuario);
        }
      } else {
        setState(() {
          _mensagemErro = "Preencha a senha! digite mais de 6 caracters";
        });
      }
    } else {
      setState(() {
        _mensagemErro = "Preencha o Email válido";
      });
    }
  }

  //bool _logar = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            'olx',
          ),
        ),
        backgroundColor: Colors.white,
        body: Container(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: Image.asset(
                  "imagens/logo.png",
                  width: 2,
                  height: 150,
                ),
              ),
              InputCustomizado(
                controller: _controllerEmail,
                hint: "E-mail",
                autofocus: true,
                type: TextInputType.emailAddress,
              ),
              InputCustomizado(
                controller: _controllerSenha,
                hint: "Senha",
                obscure: true,
                type: TextInputType.text,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text('Logar'),
                Switch(
                  value: _cadastrar,
                  onChanged: (bool valor) {
                    setState(() {
                      _cadastrar = valor;
                      _textBotao = "Entrar";

                      if (_cadastrar) {
                        _textBotao = "Cadastrar";
                      }
                    });
                  },
                ),
                const Text('Cadastrar')
              ]),
              BotaoCustomizado(
                  texto: _textBotao,
                  corTexto: Colors.white,
                  onPressed: () {
                    _validarCampos();
                  }),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  _mensagemErro,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              )
            ],
          )),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.settings),
          onPressed: () {
            Navigator.pushReplacementNamed(context, "/apagar");
          },
        ));
  }
}
