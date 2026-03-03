import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tarea_flutter/src/model/incidencia_model.dart';
import 'package:tarea_flutter/src/pages/agregar_incidencias_page.dart';
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
    showLoading();
    try {
      final response =
          await http.get(Uri.parse('http://10.0.2.2:3000/incidencia'));
      if (response.statusCode == 200) {
        incidencias = incidenciaModelFromJson(response.body);
      }
    } catch (e) {
      Get.snackbar('Error', 'No se puedo conectar al servidor');
    } finally {
      hideLoading();
      update();
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
    showLoading();
    try {
      final response = await http
          .delete(Uri.parse('http://10.0.2.2:3000/incidencia/delete/$id'));
      if (response.statusCode == 200) {
        incidencias.removeAt(index);
        Get.snackbar('Exito', 'Se elimino la incidencia correctamente');
      } else {
        Get.snackbar('Error', 'No se pudo eliminar la incidencia');
      }
    } catch (e) {
      Get.snackbar('Error', 'Ocurrio un error : $e');
    } finally {
      hideLoading();
      update();
    }
  }
}
