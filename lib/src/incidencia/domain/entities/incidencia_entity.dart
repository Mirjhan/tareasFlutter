import 'dart:convert';

class IncidenciaEntity {
  int? id;
  String nombre;
  String descripcion;
  String estado;

  IncidenciaEntity({
    this.id,
    required this.nombre,
    required this.descripcion,
    required this.estado,
  });

  factory IncidenciaEntity.fromJson(Map<String, dynamic> json) =>
      IncidenciaEntity(
        id: json["id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        estado: json["estado"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
        "estado": estado,
      };
}

List<IncidenciaEntity> incidenciaEntityFromJson(String str) =>
    List<IncidenciaEntity>.from(
        json.decode(str).map((x) => IncidenciaEntity.fromJson(x)));

String incidenciaEntityToJson(List<IncidenciaEntity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
