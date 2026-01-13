// To parse this JSON data, do
//
//     final incidenciaModel = incidenciaModelFromJson(jsonString);

import 'dart:convert';

class IncidenciaModel {
  int id;
  String nombre;
  String descripcion;
  String estado;

  IncidenciaModel({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.estado,
  });

  factory IncidenciaModel.fromJson(Map<String, dynamic> json) =>
      IncidenciaModel(
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

List<IncidenciaModel> incidenciaModelFromJson(String str) =>
    List<IncidenciaModel>.from(
        json.decode(str).map((x) => IncidenciaModel.fromJson(x)));

String incidenciaModelToJson(List<IncidenciaModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
