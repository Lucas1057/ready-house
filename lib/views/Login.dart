

// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:flutter/material.dart';
import 'package:vendass/main.dart';
import 'package:vendass/models/usuario.dart';
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
        .then((FirebaseUser) {
      //redirecionar a principal
//-----------------------------------------------------------mudancas para pech



//-----------------------------------------------------------mudancas para pech

      Navigator.pushReplacementNamed(context, "/l");
    });
  }

  _validarCampos() {
    //recuperar dados dos sampos
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;
  

    if (email.isNotEmpty && email.contains("@") ) {
      if (senha.isNotEmpty && senha.length > 6 ) {
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
        foregroundColor: temaPadrao.foregroundColor,
        backgroundColor: temaPadraox.primaryColor,
        title: const Text(
          'READY HOUSE',
        ),
      ),
      backgroundColor: temaPadrao.backgroundColor,
      body: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(bottom: 32),
              child: Padding(
                padding: EdgeInsets.all(40.0),
                child: Center(
                    child: Text(
                  "READY HOUSE",
                  style: TextStyle(
                      color: Colors.white60,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
            InputCustomizado(
              controller: _controllerEmail,
              hint: "E-mail",
              obscure: false,
              autofocus: true,
              
              type: TextInputType.emailAddress,
              inputFormatters: const [],
              maxLines: 1,
              validator: (String) {},
              onSaved: (String) {},
            ),
            const SizedBox(height: 15,),
            InputCustomizado(
              controller: _controllerSenha,
              hint: "Senha",
              obscure: true,
              type: TextInputType.text,
              
              inputFormatters: const [],
              maxLines: 1,
              validator: (String) {},
              onSaved: (String) {},
            ),
            //-------------------------
             
            //-----------------------
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              
              const Text(
                'Logar',
                style: TextStyle(color: Colors.white),
              ),
              Switch(
                activeTrackColor: Colors.white24,
                inactiveTrackColor: Colors.white12,
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
              const Text(
                'Cadastrar',
                style: TextStyle(color: Colors.white),
              ),
            ]),
            BotaoCustomizado(
                texto: _textBotao,
                corTexto: Colors.black87,
                onPressed: () {
                  _validarCampos();
                })
                ,const SizedBox(height: 25,),
                GestureDetector(
                  child: const Text("Ir para anúncio",style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),onTap: (){
                  Navigator.pushReplacementNamed(context, "/l");
                 },
                ),
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
    );
  }
}



