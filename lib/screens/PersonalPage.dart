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
                // Nombre
                TextFormField(
                  initialValue: _persona.nombre,  // Asignamos directamente el valor
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa un nombre';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _persona.nombre = value;  // Actualizamos el valor directamente en la instancia de Persona
                    });
                  },
                ),
                // Apellidos
                TextFormField(
                  initialValue: _persona.apellidos,  // Asignamos directamente el valor
                  decoration: const InputDecoration(labelText: 'Apellidos'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa los apellidos';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _persona.apellidos = value;  // Actualizamos el valor directamente en la instancia de Persona
                    });
                  },
                ),
                // Correo electrónico
                TextFormField(
                  initialValue: _persona.correoElectronico,  // Asignamos directamente el valor
                  decoration: const InputDecoration(labelText: 'Correo Electrónico'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa un correo';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _persona.correoElectronico = value;  // Actualizamos el valor directamente en la instancia de Persona
                    });
                  },
                ),
                // Contraseña
                TextFormField(
                  initialValue: _persona.contrasena,  // Asignamos directamente el valor
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
                      _persona.contrasena = value;  // Actualizamos el valor directamente en la instancia de Persona
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
                        _persona.fechaNacimiento = pickedDate;  // Actualizamos la fecha en la instancia de Persona
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
