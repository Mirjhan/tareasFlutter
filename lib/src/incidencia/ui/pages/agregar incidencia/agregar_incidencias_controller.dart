import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:tarea_flutter/src/utils/core/arguments.dart';
import 'package:tarea_flutter/src/incidencia/data/repositories/incidencias_repository_implementation.dart';
import 'package:tarea_flutter/src/utils/core/result_type.dart';
import 'package:tarea_flutter/src/incidencia/domain/entities/incidencia_entity.dart';
import 'package:tarea_flutter/src/incidencia/domain/use_cases/crear_incidencia_use_case.dart';
import 'package:tarea_flutter/src/incidencia/domain/use_cases/editar_imagen_use_case.dart';
import 'package:tarea_flutter/src/incidencia/domain/use_cases/editar_incidencia_use_case.dart';
import 'package:tarea_flutter/src/utils/ui/services/loading/loading_service.dart';

class AgregarIncidenciasController extends GetxController {
  CrearIncidenciaUseCase crearIncidenciaUseCase =
      CrearIncidenciaUseCase(IncidenciasRepositoryImplementation());
  EditarIncidenciaUseCase editarIncidenciaUseCase =
      EditarIncidenciaUseCase(IncidenciasRepositoryImplementation());
  EditarImagenUseCase editarImagenUseCase =
      EditarImagenUseCase(IncidenciasRepositoryImplementation());

  IncidenciaEntity? incidenciaSeleccionada;
  String? nombre;
  String? descripcion;
  String? estado;
  String? pathSelected;
  bool estaEditando = false;

  @override
  void onInit() {
    if (Get.arguments != null) {
      if (Get.arguments[seleccionadaArgument] != null) {
        incidenciaSeleccionada =
            (Get.arguments[seleccionadaArgument] as IncidenciaEntity);

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
      IncidenciaEntity incidencia = IncidenciaEntity(
          nombre: nombre!, descripcion: descripcion!, estado: estado!);
      final result = await crearIncidenciaUseCase.execute(incidencia);

      switch (result) {
        case Success<IncidenciaEntity>():
          incidencia = result.value;

          incidencia.imagen = await updateImagen(incidencia.id!);

          break;
        case Error():
          break;
      }

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
      IncidenciaEntity incidencia = IncidenciaEntity(
          id: incidenciaSeleccionada?.id,
          nombre: nombre!,
          descripcion: descripcion!,
          estado: estado!);
      final result = await editarIncidenciaUseCase.execute(incidencia);
      switch (result) {
        case Success<IncidenciaEntity>():
          incidencia = result.value;
          final imagenActualizada = await updateImagen(incidencia.id!);
          if (imagenActualizada != null) {
            incidencia.imagen = imagenActualizada;
          }
          break;
        case Error():
          break;
      }
      hideLoading();
      Get.back(result: incidencia);
    }
  }

  Future<String?> updateImagen(int id) async {
    if (pathSelected != null) {
      final resultImagen = await editarImagenUseCase.execute(id, pathSelected!);
      // executar el caso de uso de updateImagen
      switch (resultImagen) {
        case Success():
          return resultImagen.value.imagen;

        case Error():
          break;
      }
    }
    return null;
  }

  void picker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      pathSelected = result.files.single.path!;
      update();
    }
  }

  // EDITAR
  // EN EL PRIMER CASO DE USO ENVIAS EL CUERPO
  // ENVIAS LA IMAGEN
}
