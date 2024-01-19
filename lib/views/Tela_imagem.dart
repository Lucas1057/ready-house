import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: camel_case_types
class Tela_imagem extends StatefulWidget {
  @override
  _Tela_imagemState createState() => _Tela_imagemState();
}

// ignore: camel_case_types
class _Tela_imagemState extends State<Tela_imagem> {
  List<String> imagens = [];

  @override
  void initState() {
    super.initState();
    imagens.add(
        "https://tse1.mm.bing.net/th?id=OIP.HJOG5YVQK0k17QUEvJYIJwHaJ3&pid=Api&rs=1&c=1&qlt=95&w=87&h=116");
    //"https://images.pexels.com/photos/255209/pexels-photo-255209.jpeg"
  }

  void adicionarImagem() {
    final ImagePicker picker = ImagePicker();
    final PickedFile imagemSelecionada =
        picker.pickImage(source: ImageSource.gallery) as PickedFile;

    // ignore: unnecessary_null_comparison
    if (imagemSelecionada != null) {
      imagens.add(imagemSelecionada.path);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de imagens',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('Lista de imagens'),
        ),
        body: Center(
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: imagens.map((imagem) {
              return GestureDetector(
                onTap: () {
                  adicionarImagem();
                },
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      child: Image.network(imagem),
                    ),
                    CircleAvatar(
                      /* backgroundImage:
                          imageFile != null ? FileImage(imageFile!) : null,*/
                      backgroundColor: Colors.grey[100],
                      child: IconButton(
                        onPressed: () {
                          adicionarImagem();
                        },
                        icon: const Icon(Icons.draw_sharp),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
