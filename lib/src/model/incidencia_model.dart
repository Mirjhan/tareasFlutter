// To parse this JSON data, do
//
//     final incidenciaModel = incidenciaModelFromJson(jsonString);

import 'dart:convert';

class IncidenciaModel {
  int? id;
  String nombre;
  String descripcion;
  String estado;
  String? imagen;

  IncidenciaModel({
    this.id,
    required this.nombre,
    required this.descripcion,
    required this.estado,
    this.imagen,
  });

  factory IncidenciaModel.fromJson(Map<String, dynamic> json) =>
      IncidenciaModel(
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
        "imagen": imagen,
      };

  Map<String, dynamic> toCreateJson() => {
        "nombre": nombre,
        "descripcion": descripcion,
        "estado": estado,
        "imagen": imagen,
      };
}

List<IncidenciaModel> incidenciaModelFromJson(String str) =>
    List<IncidenciaModel>.from(
        json.decode(str).map((x) => IncidenciaModel.fromJson(x)));

String incidenciaModelToJson(List<IncidenciaModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
