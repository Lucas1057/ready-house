import 'package:flutter/material.dart';

class Apagar extends StatefulWidget {
  const Apagar({super.key});

  @override
  State<Apagar> createState() => _ApagarState();
}

class _ApagarState extends State<Apagar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("imagem"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: GestureDetector(
              onTap: () {},
              child: CircleAvatar(
                backgroundColor: Colors.grey[400],
                radius: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_a_photo, size: 40, color: Colors.grey[100]),
                    Text(
                      "Adicionar",
                      style: TextStyle(color: Colors.grey[100], fontSize: 13),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
