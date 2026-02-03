import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tarea_flutter/src/model/incidencia_model.dart';

class AgregarIncidenciasController extends GetxController {
  String nombre = '';
  String descripcion = '';
  String? estado;

  String? validar() {
    if (nombre.trim().isEmpty) return 'Nombre no debe ser vacío';

    if (descripcion.trim().isEmpty) return 'Descripción no debe ser vacío';

    if (estado == null || estado!.trim().isEmpty) return "Estado obligatorio";

    return null;
  }

  void onChangedNombre(String value) {
    nombre = value;
  }

  void onChangedDescripcion(String value) {
    descripcion = value;
  }

  void changeDropdownMenu(String? value) {
    estado = value;
    update();
  }

  Future<void> guardar() async {
    String? mensaje = validar();
    if (mensaje != null) {
      Get.snackbar(mensaje, 'Error');
    } else {
      final incidencia = IncidenciaModel(
          nombre: nombre, descripcion: descripcion, estado: estado!);
      final response = await http.post(
          Uri.parse('http://10.0.2.2:3000/incidencia/create'),
          body: incidencia.toCreateJson());

      if (response.statusCode == 200) {
        final nuevaIncidencia =
            IncidenciaModel.fromJson(jsonDecode(response.body));
        Get.snackbar('Exito', 'Agregado existosamente');
        Get.back(result: nuevaIncidencia);
      }
    }
  }
}
