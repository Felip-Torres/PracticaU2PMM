import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class WidgetPage extends StatefulWidget {
  const WidgetPage({super.key});

  @override
  _WidgetPageState createState() => _WidgetPageState();
}

class _WidgetPageState extends State<WidgetPage> {
  // Controlador del VideoPlayer
  late VideoPlayerController _controller;
  late double _currentSliderValue;
  late double _maxSliderValue;
  // Estado para controlar el volumen
  double _currentVolume = 0.5;  // Volumen inicial al 50%

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/Video/video.mp4')
      ..initialize().then((_) {
        setState(() {
          _currentSliderValue = 0.0; // Comenzamos en el inicio del video
          _maxSliderValue = _controller.value.duration.inSeconds.toDouble();
        });
      });

    // Actualizar el progreso del video cada vez que cambie
    _controller.addListener(() {
      setState(() {
        _currentSliderValue = _controller.value.position.inSeconds.toDouble();
      });
    });
  }

  // Método para actualizar el volumen
  void _setVolume(double value) {
    setState(() {
      _currentVolume = value;
      _controller.setVolume(_currentVolume); // Ajustamos el volumen
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Liberamos recursos
    super.dispose();
  }

  // Método para actualizar el progreso al mover el Slider
  void _onSliderChanged(double value) {
    final position = Duration(seconds: value.toInt());
    _controller.seekTo(position); // Actualizamos la posición del video
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Player'),
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

            // Video Player con la barra de progreso dentro del video
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                // Video
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

                // Barra de progreso sobre el video
                Positioned(
                  bottom: 10,
                  child: SizedBox(
                    width: 400,
                    child: Slider(
                      value: _currentSliderValue,
                      min: 0,
                      max: _maxSliderValue,
                      onChanged: (value) {
                        _onSliderChanged(value);
                      },
                      activeColor: Colors.blue,
                      inactiveColor: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),

            // Botón de play/pause
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
              },
              child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            ),

            const SizedBox(height: 20),

            // Slider para controlar el volumen
            const Text('Ajusta el volumen del video'),
            SizedBox(
              width: 200,
              child: Slider(
                value: _currentVolume,
                min: 0.0,
                max: 1.0,
                divisions: 100,
                label: (_currentVolume * 100).round().toString(),
                onChanged: (double value) {
                  _setVolume(value);
                },
              ),
            ),
            Text(
              'Volumen actual: ${( _currentVolume * 100).round()}%',
              style: const TextStyle(fontSize: 16),
            ),

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
