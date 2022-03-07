class Persona {
  String nombres;
  String telefono;
  String correo;
  String dni;

  Persona({this.nombres, this.telefono, this.correo, this.dni});

  factory Persona.fromJson(Map<String, dynamic> parsedJson) {
    return Persona(
      nombres: parsedJson['nombres'],
      telefono: parsedJson['telefono'],
      correo: parsedJson['correo'],
      dni: parsedJson['dni'],
    );
  }
}
