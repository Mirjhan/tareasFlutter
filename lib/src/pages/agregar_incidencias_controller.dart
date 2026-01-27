import 'package:get/get.dart';
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

  void guardar() {
    String? mensaje = validar();
    if (mensaje != null) {
      Get.snackbar(mensaje, 'Error');
    } else {
      final nuevaIncidencia = IncidenciaModel(
          nombre: nombre, descripcion: descripcion, estado: estado!);

      Get.back(result: nuevaIncidencia);
    }
  }
}
