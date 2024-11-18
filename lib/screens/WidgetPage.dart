import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class WidgetPage extends StatefulWidget {
  const WidgetPage({super.key});

  @override
  _WidgetPageState createState() => _WidgetPageState();
}

class _WidgetPageState extends State<WidgetPage> {
  // Estado para el Slider
  double _currentSliderValue = 50;

  // Controlador del VideoPlayer
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'dQw4w9WgXcQ',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Página de Widgets'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Texto descriptivo
            const Text(
              'Esta es la Página de Widgets',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),

            // Video Player
            SizedBox(
              width: 400,
              height: 225,
              child: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.blue,
                progressColors: const ProgressBarColors(
                  playedColor: Colors.blue,
                  handleColor: Colors.blueAccent,
                ),
                onReady: () {
                  debugPrint('Player is ready.');
                },
              ),
            ),
            const SizedBox(height: 20),

            Text('Ajusta el valor con el Slider'),
            // Slider
            SizedBox(
              width: 200,
              child: Slider(
                  value: _currentSliderValue,
                  max: 255,
                  divisions: 255,
                  label: _currentSliderValue.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderValue = value;
                    });
                  },
                  ),
            ),
            Text(
              'Valor actual: ${_currentSliderValue.round()}',
              style: const TextStyle(fontSize: 16),
            ),
            const Spacer(),

            // Botón para volver a la página principal
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Volver a la Página Principal'),
            ),
          ],
        ),
      ),
    );
  }
}
