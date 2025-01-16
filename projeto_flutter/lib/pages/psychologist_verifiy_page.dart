import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'home_page.dart';

class PsychologistVerificationPage extends StatefulWidget {
  const PsychologistVerificationPage({super.key});

  @override
  _PsychologistVerificationPageState createState() =>
      _PsychologistVerificationPageState();
}

class _PsychologistVerificationPageState
    extends State<PsychologistVerificationPage> {
  File? _selectedImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Envie uma foto para verificação:'),
            const SizedBox(height: 20),
            _selectedImage != null
                ? Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.file(
                          _selectedImage!,
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  )
                : const Text('Nenhuma imagem selecionada'),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                side: const BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              onPressed: _pickImage,
              child: const Text(
                'Selecionar Foto',
                style: TextStyle(inherit: true),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                side: const BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              onPressed: _selectedImage != null
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Foto enviada com sucesso!'),
                        ),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                      );
                    }
                  : null,
              child: const Text(
                'Enviar Foto',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
