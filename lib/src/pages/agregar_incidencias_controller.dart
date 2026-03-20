import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:tarea_flutter/src/model/incidencia_model.dart';
import 'package:tarea_flutter/src/services/app_http_manager.dart';
import 'package:tarea_flutter/src/widgets/loading_service.dart';

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
      return;
    } else {
      AppHttpManager appHttpManager = AppHttpManager();
      showLoading();
      final incidencia = IncidenciaModel(
        nombre: nombre,
        descripcion: descripcion,
        estado: estado!,
      );
      final response = await appHttpManager.post(
          path: '/incidencia/create', body: incidencia.toCreateJson());
      hideLoading();
      if (response.isSucces) {
        final nuevaIncidencia =
            IncidenciaModel.fromJson(jsonDecode(response.body));
        Get.back(result: nuevaIncidencia);
        Get.snackbar('Exito', 'Agregado existosamente');
      } else {
        Get.snackbar('Error', 'Ocurrio un error');
      }
    }
  }

  Future<void> editar() async {
    String? mensaje = validar();
    if (mensaje != null) {
      Get.snackbar(mensaje, 'Error');
      return;
    } else {
      AppHttpManager appHttpManager = AppHttpManager();
      showLoading();
      final incidencia = IncidenciaModel(
        id: incidenciaSeleccionada?.id,
        nombre: nombre,
        descripcion: descripcion,
        estado: estado!,
      );
      final response = await appHttpManager.put(
        path: '/incidencia/update',
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: incidencia.toJson(),
      );
      hideLoading();
      if (response.isSucces) {
        final incidenciaActualizada =
            IncidenciaModel.fromJson(jsonDecode(response.body));
        Get.back(result: incidenciaActualizada);
      } else {
        Get.snackbar('Error', 'Ocurrio un error');
      }
    }
  }
}
