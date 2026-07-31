import 'dart:convert';

class IncidenciaEntity {
  int? id;
  String nombre;
  String descripcion;
  String estado;
  String? imagen;

  IncidenciaEntity({
    this.id,
    required this.nombre,
    required this.descripcion,
    required this.estado,
    this.imagen,
  });

  factory IncidenciaEntity.fromJson(Map<String, dynamic> json) =>
      IncidenciaEntity(
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

  Map<String, String> toJsonFormDataCreateImage() => {
        "nombre": nombre,
        "descripcion": descripcion,
        "estado": estado,
      };

  Map<String, String> toJsonFormDataIpdateImage() => {
        "id": id!.toString(),
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
