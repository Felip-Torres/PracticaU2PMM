import 'package:flutter/material.dart';
import '../clases/Persona.dart';

class PersonalPage extends StatefulWidget {
  final Persona persona;

  const PersonalPage({super.key, required this.persona});

  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nombreController;
  late TextEditingController _apellidosController;
  late TextEditingController _correoController;
  late TextEditingController _contrasenaController;
  late DateTime _fechaNacimiento;

  @override
  void initState() {
    super.initState();
    // Inicializamos los controladores con los datos actuales
    _nombreController = TextEditingController(text: widget.persona.nombre);
    _apellidosController = TextEditingController(text: widget.persona.apellidos);
    _correoController = TextEditingController(text: widget.persona.correoElectronico);
    _contrasenaController = TextEditingController(text: widget.persona.contrasena);
    _fechaNacimiento = widget.persona.fechaNacimiento;
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidosController.dispose();
    _correoController.dispose();
    _contrasenaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Información Personal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nombreController,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa un nombre';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _apellidosController,
                  decoration: const InputDecoration(labelText: 'Apellidos'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa los apellidos';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _correoController,
                  decoration: const InputDecoration(labelText: 'Correo Electrónico'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa un correo';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _contrasenaController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Contraseña'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa una contraseña';
                    }
                    return null;
                  },
                ),
                // Fecha de nacimiento
                ListTile(
                  title: Text(
                    'Fecha de Nacimiento: ${_fechaNacimiento.toLocal()}'.split(' ')[0],
                  ),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: _fechaNacimiento,
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != _fechaNacimiento) {
                      setState(() {
                        _fechaNacimiento = pickedDate!;
                      });
                    }
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Crear una nueva persona con los valores modificados
                      Persona updatedPersona = widget.persona.copyWith(
                        nombre: _nombreController.text,
                        apellidos: _apellidosController.text,
                        correoElectronico: _correoController.text,
                        contrasena: _contrasenaController.text,
                        fechaNacimiento: _fechaNacimiento,
                      );

                      // Enviar de vuelta el objeto actualizado
                      Navigator.pop(context, updatedPersona);
                    }
                  },
                  child: const Text('Desa'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
