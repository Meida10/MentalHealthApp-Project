import 'package:flutter/material.dart';
import 'package:projeto_flutter/pages/read_more_page2.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../components/my_drawer.dart';
import 'read_more_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late YoutubePlayerController _youtubeController;
  double _volume = 50;

  @override
  void initState() {
    super.initState();
    _youtubeController = YoutubePlayerController(
      initialVideoId: 'rQzSiiRe6YM',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    super.dispose();
  }

  void _updateVolume(double value) {
    setState(() {
      _volume = value;
    });
    _youtubeController.setVolume(value.toInt());
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      drawer: const MyDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  Image.asset(
                    isDarkTheme
                        ? 'assets/LogotipoSaudeMentalBranco.png'
                        : 'assets/LogotipoSaudeMentalPretoSemFundo.png',
                    height: 300,
                    width: 300,
                  ),
                ],
              ),
              const Text(
                "Grito de Silêncio",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      YoutubePlayer(
                        controller: _youtubeController,
                        showVideoProgressIndicator: true,
                        progressIndicatorColor: Colors.red,
                        onReady: () {},
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            const SizedBox(height: 8),
                            const Text(
                              "Volume",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Slider(
                              value: _volume,
                              min: 0,
                              max: 100,
                              divisions: 10,
                              label: _volume.toInt().toString(),
                              onChanged: _updateVolume,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Realizado por Ricardo Soares Araújo",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 5,
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/noticias.png',
                                  fit: BoxFit.cover,
                                  height: 100,
                                  width: double.infinity,
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Duplicou o número de alunos do ensino superior que dizem ter problemas de saúde mental",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary,
                                    textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    side: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary,
                                      width: 2.0,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SaberMaisPage2()),
                                    );
                                  },
                                  child: const Text("Saber mais"),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 5,
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/noticias2.png',
                                  fit: BoxFit.cover,
                                  height: 100,
                                  width: double.infinity,
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Casos de emergência na saúde mental tem aumentado nos mais jovens",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary,
                                    textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    side: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary,
                                      width: 2.0,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SaberMaisPage()),
                                    );
                                  },
                                  child: const Text("Saber mais"),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
