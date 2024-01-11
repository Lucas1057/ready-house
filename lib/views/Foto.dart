import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Foto extends StatefulWidget {
  const Foto({super.key});

  @override
  State<Foto> createState() => _FotoState();
}

class _FotoState extends State<Foto> {
  //instanci do imge piker
  final imagePicker = ImagePicker();
  File? imageFile;
  //funcao pra add imagem
  Pick(ImageSource source) async {
    //variavel pickerFile
    final pickedFile = await imagePicker.pickImage(source: source);
    //verificar se o usuario vai de fato selecionar a imagem
    if (pickedFile != Null) {
      setState(() {
        imageFile = File(pickedFile!.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
                onTap: () {
                  // Navigator.of(context).pop();
                  Pick(ImageSource.gallery);
                },
                child: Stack(children: [
                  Container(
                    height: 200,
                    width: 300,
                    color: Colors.black,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[100],
                      child: CircleAvatar(
                        backgroundImage:
                            imageFile != null ? FileImage(imageFile!) : null,
                        radius: 95,
                        backgroundColor: Colors.grey[400],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 15,
                    right: 50,
                    child: CircleAvatar(
                      /* backgroundImage:
                          imageFile != null ? FileImage(imageFile!) : null,*/
                      backgroundColor: Colors.grey[100],
                      child: IconButton(
                        onPressed: () {
                          Pick(ImageSource.gallery);
                        },
                        icon: const Icon(Icons.draw_sharp),
                      ),
                    ),
                  )
                ]))
          ],
        ),
      ),
    );
  }
}
