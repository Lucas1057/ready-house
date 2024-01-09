import 'package:flutter/material.dart';

final ThemeData temaPadrao = ThemeData(
  primaryColor: const Color(0xff9c27b0),
);

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _cadastrar = false;
  //bool _logar = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('olxz'),
      ),
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
            TextField(
              autofocus: true,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(fontSize: 20),
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                  hintText: "Email",
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6))),
            ),
            TextField(
              obscureText: true,
              keyboardType: TextInputType.text,
              style: const TextStyle(fontSize: 20),
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                  hintText: "Senha",
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6))),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text('Logar'),
              Switch(
                value: _cadastrar,
                onChanged: (bool valor) {
                  setState(() {
                    _cadastrar = valor;
                  });
                },
              ),
              const Text('Cadastrar')
            ]),
            ElevatedButton(
              onPressed: () {},
              child: const Text(
                'Entrar',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
