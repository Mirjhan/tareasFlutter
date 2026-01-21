import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tarea_flutter/src/model/incidencia_model.dart';
import 'package:tarea_flutter/src/pages/agregar_incidencias_page.dart';

class IncidenciasController extends GetxController {
  List<IncidenciaModel> incidencias = [];

  @override
  void onReady() async {
    getIncidencias();
    super.onReady();
  }

  void goToAgregarIncidencia() {
    Get.to(() => AgregarIncidenciasPage());
  }

  Future<void> getIncidencias() async {
    try {
      final response =
          await http.get(Uri.parse('http://10.0.2.2:3000/incidencia'));
      if (response.statusCode == 200) {
        incidencias = incidenciaModelFromJson(response.body);
      }
    } catch (e) {
      Get.snackbar('Error', 'No se puedo conectar al servidor');
    } finally {
      update();
    }
  }

  Future<void> deleteIncidencia(int index) async {
    final int id = incidencias[index].id;
    try {
      final response =
          await http.delete(Uri.parse('http://10.0.2.2:3000/incidencia/$id'));
      if (response.statusCode == 200) {
        incidencias.removeAt(index);
        Get.snackbar('Exito', 'Se elimino la incidencia correctamente');
      } else {
        Get.snackbar('Error', 'No se pudo eliminar la incidencia');
      }
    } catch (e) {
      Get.snackbar('Error', 'Ocurrio un error : $e');
    } finally {
      update();
    }
  }
}
