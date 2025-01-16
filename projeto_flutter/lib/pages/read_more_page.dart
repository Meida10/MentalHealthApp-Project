import 'package:flutter/material.dart';

class SaberMaisPage extends StatelessWidget {
  const SaberMaisPage({super.key});

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
                'assets/noticias2.png',
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
              const SizedBox(height: 16),
              const Text(
                "Casos de emergência na saúde mental tem aumentado nos mais jovens",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Há cada vez mais jovens a necessitar de ajuda imediata devido a problemas mentais!",
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
