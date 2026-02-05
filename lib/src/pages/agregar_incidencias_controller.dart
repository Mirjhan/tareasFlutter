import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tarea_flutter/src/model/incidencia_model.dart';

class AgregarIncidenciasController extends GetxController {
  IncidenciaModel? incidenciaSeleccionada;
  String nombre = '';
  String descripcion = '';
  String? estado;
  bool estaEditando = false;

  @override
  void onInit() {
    if (Get.arguments != null) {
      if (Get.arguments['seleccionada'] != null) {
        incidenciaSeleccionada =
            (Get.arguments['seleccionada'] as IncidenciaModel);

        nombre = incidenciaSeleccionada?.nombre ?? '';
        descripcion = incidenciaSeleccionada?.descripcion ?? '';
        estado = incidenciaSeleccionada?.estado ?? '';
        estaEditando = true;
      }
    }
    super.onInit();
  }

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

  Future<void> editar() async {
    String? mensaje = validar();
    if (mensaje != null) {
      Get.snackbar(mensaje, 'Error');
    } else {
      final incidencia = IncidenciaModel(
          id: incidenciaSeleccionada?.id,
          nombre: nombre,
          descripcion: descripcion,
          estado: estado!);
      final response = await http.put(
        Uri.parse('http://10.0.2.2:3000/incidencia/update'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(incidencia.toJson()),
      );
      if (response.statusCode == 200) {
        final incidenciaActualizada =
            IncidenciaModel.fromJson(jsonDecode(response.body));
        Get.back(result: incidenciaActualizada);
      }
    }
  }
}
