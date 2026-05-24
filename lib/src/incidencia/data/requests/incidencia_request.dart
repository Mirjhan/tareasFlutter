class IncidenciaRequest {
  int? id;
  String nombre;
  String descripcion;
  String estado;
  String? imagen;

  IncidenciaRequest({
    this.id,
    required this.nombre,
    required this.descripcion,
    required this.estado,
    this.imagen,
  });

  factory IncidenciaRequest.fromJson(Map<String, dynamic> json) =>
      IncidenciaRequest(
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
