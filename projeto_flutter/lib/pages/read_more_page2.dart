import 'package:flutter/material.dart';

class SaberMaisPage2 extends StatelessWidget {
  const SaberMaisPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalhes"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/noticias.png',
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
              const SizedBox(height: 16),
              const Text(
                "Duplicou o número de alunos do ensino superior que dizem ter problemas de saúde mental",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Sim, é verdade, o número de alunos do ensino superior que dizem ter problemas de saúde mental aumentou!",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.inversePrimary,
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    width: 2.0,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Voltar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
