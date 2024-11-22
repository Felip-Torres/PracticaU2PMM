import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class WidgetPage extends StatefulWidget {
  const WidgetPage({super.key});

  @override
  _WidgetPageState createState() => _WidgetPageState();
}

class _WidgetPageState extends State<WidgetPage> {
  // Estado para el Slider
  double _currentSliderValue = 50;

  // Controlador del VideoPlayer
  late VideoPlayerController _controller;

  

  @override
  void initState() {
    
    super.initState();
    // Inicialitzem el controlador de vídeo
    _controller = VideoPlayerController.asset(
      'lib/Video/video.mp4',
    )..initialize().then((_) {
        setState(() {}); // Actualitzem l'estat quan el vídeo estigui llest
      }).catchError((error) {
        print('Error al inicializar el video: $error');
      });
  }

  @override
  void dispose() {
    _controller.dispose(); // Alliberem recursos
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
              child: _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : const Center(child: CircularProgressIndicator()),
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
