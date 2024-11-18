class Persona {
  String nombre;
  String apellidos;
  DateTime fechaNacimiento;
  String correoElectronico;
  String contrasena;

  Persona({
    required this.nombre,
    required this.apellidos,
    required this.fechaNacimiento,
    required this.correoElectronico,
    required this.contrasena,
  });

  // Método para crear una copia modificada
  Persona copyWith({
    String? nombre,
    String? apellidos,
    DateTime? fechaNacimiento,
    String? correoElectronico,
    String? contrasena,
  }) {
    return Persona(
      nombre: nombre ?? this.nombre,
      apellidos: apellidos ?? this.apellidos,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
      correoElectronico: correoElectronico ?? this.correoElectronico,
      contrasena: contrasena ?? this.contrasena,
    );
  }
}
