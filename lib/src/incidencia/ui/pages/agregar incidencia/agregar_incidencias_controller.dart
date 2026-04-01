import 'package:get/get.dart';
import 'package:tarea_flutter/src/incidencia/data/repositories/incidencias_repository_implementation.dart';
import 'package:tarea_flutter/src/incidencia/domain/entities/incidencia_entity.dart';
import 'package:tarea_flutter/src/incidencia/domain/use_cases/crear_incidencia_use_case.dart';
import 'package:tarea_flutter/src/incidencia/domain/use_cases/editar_incidencia_use_case.dart';
import 'package:tarea_flutter/src/utils/ui/services/loading/loading_service.dart';

class AgregarIncidenciasController extends GetxController {
  CrearIncidenciaUseCase crearIncidenciaUseCase =
      CrearIncidenciaUseCase(IncidenciasRepositoryImplementation());
  EditarIncidenciaUseCase editarIncidenciaUseCase =
      EditarIncidenciaUseCase(IncidenciasRepositoryImplementation());

  IncidenciaEntity? incidenciaSeleccionada;
  String? nombre;
  String? descripcion;
  String? estado;
  bool estaEditando = false;

  @override
  void onInit() {
    if (Get.arguments != null) {
      if (Get.arguments['seleccionada'] != null) {
        incidenciaSeleccionada =
            (Get.arguments['seleccionada'] as IncidenciaEntity);

        nombre = incidenciaSeleccionada?.nombre ?? '';
        descripcion = incidenciaSeleccionada?.descripcion ?? '';
        estado = incidenciaSeleccionada?.estado ?? '';
        estaEditando = true;
      }
    }
    super.onInit();
  }

  String? validar() {
    if (nombre == null || nombre!.trim().isEmpty) {
      return 'Nombre es obligatorio';
    }
    if (descripcion == null || descripcion!.trim().isEmpty) {
      return 'Descripción es obligatorio';
    }
    if (estado == null || estado!.trim().isEmpty) {
      return "Estado es obligatorio";
    }
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

  Future<void> crearIncidencia() async {
    String? mensaje = validar();
    if (mensaje != null) {
      Get.snackbar(mensaje, 'Error');
      return;
    } else {
      showLoading();
      final incidencia = IncidenciaEntity(
          nombre: nombre!, descripcion: descripcion!, estado: estado!);
      await crearIncidenciaUseCase.execute(incidencia);
      hideLoading();
      Get.back(result: incidencia);
    }
  }

  Future<void> editarIncidencia() async {
    String? mensaje = validar();
    if (mensaje != null) {
      Get.snackbar(mensaje, 'Error');
      return;
    } else {
      showLoading();
      final incidencia = IncidenciaEntity(
        id: incidenciaSeleccionada?.id,
        nombre: nombre!,
        descripcion: descripcion!,
        estado: estado!,
      );
      await editarIncidenciaUseCase.execute(incidencia);
      hideLoading();
      Get.back(result: incidencia);
    }
  }
}
