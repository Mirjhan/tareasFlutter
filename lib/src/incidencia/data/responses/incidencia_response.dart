import 'package:tarea_flutter/src/incidencia/domain/entities/incidencia_entity.dart';

class IncidenciaResponse {
  int? id;
  String nombre;
  String descripcion;
  String estado;
  String? imagen;

  IncidenciaResponse({
    this.id,
    required this.nombre,
    required this.descripcion,
    required this.estado,
    this.imagen,
  });

  factory IncidenciaResponse.fromJson(Map<String, dynamic> json) =>
      IncidenciaResponse(
        id: json["id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        estado: json["estado"],
        imagen: json["imagen"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
        "estado": estado,
      };

  IncidenciaEntity toDomain() => IncidenciaEntity(
      nombre: nombre, descripcion: descripcion, estado: estado);
}
