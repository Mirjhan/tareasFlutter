import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:tarea_flutter/src/incidencia/data/error_entity.dart';
import 'package:tarea_flutter/src/incidencia/data/repositories/incidencias_repository_implementation.dart';
import 'package:tarea_flutter/src/incidencia/data/result_type.dart';
import 'package:tarea_flutter/src/incidencia/domain/entities/incidencia_entity.dart';
import 'package:tarea_flutter/src/incidencia/domain/use_cases/crear_incidencia_con_imagen_use_case.dart';
import 'package:tarea_flutter/src/incidencia/domain/use_cases/crear_incidencia_use_case.dart';
import 'package:tarea_flutter/src/incidencia/domain/use_cases/editar_incidencia_con_imagen_use_case.dart';
import 'package:tarea_flutter/src/incidencia/domain/use_cases/editar_incidencia_use_case.dart';
import 'package:tarea_flutter/src/utils/ui/services/loading/loading_service.dart';

class AgregarIncidenciasController extends GetxController {
  CrearIncidenciaUseCase crearIncidenciaUseCase =
      CrearIncidenciaUseCase(IncidenciasRepositoryImplementation());
  EditarIncidenciaUseCase editarIncidenciaUseCase =
      EditarIncidenciaUseCase(IncidenciasRepositoryImplementation());
  CrearIncidenciaConImagenUseCase crearIncidenciaConImagenUseCase =
      CrearIncidenciaConImagenUseCase(IncidenciasRepositoryImplementation());
  EditarIncidenciaConImagenUseCase editarIncidenciaConImagenUseCase =
      EditarIncidenciaConImagenUseCase(IncidenciasRepositoryImplementation());

  IncidenciaEntity? incidenciaSeleccionada;
  String? nombre;
  String? descripcion;
  String? estado;
  String? pathSelected;
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

  void picker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      pathSelected = result.files.single.path!;
      update();
    }
  }

  Future<void> crearIncidenciaConImagen() async {
    String? mensaje = validar();
    if (mensaje != null) {
      Get.snackbar(mensaje, 'Error');
      return;
    }
    if (pathSelected == null) {
      Get.snackbar('Error', 'Seleccione una imagen');
      return;
    }

    showLoading();
    final incidencia = IncidenciaEntity(
        nombre: nombre!, descripcion: descripcion!, estado: estado!);
    Result<IncidenciaEntity> resultType = await crearIncidenciaConImagenUseCase
        .execute(incidencia, pathSelected!);
    hideLoading();

    switch (resultType) {
      case Success<IncidenciaEntity>():
        Get.back(result: resultType.value);
        break;
      case Error<IncidenciaEntity>():
        ErrorEntity error = resultType.error;
        Get.snackbar(error.title, error.description);
    }
  }

  Future<void> editarIncidenciaConImagen() async {
    String? mensaje = validar();
    if (mensaje != null) {
      Get.snackbar(mensaje, 'ERror');
      return;
    }
    if (incidenciaSeleccionada?.imagen == null) {
      Get.snackbar('Error', 'Seleccione una imagen');
      return;
    }
    showLoading();
    final incidencia = IncidenciaEntity(
        id: incidenciaSeleccionada?.id,
        nombre: nombre!,
        descripcion: descripcion!,
        estado: estado!);
    Result<IncidenciaEntity> resultType = await editarIncidenciaConImagenUseCase
        .execute(incidencia, pathSelected);

    hideLoading();

    switch (resultType) {
      case Success<IncidenciaEntity>():
        incidenciaSeleccionada = resultType.value;
        Get.back(result: incidenciaSeleccionada);
        update();
        break;
      case Error<IncidenciaEntity>():
        ErrorEntity error = resultType.error;
        Get.snackbar(error.title, error.description);
    }
  }
}
