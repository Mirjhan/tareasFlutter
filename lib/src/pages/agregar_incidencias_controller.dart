import 'package:get/get.dart';

class AgregarIncidenciasController extends GetxController {
  String nombre = '';
  String descripcion = '';
  String? estado;

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
}
