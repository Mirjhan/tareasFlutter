import 'package:get/get.dart';
import 'package:tarea_flutter/src/utils/core/arguments.dart';
import 'package:tarea_flutter/src/utils/domain/entities/error_entity.dart';
import 'package:tarea_flutter/src/incidencia/data/repositories/incidencias_repository_implementation.dart';
import 'package:tarea_flutter/src/utils/core/result_type.dart';
import 'package:tarea_flutter/src/incidencia/domain/entities/incidencia_entity.dart';
import 'package:tarea_flutter/src/incidencia/domain/use_cases/eliminar_incidencia_use_case.dart';
import 'package:tarea_flutter/src/incidencia/domain/use_cases/listar_incidencias_use_case.dart';
import 'package:tarea_flutter/src/incidencia/ui/pages/agregar%20incidencia/agregar_incidencias_page.dart';
import 'package:tarea_flutter/src/utils/ui/services/loading/loading_service.dart';
import 'package:tarea_flutter/src/utils/ui/widgets/alert_dialog_widget.dart';

class IncidenciasController extends GetxController {
  ListarIncidenciasUseCase listarIncidenciasUseCase =
      ListarIncidenciasUseCase(IncidenciasRepositoryImplementation());
  EliminarIncidenciaUseCase eliminarIncidenciaUseCase =
      EliminarIncidenciaUseCase(IncidenciasRepositoryImplementation());
  List<IncidenciaEntity> incidencias = [];

  @override
  void onReady() async {
    super.onReady();
    getIncidencias();
  }

  void goToAgregarIncidencia() async {
    final result =
        await Get.to<IncidenciaEntity>(() => AgregarIncidenciasPage());
    if (result != null) {
      incidencias.add(result);
      update();
    }
  }

  void goToEditarIncidencia(int index) async {
    final result = await Get.to<IncidenciaEntity>(
        () => AgregarIncidenciasPage(),
        arguments: {seleccionadaArgument: incidencias[index]});
    if (result != null) {
      incidencias[index] = result;
      update();
    }
  }

  Future<void> getIncidencias() async {
    showLoading();
    Result<List<IncidenciaEntity>> resultType =
        await listarIncidenciasUseCase.execute();

    switch (resultType) {
      case Success<List<IncidenciaEntity>>():
        incidencias = resultType.value;
        update();
        break;
      case Error<List<IncidenciaEntity>>():
        ErrorEntity error = resultType.error;
        Get.snackbar(error.title, error.description);
    }
    hideLoading();
  }

  Future<void> deleteIncidencia(int id) async {
    showLoading();
    Result<IncidenciaEntity> resultType =
        await eliminarIncidenciaUseCase.execute(id);

    switch (resultType) {
      case Success<IncidenciaEntity>():
        incidencias.removeWhere((e) => e.id == id);
        update();
        break;
      case Error<IncidenciaEntity>():
        ErrorEntity error = resultType.error;
        Get.snackbar(error.title, error.description);
        break;
    }
    hideLoading();
  }

  void confirmarDelete(int id) async {
    bool response = await showDialogWidget(
        context: Get.context!,
        title: 'Confirmar eliminacion',
        content: '¿Estás seguro de eliminar la incidencia $id');
    if (response == true) {
      deleteIncidencia(id);
    }
  }
}
