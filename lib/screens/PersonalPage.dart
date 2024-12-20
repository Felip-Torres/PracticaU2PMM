import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../clases/Persona.dart';

class PersonalPage extends StatefulWidget {
  final Persona persona;

  const PersonalPage({super.key, required this.persona});

  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  final _formKey = GlobalKey<FormState>();
  late Persona _persona;

  @override
  void initState() {
    super.initState();
    _persona = widget.persona;  // Usamos la instancia de Persona directamente
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Torres'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nombre
                TextFormField(
                  initialValue: _persona.nombre,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa un nombre';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _persona.nombre = value;
                    });
                  },
                ),
                // Apellidos
                TextFormField(
                  initialValue: _persona.apellidos,
                  decoration: const InputDecoration(labelText: 'Apellidos'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa los apellidos';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _persona.apellidos = value;
                    });
                  },
                ),

                // Correo electrónico
                TextFormField(
                  initialValue: _persona.correoElectronico,
                  decoration: const InputDecoration(labelText: 'Correo Electrónico'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa un correo';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _persona.correoElectronico = value;
                    });
                  },
                ),

                // Contraseña
                TextFormField(
                  initialValue: _persona.contrasena,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Contraseña'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa una contraseña';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _persona.contrasena = value;
                    });
                  },
                ),

                // Fecha de nacimiento
                ListTile(
                  title: Text(
                    'Fecha de Nacimiento: ${DateFormat("dd/MM/yyyy").format(_persona.fechaNacimiento)}',
                  ),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: _persona.fechaNacimiento,
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null && pickedDate != _persona.fechaNacimiento) {
                      setState(() {
                        _persona.fechaNacimiento = pickedDate;
                      });
                    }
                  },
                ),
                const SizedBox(height: 20),
                
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Después de validar, retornamos la persona actualizada
                      Navigator.pop(context, _persona);
                    }
                  },
                  child: const Text('Guardar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
