import 'dart:convert';

class UsuarioEntity {
  int? id;
  int idTipoDocumento;
  int idTipoUsuario;
  String nombre;
  String apellidos;
  String documento;
  String direccion;
  String telefono;
  String email;
  String password;
  dynamic latitud;
  dynamic longitud;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  UsuarioEntity({
    this.id,
    required this.idTipoDocumento,
    required this.idTipoUsuario,
    required this.nombre,
    required this.apellidos,
    required this.documento,
    required this.direccion,
    required this.telefono,
    required this.email,
    required this.password,
    this.latitud,
    this.longitud,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory UsuarioEntity.fromJson(Map<String, dynamic> json) => UsuarioEntity(
        id: json["id"],
        idTipoDocumento: json["id_tipo_documento"],
        idTipoUsuario: json["id_tipo_usuario"],
        nombre: json["nombre"],
        apellidos: json["apellidos"],
        documento: json["documento"],
        direccion: json["direccion"],
        telefono: json["telefono"],
        email: json["email"],
        password: json["password"],
        latitud: json["latitud"],
        longitud: json["longitud"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_tipo_documento": idTipoDocumento,
        "id_tipo_usuario": idTipoUsuario,
        "nombre": nombre,
        "apellidos": apellidos,
        "documento": documento,
        "direccion": direccion,
        "telefono": telefono,
        "email": email,
        "password": password,
        "latitud": latitud,
        "longitud": longitud,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "deletedAt": deletedAt,
      };
  Map<String, String> toJsonFormDataCreate() => {
        "id_tipo_documento": idTipoDocumento.toString(),
        "id_tipo_usuario": idTipoUsuario.toString(),
        "nombre": nombre,
        "apellidos": apellidos,
        "documento": documento,
        "direccion": direccion,
        "telefono": telefono,
        "email": email,
        "password": password,
        "latitud": latitud,
        "longitud": longitud,
      };
}

List<UsuarioEntity> usuarioEntityFromJson(String str) =>
    List<UsuarioEntity>.from(
        json.decode(str).map((x) => UsuarioEntity.fromJson(x)));

String usuarioEntityToJson(List<UsuarioEntity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
