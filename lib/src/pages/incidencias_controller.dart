import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarea_flutter/src/model/incidencia_model.dart';
import 'package:tarea_flutter/src/pages/agregar_incidencias_page.dart';
import 'package:tarea_flutter/src/services/app_http_manager.dart';
import 'package:tarea_flutter/src/services/app_response.dart';
import 'package:tarea_flutter/src/widgets/loading_service.dart';

class IncidenciasController extends GetxController {
  List<IncidenciaModel> incidencias = [];

  @override
  void onReady() async {
    super.onReady();
    getIncidencias();
  }

  void goToAgregarIncidencia() async {
    final result =
        await Get.to<IncidenciaModel>(() => AgregarIncidenciasPage());
    if (result != null) {
      incidencias.add(result);
      update();
    }
  }

  void goToEditarIncidencia(int index) async {
    final result = await Get.to<IncidenciaModel>(() => AgregarIncidenciasPage(),
        arguments: {'seleccionada': incidencias[index]});
    if (result != null) {
      incidencias[index] = result;
      update();
    }
  }

  Future<void> getIncidencias() async {
    AppHttpManager appHttpManager = AppHttpManager();
    showLoading();
    AppResponse response = await appHttpManager.get(path: '/incidencia/');
    hideLoading();
    if (response.isSucces) {
      incidencias = incidenciaModelFromJson(response.body);
      update();
    } else {
      Get.snackbar('Error', 'Ocurrio un error');
    }
  }

  void confirmarDelete(int index) async {
    bool response = await Get.dialog(
      AlertDialog(
        title: Text('Confirmar eliminación'),
        content: Text(
            '¿Estas seguro de eliminar la incidencia ${incidencias[index].id} ?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: true),
            child: Text('Si'),
          ),
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text('No'),
          )
        ],
      ),
    );
    if (response == true) {
      deleteIncidencia(index);
    }
  }

  Future<void> deleteIncidencia(int index) async {
    final int id = incidencias[index].id!;
    AppHttpManager appHttpManager = AppHttpManager();
    showLoading();
    AppResponse response =
        await appHttpManager.delete(path: '/incidencia/delete/$id');
    hideLoading();
    if (response.isSucces) {
      incidencias.removeAt(index);
      update();
      Get.snackbar('Exito', 'Se elimino la incidencia correctamente');
    } else {
      Get.snackbar('Error', 'Ocurrio un error');
    }
  }
}
