import 'package:flutter/material.dart';
import 'PersonalPage.dart';
import '../models/Persona.dart';
import 'WidgetPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Persona _persona;

  @override
  void initState() {
    super.initState();
    _persona = Persona(
      nombre: 'Felip',
      apellidos: 'Torres reines',
      fechaNacimiento: DateTime(2002, 19, 7),
      correoElectronico: 'ftr1500@gmail.com',
      contrasena: '1234',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Página Principal'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Nombre: ${_persona.nombre}', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Navegar a PersonalPage y esperar el objeto Persona actualizado
                final updatedPersona = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PersonalPage(persona: _persona),
                  ),
                );

                // Si se recibió un objeto actualizado, lo mostramos
                if (updatedPersona != null) {
                  setState(() {
                    _persona = updatedPersona;
                  });
                }
              },
              child: const Text('Editar Información'),
            ),
            
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navegar a la página de widgets
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WidgetPage()),
                );
              },
              child: const Text('Ir a la Página de Widgets'),
            ),
          ],
        ),
      ),
    );
  }
}
